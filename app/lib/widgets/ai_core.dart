import 'package:flutter/material.dart';
import '../themes.dart';

class AiCore extends StatefulWidget {
  const AiCore({super.key});

  @override
  State<AiCore> createState() => _AiCoreState();
}

class _AiCoreState extends State<AiCore> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final scale = 0.9 + (_controller.value * 0.2);
        final blur = 8 + (_controller.value * 16);
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.neonBlue.withOpacity(0.06)),
          ),
          child: Column(
            children: [
              Transform.scale(
                scale: scale,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [AppTheme.neonBlue.withOpacity(0.95), Colors.transparent]),
                    boxShadow: [BoxShadow(color: AppTheme.neonBlue.withOpacity(0.35), blurRadius: blur, spreadRadius: 6)],
                    border: Border.all(color: AppTheme.neonBlue.withOpacity(0.2), width: 1.2),
                  ),
                  child: const Center(child: Icon(Icons.bolt, color: Colors.black87, size: 40)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('AI CORE', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Pulsing Observer', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}
