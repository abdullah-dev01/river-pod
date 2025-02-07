import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_9/utlis/helper.dart';
import 'package:river_pod/day_9/views/home.screen.dart';
// https://www.youtube.com/watch?v=UgsLY4QzWXI&list=PLFyjjoCMAPtwG6c3NYceuwmzSymRNAGHz&index=11

Future<void> main() async {
  await TodoHelper.initialise();
  // ProviderScope is a widget from flutter_riverpod that enables state management
  // It must wrap the root widget of the app to make Riverpod providers
  // accessible throughout the widget tree
  runApp(const ProviderScope(child: MyApp()));
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
        // home: const CacheImageScreen(),
        // home: const StreamProviderScreen(),
        // home: const GetApiScreen(),
        home: const TodoHomeScreen(),
      ),
    );
  }
}
