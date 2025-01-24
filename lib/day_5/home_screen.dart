import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_5/provider/future_provider.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(futureProvider);
    final provider2 = ref.watch(futureProvider2);
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          ref.invalidate(futureProvider2);
        }),
        body: Column(
          children: [
            Center(
              child: provider.when(
                data: (data) => Text(data.toString()),
                error: (error, stack) => Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
            Expanded(
              child: Center(
                child: provider2.when(
                  skipLoadingOnRefresh: false,
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Text(data[index].toString());
                    },
                  ),
                  error: (error, stack) =>
                      Center(child: Text(error.toString())),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

