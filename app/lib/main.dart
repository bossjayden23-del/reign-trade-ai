import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'themes.dart';
import 'providers/market_provider.dart';

void main() {
  runApp(const ReignTradeApp());
}

class ReignTradeApp extends StatelessWidget {
  const ReignTradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MarketProvider>(
      create: (_) => MarketProvider()..init(),
      child: MaterialApp(
        title: 'REIGN OS V1',
        theme: AppTheme.theme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
