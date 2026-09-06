import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Developer Mode')),
      body: const Center(child: Text('Developer tools (placeholder)', style: TextStyle(color: Colors.white70))),
      backgroundColor: const Color(0xFF05070D),
    );
  }
}
