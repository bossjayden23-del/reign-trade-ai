import 'package:flutter/material.dart';

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder - toggling not implemented here
    final online = true;
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: online ? Colors.greenAccent : Colors.redAccent, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(online ? 'Online' : 'Offline', style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}
