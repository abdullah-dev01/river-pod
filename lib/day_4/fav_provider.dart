import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/day_4/fav_states.dart';

import 'fav_model.dart';

final favProvider = StateNotifierProvider<FavNotifier, FavStates>((ref) {
  return FavNotifier();
});

class FavNotifier extends StateNotifier<FavStates> {
  FavNotifier() : super(FavStates(allItems: [], favItems: [], search: ''));
  void addItems() {
    List<Item> item = [
      Item(name: 'Name1', id: 1, favourite: true),
      Item(name: 'Name2', id: 2, favourite: false),
      Item(name: 'Name3', id: 3, favourite: true),
      Item(name: 'Name4', id: 4, favourite: false),
      Item(name: 'Name5', id: 5, favourite: true),
      Item(name: 'Name6', id: 6, favourite: true),
    ];

    state = state.copyWith(allItems: item.toList(), favItems: item.toList());
  }

  void filterList(String search) {
    state = state.copyWith(favItems: _filteredItems(state.allItems, search));
  }

  List<Item> _filteredItems(List<Item> items, String search) {
    if (search.isEmpty) {
      return items;
    } else {
      return items
          .where((items) =>
              items.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
  }

  void favList(String option) {
    state = state.copyWith(favItems: _favItems(state.allItems, option));
  }

  List<Item> _favItems(List<Item> items, String option) {
    if (option == 'ALL') {
      return items;
    } else {
      return items
          .where(
            (items) => items.favourite == true,
          )
          .toList();
    }
  }

  // List<Item> switchList(List<Item> items, String option) {
  //   state = state.copyWith(
  //     favItems: state.allItems,
  //   );
  // }

}
