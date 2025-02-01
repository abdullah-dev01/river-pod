import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_7/post_provider.dart';

class GetApiScreen extends ConsumerWidget {
  const GetApiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Api Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.invalidate(postProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(postProvider);
          return Center(
            child: provider.when(
                skipLoadingOnRefresh: false,
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(data[index].title),
                        subtitle: Text(data[index].body),
                        trailing: Text(data[index].id.toString()),
                      );
                    },
                  );
                },
                error: (error, stack) => TextButton(
                      onPressed: () {
                        ref.invalidate(postProvider); // ✅ Correct provider
                      },
                      child: const Text('Retry'),
                    ),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          );
        },
      ),
    );
  }
}
