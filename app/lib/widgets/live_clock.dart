import 'package:flutter/material.dart';
import 'dart:async';

class LiveClock extends StatefulWidget {
  const LiveClock({super.key});

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  late String _time;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _time = _format(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _time = _format(DateTime.now());
      });
    });
  }

  String _format(DateTime d) => '${_two(d.hour)}:${_two(d.minute)}:${_two(d.second)}';
  String _two(int v) => v.toString().padLeft(2, '0');

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, color: Colors.white70, size: 18),
        const SizedBox(width: 8),
        Text(_time, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
