import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsNavNotifier extends StateNotifier<int> {
  DetailsNavNotifier() : super(0);

  void selectPage(int index) {
    state = index;
  }
}

final detailsNavProvider =
    StateNotifierProvider<DetailsNavNotifier, int>(
  (_) => DetailsNavNotifier(),
);