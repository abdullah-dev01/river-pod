import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A stream provider that generates a stream of random numbers to simulate
/// a stock price changing over time.
///
/// The stream starts with a random number between 0 and 100, and then
/// yields a new random number every second.
///
/// The price is formatted to two decimal places.
/// Yield means that the stream will emit a new value

final stockPriceProvider = StreamProvider(
  (ref) async* {
    final random = Random();
    double currentPrice = random.nextDouble() * 100;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      currentPrice = random.nextDouble() * 100;
      yield double.tryParse(currentPrice.toStringAsFixed(2)) ?? 0;
    }
  },
);
