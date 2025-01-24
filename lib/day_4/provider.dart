import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<Item>>((ref) {
  return ItemNotifier();
});

class ItemNotifier extends StateNotifier<List<Item>> {
  ItemNotifier() : super([]);

  void add(String name) {
    final item = Item(DateTime.now.toString(), name);
    state.add(item);
    state = state.toList();
  }

  void delete(String id) {
    state.removeWhere((items) => items.id == id);
    state = state.toList();
  }

  void udpate(String id, String name) {
    final editItem = state.indexWhere((items) => items.id == id);
    state[editItem].name = name;
    state = state.toList();
  }
}

class Item {
  String id;
  String name;
  Item(
    this.id,
    this.name,
  );
}
