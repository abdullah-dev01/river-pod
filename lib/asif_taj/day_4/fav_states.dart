import 'fav_model.dart';

class FavStates {
  final List<Item> allItems;
  final List<Item> favItems;
  final String search;

  FavStates(
      {required this.allItems, required this.favItems, required this.search});

  FavStates copyWith({
    final List<Item>? allItems,
    final List<Item>? favItems,
    final String? search,
    // final optio
  }) {
    return FavStates(
      allItems: allItems ?? this.allItems,
      favItems: favItems ?? this.favItems,
      search: search ?? this.search,
    );
  }
}
