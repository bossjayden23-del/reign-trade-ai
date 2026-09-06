import 'package:flutter/material.dart';
import '../widgets/crown_logo.dart';
import '../widgets/live_clock.dart';
import '../widgets/connection_status.dart';
import '../widgets/ai_core.dart';
import '../widgets/market_card.dart';
import '../widgets/guardian_shield.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const symbols = ['R_10', 'R_25', 'R_50', 'R_75', 'R_100'];
    return Scaffold(
      backgroundColor: const Color(0xFF05070D),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const CrownLogo(),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  LiveClock(),
                  ConnectionStatus(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: AiCore()),
                  SizedBox(width: 12),
                  GuardianShield(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: symbols.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final sym = symbols[index];
                    return MarketCard(
                      symbol: sym,
                      price: 1234.56 + index.toDouble(),
                      confidence: 70 - index * 5,
                      trendUp: index % 2 == 0,
                    );
                  },
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
