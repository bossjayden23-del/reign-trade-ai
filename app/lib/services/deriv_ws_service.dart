import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/web_socket_channel.dart';

typedef TickCallback = void Function(Map<String, dynamic> tickMap);

enum DerivConnectionState { connecting, connected, reconnecting, offline }

class DerivWebSocketService {
  final List<String> symbols;
  final TickCallback onTick;
  final void Function(DerivConnectionState)? onStateChange;

  WebSocketChannel? _channel;
  DerivConnectionState _state = DerivConnectionState.offline;
  bool _manualClose = false;

  int _retryCount = 0;
  Timer? _reconnectTimer;

  DerivWebSocketService({required this.symbols, required this.onTick, this.onStateChange});

  DerivConnectionState get state => _state;

  void _setState(DerivConnectionState newState) {
    _state = newState;
    if (onStateChange != null) {
      onStateChange!(newState);
    }
    log('DerivWS state: $_state');
  }

  void start() {
    _manualClose = false;
    _connect();
  }

  void stop() {
    _manualClose = true;
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _setState(DerivConnectionState.offline);
  }

  void _connect() {
    _setState(_retryCount == 0 ? DerivConnectionState.connecting : DerivConnectionState.reconnecting);
    try {
      // Public app_id 1089 (read-only usage). Replace with your app_id if available.
      final uri = Uri.parse('wss://ws.binaryws.com/websockets/v3?app_id=1089');
      _channel = WebSocketChannel.connect(uri);
      _channel!.stream.listen(_onMessage, onError: _onError, onDone: _onDone, cancelOnError: true);

      // After small delay ensure connection established before subscribing
      Future.delayed(const Duration(milliseconds: 400), () {
        _subscribeAll();
      });

      _retryCount = 0;
      _setState(DerivConnectionState.connected);
      log('Connected to Deriv WebSocket');
    } catch (e, st) {
      log('Connection error: $e', error: e, stackTrace: st);
      _handleReconnect();
    }
  }

  void _onMessage(dynamic message) {
    try {
      final data = json.decode(message as String) as Map<String, dynamic>;
      if (data.containsKey('tick')) {
        final tick = data['tick'] as Map<String, dynamic>;
        onTick(tick);
      } else if (data.containsKey('error')) {
        log('Deriv error: ${data['error']}');
      } else {
        // ignore other messages
      }
    } catch (e, st) {
      log('Message parse error: $e', error: e, stackTrace: st);
    }
  }

  void _onError(dynamic error) {
    log('WebSocket error: $error');
    _handleReconnect();
  }

  void _onDone() {
    log('WebSocket connection closed');
    if (!_manualClose) {
      _handleReconnect();
    } else {
      _setState(DerivConnectionState.offline);
    }
  }

  void _handleReconnect() {
    _retryCount += 1;
    _setState(DerivConnectionState.reconnecting);
    final delaySeconds = _computeBackoff(_retryCount);
    log('Reconnecting in ${delaySeconds}s (attempt $_retryCount)');
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: delaySeconds), () {
      if (!_manualClose) {
        _connect();
      }
    });
  }

  int _computeBackoff(int attempt) {
    final max = 64;
    final base = 1 << (attempt - 1);
    final val = base < max ? base : max;
    // jitter +-25%
    final jitter = (val * 0.25).toInt();
    final rnd = val - jitter + (DateTime.now().millisecondsSinceEpoch % (jitter * 2 + 1));
    return rnd;
  }

  void _subscribeAll() {
    if (_channel == null) return;
    for (final s in symbols) {
      final msg = json.encode({'ticks': s, 'subscribe': 1});
      _channel!.sink.add(msg);
      log('Subscribed to $s');
    }
  }
}
