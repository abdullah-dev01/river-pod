import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/joke_generator_provider.dart';

/*
 * ============================================================================
 * ASYNCVALUE vs SIMPLE VALUES - EXPLANATION
 * ============================================================================
 * 
 * SIMPLE VALUES:
 * - When you have data that's already available immediately
 * - Example: final name = "John";  // This is ready right away
 * - Example: final count = 42;      // This is ready right away
 * 
 * ASYNCVALUE:
 * - When you have data that takes time to load (like API calls, network requests)
 * - Example: Fetching a joke from an API - it takes time!
 * - AsyncValue is a wrapper that handles THREE possible states:
 *   1. LOADING: Data is still being fetched
 *   2. DATA: Data has been successfully loaded
 *   3. ERROR: Something went wrong while fetching
 * 
 * WHY WE NEED ASYNCVALUE:
 * - Without it, you'd have to manually check: "Is it loading? Did it error? Do I have data?"
 * - AsyncValue makes it easy to handle all three states in one place
 * 
 * IN THIS EXAMPLE:
 * - jokeGeneratorProvider is a FutureProvider (returns Future<JokeModel>)
 * - When you watch a FutureProvider, Riverpod gives you AsyncValue<JokeModel>
 * - This means: joke can be in loading, data, or error state
 */

class JokeGeneratorApp extends StatelessWidget {
  const JokeGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Consumer(
        builder: (context, ref, child) {
          final joke = ref.watch(jokeGeneratorProvider);
          if (joke.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (joke.hasError) {
            return Center(child: Text(joke.error.toString()));
          }

          // If we reach here, we have data! Extract the value
          // joke.value is now a JokeModel (not null)
          final jokeModel = joke.value!;

          // ====================================================================
          // METHOD 2: Using pattern matching with switch (modern Dart style)
          // ====================================================================
          // This is equivalent to the if/else above, but more concise
          // You can use EITHER method - both work the same way!

          return Stack(
            alignment: Alignment.center,
            children: [
              switch (joke) {
                AsyncValue(:final value?) => SelectableText(
                  "${value.setup}?\n\n ${value.punchline}",
                ),
                AsyncValue(error: != null) => const Text('Error fetching joke'),
                AsyncValue() => const CircularProgressIndicator(),
              },
              SelectableText(
                "${jokeModel.setup}?\n\n${jokeModel.punchline}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),

              // Button to fetch another joke
              Positioned(
                bottom: 20,
                child: ElevatedButton(
                  onPressed: () {
                    // Refresh the provider to fetch a new joke
                    // This will set AsyncValue back to loading state, then data state
                    ref.invalidate(jokeGeneratorProvider);
                  },
                  child: const Text('Get another joke'),
                ),
              ),
            ],
          );

          /* ====================================================================
           * ALTERNATIVE: Pattern matching approach (if you prefer this style)
           * ====================================================================
           * You can replace the if/else above with this switch pattern:
           * 
           * return joke.when(
           *   data: (jokeModel) => Stack(
           *     alignment: Alignment.center,
           *     children: [
           *       SelectableText("${jokeModel.setup}?\n\n${jokeModel.punchline}"),
           *       Positioned(
           *         bottom: 20,
           *         child: ElevatedButton(
           *           onPressed: () => ref.invalidate(jokeGeneratorProvider),
           *           child: const Text('Get another joke'),
           *         ),
           *       ),
           *     ],
           *   ),
           *   loading: () => const Center(child: CircularProgressIndicator()),
           *   error: (error, stack) => Center(child: Text('Error: $error')),
           * );
           * 
           * This is cleaner and handles all three states in one place!
           * ====================================================================
           */
        },
      ),
    );
  }
}
