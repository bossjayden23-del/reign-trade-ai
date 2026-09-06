import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/market_provider.dart';
import 'confidence_meter.dart';

class MarketPanel extends StatelessWidget {
  const MarketPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MarketProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Market Scanner', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  _buildConnectionBadge(provider.state),
                  const SizedBox(width: 8),
                  ConfidenceMeter(value: provider.confidence),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: provider.symbols.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final symbol = provider.symbols[index];
                final tick = provider.ticks[symbol];
                final priceStr = tick != null ? tick.price.toStringAsFixed(2) : '--';
                return _MarketCard(symbol: symbol, price: priceStr);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionBadge(DerivConnectionState state) {
    Color color;
    String label;
    switch (state) {
      case DerivConnectionState.connecting:
        color = Colors.orangeAccent;
        label = 'Connecting';
        break;
      case DerivConnectionState.connected:
        color = Colors.greenAccent;
        label = 'Connected';
        break;
      case DerivConnectionState.reconnecting:
        color = Colors.yellowAccent;
        label = 'Reconnecting';
        break;
      case DerivConnectionState.offline:
      default:
        color = Colors.redAccent;
        label = 'Offline';
        break;
    }
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class _MarketCard extends StatelessWidget {
  final String symbol;
  final String price;

  const _MarketCard({required this.symbol, required this.price, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.06)),
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.03), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(symbol, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          Row(
            children: const [
              Icon(Icons.arrow_drop_up, color: Colors.greenAccent, size: 18),
              SizedBox(width: 4),
              Text('Live', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
