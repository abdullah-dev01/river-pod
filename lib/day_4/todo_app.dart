import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_4/provider.dart';

class TodoApp extends ConsumerWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Consumer(builder: (context, ref, w) {
          return ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(item[index].name),
                trailing: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.read(itemProvider.notifier).udpate(item[index].id, 'updated item');
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(itemProvider.notifier).delete(item[index].id);
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(itemProvider.notifier).add("New Item");
        },
      ),
    );
  }
}
