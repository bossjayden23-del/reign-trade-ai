import 'dart:math';

/// Scoring functions used by the REIGN AI Brain V1.
/// These functions are pure and have unit tests in test/scoring_test.dart

double _mean(List<double> xs) {
  if (xs.isEmpty) return 0.0;
  return xs.reduce((a, b) => a + b) / xs.length;
}

double _stdev(List<double> xs) {
  if (xs.length <= 1) return 0.0;
  final mean = _mean(xs);
  final variance = xs.map((x) => (x - mean) * (x - mean)).reduce((a, b) => a + b) / (xs.length - 1);
  return sqrt(variance);
}

/// Volatility score: normalized stdev over prices, scaled 0..100
double volatilityScore(List<double> prices) {
  if (prices.length < 2) return 0.0;
  final returns = <double>[];
  for (var i = 1; i < prices.length; i++) {
    final prev = prices[i - 1];
    if (prev <= 0) continue;
    returns.add((prices[i] - prev) / prev);
  }
  if (returns.isEmpty) return 0.0;
  final stdev = _stdev(returns);
  // assume reasonable stdev of 0.02 maps to 100
  final score = (stdev / 0.02) * 100.0;
  return score.clamp(0.0, 100.0);
}

/// Momentum score: recent return vs older average, scaled 0..100, signed
double momentumScore(List<double> prices) {
  if (prices.length < 2) return 0.0;
  final latest = prices.last;
  final mean = _mean(prices);
  final rel = (latest - mean) / (mean == 0 ? 1 : mean);
  // scale: rel of 0.02 -> 100
  final score = (rel / 0.02) * 100.0;
  return score.clamp(-100.0, 100.0);
}

/// Trend direction: returns -1 (down), 0 (neutral), 1 (up)
int trendDirection(List<double> shortWindow, List<double> longWindow) {
  if (shortWindow.isEmpty || longWindow.isEmpty) return 0;
  final smaShort = _mean(shortWindow);
  final smaLong = _mean(longWindow);
  if ((smaShort - smaLong).abs() < (smaLong * 0.001)) return 0; // within 0.1% -> neutral
  return smaShort > smaLong ? 1 : -1;
}

/// Reversal probability: heuristic combining recent momentum and extremeness
double reversalProbability(List<double> prices) {
  if (prices.length < 5) return 0.0;
  final mom = momentumScore(prices).abs() / 100.0; // 0..1
  final vol = volatilityScore(prices) / 100.0; // 0..1
  // higher momentum + high vol -> lower reversal prob; extreme moves increase reversal prob
  final extreme = mom * vol;
  // baseline small chance
  final prob = (0.25 + (extreme * 0.75)) * 100.0;
  return prob.clamp(0.0, 100.0);
}
