import 'package:bacelar_coffee_shop/pages/menu_page.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your customization logic here
              },
              child: const Text(
                'Customize',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Drink Name: ${drink.name}',
              style: const TextStyle(fontSize: 20),
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
    );
  }
}
