import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search.provider.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                ref.read(searchProvider.notifier).search(value);
              },
            ),
            Consumer(builder: (context, ref, child) {
              debugPrint('Build Search Text widget');
              final search =
                  ref.watch((searchProvider).select((state) => state.search));
              return Text(search);
            }),
            Consumer(builder: (context, ref, child) {
              debugPrint('Build Switch widget');
              final isChange =
                  ref.watch((searchProvider).select((state) => state.isChange));
              return Switch(
                value: isChange,
                onChanged: (value) {
                  ref.read(searchProvider.notifier).onChange(value);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
