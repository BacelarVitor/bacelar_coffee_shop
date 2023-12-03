import 'package:bacelar_coffee_shop/class/drink_order.dart';
import 'package:bacelar_coffee_shop/class/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends StateNotifier<Order> {
  OrderNotifier() : super(Order());

  void addDrink(DrinkOrder drink) {
    state = state.copyWith(drinks: [...state.drinks, drink]);
  }

  void removeDrink(String drinkName) {
    state = state.copyWith(
      drinks: state.drinks.where((drink) => drink.name != drinkName).toList(),
    );
  }

  void clearOrder() {
    state = Order();
  }
}

final ordersProvider = StateNotifierProvider<OrderNotifier, Order>((ref) {
  return OrderNotifier();
});
