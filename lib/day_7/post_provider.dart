import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_5/repo/api_call.dart';
import 'package:river_pod/day_7/model.dart';

final myApiProvider = Provider<MyApi>((ref) => MyApi());
final postProvider = FutureProvider<List<PostModel>>((ref) async {
  try {
    final response = await ref.read(myApiProvider).fetchPostData();
    print("API Response: $response");
    return response;
  } catch (e) {
    print("Error fetching posts: $e");
    throw e; // Ensure error is thrown so UI updates
  }
});
