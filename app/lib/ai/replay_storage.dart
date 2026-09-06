import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/tick.dart';

class ReplayStorage {
  final String filename;
  final Map<String, List<Tick>> _buffers = {};
  Directory? _dir;

  ReplayStorage({this.filename = 'replay_ticks.json'});

  Future<void> init() async {
    _dir = await getApplicationDocumentsDirectory();
    // ensure file exists
    final file = File('${_dir!.path}/$filename');
    if (!file.existsSync()) {
      try {
        file.writeAsStringSync(json.encode({}));
      } catch (e) {
        log('ReplayStorage init write error: $e');
      }
    }
  }

  void addTick(String symbol, Tick tick) {
    final buf = _buffers.putIfAbsent(symbol, () => <Tick>[]);
    buf.add(tick);
    if (buf.length > 1000) {
      buf.removeRange(0, buf.length - 1000);
    }
    // persist asynchronously
    _persist();
  }

  List<Tick> getTicks(String symbol) => List.unmodifiable(_buffers[symbol] ?? []);

  Future<void> _persist() async {
    if (_dir == null) {
      try {
        _dir = await getApplicationDocumentsDirectory();
      } catch (e) {
        log('ReplayStorage persist: cannot get dir: $e');
        return;
      }
    }
    final file = File('${_dir!.path}/$filename');
    final map = <String, List<Map<String, dynamic>>>{};
    for (final entry in _buffers.entries) {
      map[entry.key] = entry.value.map((t) => {'symbol': t.symbol, 'price': t.price, 'epoch': t.epoch}).toList();
    }
    try {
      await file.writeAsString(json.encode(map));
    } catch (e) {
      log('ReplayStorage write error: $e');
    }
  }
}
