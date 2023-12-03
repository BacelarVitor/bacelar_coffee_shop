import 'package:bacelar_coffee_shop/class/drink_order.dart';

class Order {
  List<DrinkOrder> drinks = [];
  double get total {
    return drinks.fold(0, (total, drink) {
      return total + drink.quantity * drink.price;
    });
  }

  String address = '';

  Order copyWith({required List<DrinkOrder> drinks}) {
    return Order()
      ..drinks = drinks
      ..address = address;
  }
}
