import 'package:flutter/material.dart';
import '../themes.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key});

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  bool _connected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<DateTime>(
            stream: Stream<DateTime>.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
            builder: (context, snapshot) {
              final now = snapshot.data ?? DateTime.now();
              final timeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
              return Row(
                children: [
                  Icon(Icons.access_time, color: AppTheme.neonBlue.withOpacity(0.9), size: 18),
                  const SizedBox(width: 8),
                  Text(timeStr, style: TextStyle(color: AppTheme.neonBlue.withOpacity(0.95), fontWeight: FontWeight.w600)),
                ],
              );
            },
          ),
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _connected ? Colors.greenAccent : Colors.redAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_connected ? Colors.greenAccent : Colors.redAccent).withOpacity(0.6),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(_connected ? 'Connected' : 'Disconnected', style: const TextStyle(color: Colors.white70)),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => setState(() => _connected = !_connected),
                icon: const Icon(Icons.sync, color: Colors.white24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
