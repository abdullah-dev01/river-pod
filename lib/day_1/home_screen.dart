import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provider returns a string "Hello"
// It is used to demonstrate a simple read-only provider
final hello = Provider<String>((ref) {
  return "Hello";
});

// This provider returns an integer 0
// It is used to demonstrate a simple read-only provider, but intended for a counter example
final counter = Provider<int>((ref) {
  return 0;
});

// This is for stateless widgets
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the 'hello' provider and gets its value
    final reference = ref.watch(hello);

    return Scaffold(
      appBar: AppBar(
        // Sets the app bar title to the value from the 'hello' provider
        title: Text(reference),
      ),
      body: const Center(
          // child: Text(agee.toString()),
          ),
    );
  }
}

// This is for stateful widgets
class HomeScreen2 extends ConsumerStatefulWidget {
  const HomeScreen2({super.key});

  @override
  ConsumerState<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends ConsumerState<HomeScreen2> {
  @override
  Widget build(BuildContext context) {
    final reference = ref.watch(hello);
    const ages = 24;
    return Scaffold(
      appBar: AppBar(
        title: Text(reference),
      ),
      body: Center(
        child: Text(
          ages.toString(),
        ),
      ),
    );
  }
}
