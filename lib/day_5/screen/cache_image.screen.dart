
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_5/provider/future_provider.dart';

class CacheImageScreen extends ConsumerWidget {

  const CacheImageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cachedDataAsync = ref.watch(cachedDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider Example'),
      ),
      body: cachedDataAsync.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(data[index]),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(cachedDataProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Refresh the data
          ref.invalidate(cachedDataProvider);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

