import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repository.dart';
import '../model/joke_model.dart';

final jokeGeneratorProvider = FutureProvider.autoDispose<JokeModel>((
  ref,
) async {
  return fetchRandomJoke();
});
