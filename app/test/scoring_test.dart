import 'package:flutter_test/flutter_test.dart';
import 'package:reign_trade_ai/ai/scoring.dart';

void main() {
  test('volatilityScore is 0 for small or flat series', () {
    expect(volatilityScore([100.0]), 0.0);
    expect(volatilityScore([100.0, 100.0, 100.0]), 0.0);
  });

  test('volatilityScore increases with variance', () {
    final low = volatilityScore([100, 101, 99, 100, 100]);
    final high = volatilityScore([100, 110, 90, 120, 80]);
    expect(high, greaterThan(low));
  });

  test('momentumScore positive for upward trend', () {
    final score = momentumScore([100, 101, 102, 103, 104]);
    expect(score, greaterThan(0));
  });

  test('trendDirection detects uptrend', () {
    final short = [102.0, 103.0, 104.0, 105.0, 106.0];
    final long = [98.0, 99.0, 100.0, 101.0, 102.0, 103.0, 104.0];
    expect(trendDirection(short, long), 1);
  });

  test('reversalProbability returns value between 0 and 100', () {
    final prob = reversalProbability([100, 101, 102, 103, 104, 105, 110]);
    expect(prob, inInclusiveRange(0.0, 100.0));
  });
}
