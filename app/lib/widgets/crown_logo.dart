import 'package:flutter/material.dart';
import '../themes.dart';

class CrownLogo extends StatefulWidget {
  const CrownLogo({super.key});

  @override
  State<CrownLogo> createState() => _CrownLogoState();
}

class _CrownLogoState extends State<CrownLogo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final glow = 8 + (_controller.value * 12);
          final spread = 1 + (_controller.value * 3);
          return Hero(
            tag: 'crown-logo',
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.neonBlue.withOpacity(0.6),
                    blurRadius: glow,
                    spreadRadius: spread,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.neonBlue.withOpacity(0.3), width: 1.5),
                ),
                child: Icon(
                  Icons.emoji_events, // trophy-like icon used as crown placeholder
                  color: AppTheme.neonBlue,
                  size: 36,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
