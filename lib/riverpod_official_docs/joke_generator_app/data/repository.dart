import 'package:dio/dio.dart';
import 'package:river_pod/riverpod_official_docs/joke_generator_app/model/joke_model.dart';

final dio = Dio();

Future<JokeModel> fetchRandomJoke() async {
  // Fetching a random joke from a public API
  final response = await dio.get<Map<String, Object?>>(
    'https://official-joke-api.appspot.com/random_joke',
  );

  return JokeModel.fromJson(response.data!);
}
