import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchProvider = StateNotifierProvider<SearchNotifier, SearchSate>((ref) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<SearchSate> {
  SearchNotifier() : super(SearchSate(search: '', isChange: false));

  void search(String query) {
    state = state.copyWith(search: query);
  }

  void onChange(bool isChange) {
    state = state.copyWith(isChange: isChange);
  }
}

class SearchSate {
  final String search;
  final bool isChange;
  SearchSate({required this.search, required this.isChange});

  SearchSate copyWith({
    String? search,
    bool? isChange,
  }) {
    return SearchSate(
      search: search ?? this.search,
      isChange: isChange ?? this.isChange,
    );
  }
}
