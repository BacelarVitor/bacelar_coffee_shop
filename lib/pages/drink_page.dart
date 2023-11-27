import 'package:bacelar_coffee_shop/pages/menu_page.dart';
import 'package:flutter/material.dart';

class DrinkPage extends StatelessWidget {
  final Drink drink;

  const DrinkPage({Key? key, required this.drink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bacelar Coffee"),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Drink Name: ${drink.name}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Price: R\$${drink.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Text(
                'Description: ${drink.description}',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
