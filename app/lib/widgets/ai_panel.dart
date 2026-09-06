import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/market_provider.dart';
import '../ai/ai_provider.dart';

class AiPanel extends StatelessWidget {
  final String symbol;

  const AiPanel({required this.symbol, super.key});

  @override
  Widget build(BuildContext context) {
    final ai = Provider.of<AiProvider>(context);
    final market = Provider.of<MarketProvider>(context);
    final analysis = ai.lastFor(symbol);
    final tick = market.ticks[symbol];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI Brain (Observer)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Symbol: $symbol', style: const TextStyle(color: Colors.white70)),
              Text('Price: ${tick != null ? tick.price.toStringAsFixed(2) : '--'}', style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 12),
          if (analysis != null) ...[
            Text('Confidence: ${analysis.confidence} (Experimental)', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                child: LinearProgressIndicator(value: analysis.confidence / 100.0, color: Theme.of(context).primaryColor, backgroundColor: Colors.white12),
              ),
              const SizedBox(width: 8),
              Text('${analysis.confidence}%', style: const TextStyle(color: Colors.white70)),
            ],),
            const SizedBox(height: 12),
            const Text('Why this score?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final r in analysis.reasons)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text('• $r', style: const TextStyle(color: Colors.white70)),
              ),
          ] else
            const Text('Waiting for enough ticks to analyze...', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
