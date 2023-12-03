import 'package:flutter_riverpod/flutter_riverpod.dart';

class WidgetTreeNotifier extends StateNotifier<int> {
  WidgetTreeNotifier() : super(0);

  update(int index) {
    state = index;
  }
}

final widgetTreeProvider =
    StateNotifierProvider<WidgetTreeNotifier, int>((ref) {
  return WidgetTreeNotifier();
});
