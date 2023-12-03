import 'package:bacelar_coffee_shop/class/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Order order = Order();

final ordersProvider = Provider((ref) {
  return order;
});
