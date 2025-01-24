import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_5/repo/api_call.dart';

final futureProvider = FutureProvider<int>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  // throw 'Error while fetching data';
  return 3;
});

final futureProvider2 = FutureProvider<List<int>>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  // throw 'Error while fetching data';
  return [1, 2, 3];
});

//====== caching ======
final myApiProvider = Provider<MyApi>((ref) => MyApi());

final cachedDataProvider = FutureProvider<List<String>>((ref) async {
  ref.keepAlive(); // Cache the data
  final myApi = ref.read(myApiProvider);
  return await myApi.fetchData();
  // throw 'Error while fetching data';
});
