import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_4/fav_provider.dart';

class FavApp extends ConsumerWidget {
  const FavApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              ref.read(favProvider.notifier).favList(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: "ALL",
                  child: Text("All"),
                ),
                PopupMenuItem(
                  value: "Fav",
                  child: Text("Fav"),
                ),
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) {
              ref.read(favProvider.notifier).filterList(value);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.favItems.length,
              itemBuilder: (BuildContext context, int index) {
                final favItems = provider.favItems[index];

                return ListTile(
                  leading: Text(favItems.name),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: favItems.favourite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(favProvider.notifier).addItems();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
