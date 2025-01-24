import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_2/slider_provider.dart';

/// A `ConsumerWidget` that shows a `Slider` and a `Text` widget.
///
/// The `Slider` and `Text` widgets are both wrapped in `Consumer`s, which
/// rebuild the widgets when the `sliderProvider` changes.
///
/// When the `Slider` changes, the `onChanged` callback is called with the new
/// value. The `onChanged` callback updates the `sliderProvider` with the new
/// value using the `StateProvider`'s `notifier`.
class SliderScreen extends ConsumerWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('build SliderScreen');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text widget that shows the current value of the slider
            Consumer(
              builder: (context, ref, child) {
                debugPrint('build Text widget');

                // Get the current value of the slider from the provider
                final value = ref.watch(
                  sliderProvider.select((value) => value.sliderValue),
                );

                // Return the Text widget with the current value
                return Text(value.toString());
              },
            ),

            // Slider widget that allows the user to change the value
            Consumer(
              builder: (context, ref, child) {
                debugPrint('build Slider widget');

                // Get the current value of the slider from the provider
                final value = ref
                    .watch(sliderProvider.select((value) => value.sliderValue));

                // Return the Slider widget with the current value
                return Slider(
                  value: value,
                  onChanged: (value) {
                    // Update the provider with the new value
                    final stateProvider = ref.read(sliderProvider.notifier);
                    stateProvider.state = stateProvider.state.copyWith(
                      slider: value,
                    );
                  },
                );
              },
            ),

            // Row with a password toggle button
            Row(
              children: [
                // Icon that shows or hides the password
                Consumer(
                  builder: (context, ref, child) {
                    debugPrint('build Icon widget');

                    // Get the current value of the password toggle from the
                    // provider
                    final showPassword = ref.watch(
                        sliderProvider.select((value) => value.showPassword));

                    // Return the Icon widget with the current value
                    return showPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.password);
                  },
                ),
                // ElevatedButton that toggles the password visibility
                ElevatedButton(
                  onPressed: () {
                    // Toggle the password visibility
                    final stateProvider = ref.read(sliderProvider.notifier);
                    stateProvider.state = stateProvider.state.copyWith(
                      showPassword: !stateProvider.state.showPassword,
                    );
                  },
                  child: const Text('Show Password'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
