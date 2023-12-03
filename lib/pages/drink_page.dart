import 'package:bacelar_coffee_shop/class/drink.dart';
import 'package:flutter/material.dart';

class DrinkPage extends StatelessWidget {
  final Drink drink;

  const DrinkPage({Key? key, required this.drink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drink.name),
      ),
      body: Center(
        child: Text(drink.description),
      ),
    );
  }
}
