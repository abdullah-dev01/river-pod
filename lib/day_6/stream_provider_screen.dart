import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_6/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(stockPriceProvider);
          return Center(
            child: provider.when(
                skipLoadingOnRefresh: false,
                data: (price) {
                  return Text(price.toString());
                },
                error: (error, stack) => TextButton(
                      onPressed: () {
                        // this will refetch the data from the provider
                        ref.invalidate(stockPriceProvider);
                      },
                      child: const Text('data'),
                    ),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }
}