import 'package:flutter_riverpod/flutter_riverpod.dart';

final sliderProvider = StateProvider<AppState>((value) {
  return AppState(sliderValue: .5, showPassword: false);
});

class AppState {
  final double sliderValue;
  final bool showPassword;
  AppState({required this.showPassword, required this.sliderValue});

  AppState copyWith({
    double? slider,
    bool? showPassword,
  }) {
    return AppState(
      sliderValue: slider ?? sliderValue,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}
