import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counter = StateProvider<int>((ref) {
  // StateProvider is a type of provider that holds a single value.
  // In this case, it's an int that defaults to 0.
  return 0;
});

final switchExample = StateProvider<bool>((ref) {
  // StateProvider is a type of provider that holds a single value.
  // In this case, it's an int that defaults to 0.
  return false;
});

//! you can convert it to a statefull widget to get the life cycles
class CounterExample extends ConsumerWidget {
  const CounterExample({super.key});

  @override 
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch() is a function that reads the value of a provider.
    // It will automatically rebuild the widget when the provider's value changes.
    // final count = ref.watch(counter);
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Example'),
      ),
      body: Column(
        children: [
          // This will only rebuild this widget when the counter value changes.
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(counter);
            return Center(
              child: Text(
                // The value of the counter is displayed here.
                count.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }),

          // Switch example
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(switchExample);
            return Center(
              child: Switch(
                  value: count,
                  onChanged: (c) {
                    ref.read(switchExample.notifier).state = c;
                  }),
            );
          })

          // This will rebuild whole widget tree when the counter value changes.
          // Center(
          //   child: Text(
          //     // The value of the counter is displayed here.
          //     count.toString(),
          //     style: Theme.of(context).textTheme.headlineMedium,
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.read() is a function that reads the value of a provider,
          // and also gives you access to the provider's notifier.
          // The notifier is what allows you to update the value of the provider.
          ref.read(counter.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
