import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'themes.dart';

void main() {
  runApp(const ReignMissionControl());
}

class ReignMissionControl extends StatelessWidget {
  const ReignMissionControl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REIGN Mission Control',
      theme: AppTheme.theme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
