class Tick {
  final String symbol;
  final double price;
  final int epoch;

  Tick({required this.symbol, required this.price, required this.epoch});

  factory Tick.fromMap(Map<String, dynamic> map) {
    final symbol = map['symbol'] as String? ?? '';
    final quote = map['quote'] as String? ?? '';
    final price = double.tryParse(quote) ?? 0.0;
    final epoch = map['epoch'] as int? ?? 0;
    return Tick(symbol: symbol, price: price, epoch: epoch);
  }
}
