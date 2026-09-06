import 'package:flutter/material.dart';

class GuardianShield extends StatelessWidget {
  const GuardianShield({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: const [
          Icon(Icons.shield, color: Colors.lightGreenAccent, size: 36),
          SizedBox(height: 8),
          Text('GUARDIAN SHIELD', style: TextStyle(color: Colors.white70, fontSize: 12), textAlign: TextAlign.center),
          SizedBox(height: 8),
          Text('SAFE', style: TextStyle(color: Colors.lightGreenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
