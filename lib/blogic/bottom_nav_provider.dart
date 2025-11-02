import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class BottomIndex {
  int index;

  BottomIndex({this.index = 0});
}

class BottomIndexNotifier extends StateNotifier<BottomIndex> {
  BottomIndexNotifier() : super(BottomIndex());

  int getIndex() {
    return state.index;
  }

  void setIndex(int index) {
    state = BottomIndex(index: index);
  }
}

final bottomIndexProvider =
    StateNotifierProvider<BottomIndexNotifier, BottomIndex>(
      (ref) => BottomIndexNotifier(),
    );
