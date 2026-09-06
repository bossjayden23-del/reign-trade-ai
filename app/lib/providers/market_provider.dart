import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/tick.dart';
import '../services/deriv_ws_service.dart';

class MarketProvider extends ChangeNotifier {
  final List<String> _symbols = ['R_10', 'R_25', 'R_50', 'R_75', 'R_100'];
  final Map<String, Tick> _ticks = {};
  DerivWebSocketService? _service;
  DerivConnectionState _state = DerivConnectionState.offline;
  double _confidence = 0.42; // placeholder

  List<String> get symbols => List.unmodifiable(_symbols);
  Map<String, Tick> get ticks => Map.unmodifiable(_ticks);
  DerivConnectionState get state => _state;
  double get confidence => _confidence;

  void init() {
    _service = DerivWebSocketService(symbols: _symbols, onTick: _handleTick, onStateChange: _handleState);
    _service!.start();
    // small periodic update to adjust experimental confidence (placeholder)
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 5));
      _confidence = (0.4 + Random().nextDouble() * 0.6);
      notifyListeners();
      return true;
    });
  }

  void disposeService() {
    _service?.stop();
    _service = null;
  }

  void _handleTick(Map<String, dynamic> tickMap) {
    try {
      final tick = Tick.fromMap(tickMap);
      _ticks[tick.symbol] = tick;
      notifyListeners();
    } catch (e, st) {
      log('Tick handling error: $e', error: e, stackTrace: st);
    }
  }

  void _handleState(DerivConnectionState s) {
    _state = s;
    notifyListeners();
  }
}
