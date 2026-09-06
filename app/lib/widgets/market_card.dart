import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class MarketCard extends StatelessWidget {
  final String symbol;
  final double price;
  final int confidence;
  final bool trendUp;

  const MarketCard({required this.symbol, required this.price, required this.confidence, required this.trendUp, super.key});

  @override
  Widget build(BuildContext context) {
    final trendColor = trendUp ? Colors.greenAccent : Colors.redAccent;
    final trendIcon = trendUp ? Icons.arrow_upward : Icons.arrow_downward;
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(symbol, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Row(children: [Icon(trendIcon, color: trendColor, size: 18), const SizedBox(width: 6), Text('${confidence}%', style: TextStyle(color: Colors.white70))]),
            ],
          ),
          const SizedBox(height: 8),
          Text(' ${price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Chip(label: Text('BUY', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green),
              Chip(label: Text('HOLD', style: TextStyle(color: Colors.white)), backgroundColor: Colors.blueGrey),
              Chip(label: Text('SELL', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
