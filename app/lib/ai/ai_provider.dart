import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/tick.dart';
import 'scoring.dart';
import 'replay_storage.dart';

class AnalysisResult {
  final String symbol;
  final double volatility; // 0..100
  final double momentum; // -100..100
  final int trend; // -1,0,1
  final double reversalProb; // 0..100
  final int confidence; // 0..100
  final List<String> reasons;

  AnalysisResult({
    required this.symbol,
    required this.volatility,
    required this.momentum,
    required this.trend,
    required this.reversalProb,
    required this.confidence,
    required this.reasons,
  });
}

class AiProvider extends ChangeNotifier {
  MarketProvider? _market;
  final Map<String, AnalysisResult> _last = {};
  final ReplayStorage _storage = ReplayStorage();

  void attachMarketProvider(MarketProvider? market) {
    _market = market;
    _storage.init();
    // no direct listeners; we'll poll ticks from market via periodic check
    // but if market is available, we can perform quick sync
    notifyListeners();
  }

  AnalysisResult? lastFor(String symbol) => _last[symbol];

  void handleIncomingTick(Tick tick) {
    // store
    _storage.addTick(tick.symbol, tick);

    // analyze rolling windows of 20,50,100 (if available)
    final ticks = _storage.getTicks(tick.symbol);
    final prices = ticks.map((t) => t.price).toList();
    final windows = <int>[20, 50, 100];
    final results = <int, AnalysisResult>{};
    for (final w in windows) {
      if (prices.length >= w) {
        final sub = prices.sublist(prices.length - w);
        final vol = volatilityScore(sub);
        final mom = momentumScore(sub);
        final trend = trendDirection(sub.take((w >= 20 ? 20 : w)).toList(), sub);
        final rev = reversalProbability(sub);
        final conf = _combineConfidence(vol, mom.abs(), rev);
        final reasons = _buildReasons(vol, mom, trend, rev);
        results[w] = AnalysisResult(symbol: tick.symbol, volatility: vol, momentum: mom, trend: trend, reversalProb: rev, confidence: conf, reasons: reasons);
      }
    }

    // prefer 50-window result if exists else largest available
    AnalysisResult? chosen;
    if (results.containsKey(50)) {
      chosen = results[50];
    } else if (results.isNotEmpty) {
      final keys = results.keys.toList()..sort();
      chosen = results[keys.last];
    }

    if (chosen != null) {
      _last[tick.symbol] = chosen;
      notifyListeners();
    }
  }

  int _combineConfidence(double vol, double momAbs, double rev) {
    // simple weighted heuristic
    // vol (0..100) lower volatility increases confidence
    // momAbs (0..100) higher momentum increases confidence
    // rev (0..100) higher reversal prob decreases confidence
    final volScore = (100 - vol) * 0.4;
    final momScore = momAbs * 0.45;
    final revScore = (100 - rev) * 0.15;
    final raw = volScore + momScore + revScore;
    final val = raw.clamp(0.0, 100.0);
    return val.toInt();
  }

  List<String> _buildReasons(double vol, double mom, int trend, double rev) {
    final reasons = <String>[];
    if (vol > 60) {
      reasons.add('High volatility reduces confidence');
    } else if (vol > 30) {
      reasons.add('Moderate volatility');
    } else {
      reasons.add('Low volatility increases confidence');
    }
    if (mom.abs() > 50) {
      reasons.add('Strong momentum observed: ${mom.toStringAsFixed(1)}');
    } else if (mom.abs() > 15) {
      reasons.add('Moderate momentum: ${mom.toStringAsFixed(1)}');
    } else {
      reasons.add('Weak momentum');
    }
    if (trend == 1) {
      reasons.add('Uptrend detected');
    } else if (trend == -1) {
      reasons.add('Downtrend detected');
    } else {
      reasons.add('No clear trend');
    }
    if (rev > 70) {
      reasons.add('High reversal probability — be cautious');
    } else if (rev > 40) {
      reasons.add('Some reversal risk');
    } else {
      reasons.add('Low reversal probability');
    }
    reasons.add('Confidence is experimental');
    return reasons;
  }
}
