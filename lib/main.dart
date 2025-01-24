import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_5/screen/cache_image.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const HomeScreen(),
        // home: const CounterExample(),
        // home: const SliderScreen(),
        // home: const SearchScreen(),
        // home: const FavApp(),
        // home: const Home(),
        home: const CacheImageScreen(),
      ),
    );
  }
}
