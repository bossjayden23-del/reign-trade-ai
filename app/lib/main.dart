import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'themes.dart';

void main() {
  runApp(const ReignTradeApp());
}

class ReignTradeApp extends StatelessWidget {
  const ReignTradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REIGN OS V1',
      theme: AppTheme.theme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
