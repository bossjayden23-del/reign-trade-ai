import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF05070D);
  static const Color neonBlue = Color(0xFF00BFFF);

  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    primaryColor: neonBlue,
    colorScheme: ColorScheme.dark(primary: neonBlue),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
