import 'package:flutter/material.dart';

class ConfidenceMeter extends StatelessWidget {
  final double value; // 0.0 - 1.0

  const ConfidenceMeter({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final pct = (value * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Text('Confidence', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.9), fontSize: 11)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(6)),
              child: const Text('Experimental', style: TextStyle(color: Colors.white70, fontSize: 10)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(width: 100, height: 10, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(6))),
            Container(width: (value.clamp(0.0, 1.0) * 100).toDouble(), height: 10, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6))),
          ],
        ),
        const SizedBox(height: 4),
        Text('$pct%', style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}
