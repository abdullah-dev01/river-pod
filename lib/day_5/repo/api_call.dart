import 'dart:convert';
import 'dart:io';

import 'package:river_pod/day_7/model.dart';
import 'package:http/http.dart' as http;

class MyApi {
  Future<List<String>> fetchData() async {
    // Simulate a network call with a delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulate data
    return ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  }

  Future<List<PostModel>> fetchPostData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((data) => PostModel.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on SocketException catch (e) {
      throw Exception('Failed to load posts: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load posts');
    } finally {}
  }
}
