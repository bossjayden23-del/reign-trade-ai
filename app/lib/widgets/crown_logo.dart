import 'package:flutter/material.dart';
import '../themes.dart';
import 'developer_screen.dart';

class CrownLogo extends StatefulWidget {
  const CrownLogo({super.key});

  @override
  State<CrownLogo> createState() => _CrownLogoState();
}

class _CrownLogoState extends State<CrownLogo> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DeveloperScreen()));
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          final glow = 6 + (_ctrl.value * 14);
          return Center(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppTheme.neonBlue.withOpacity(0.6), blurRadius: glow, spreadRadius: 1.5),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF05070D),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.neonBlue.withOpacity(0.25), width: 1.5),
                ),
                child: Icon(Icons.emoji_events, color: AppTheme.neonBlue, size: 40),
              ),
            ),
          );
        },
      ),
    );
  }
}
