import 'package:bacelar_coffee_shop/class/drink.dart';
import 'package:bacelar_coffee_shop/class/drink_order.dart';
import 'package:bacelar_coffee_shop/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeePage extends ConsumerStatefulWidget {
  final Drink drink;
  const CoffeePage({super.key, required this.drink});

  @override
  ConsumerState<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends ConsumerState<CoffeePage> {
  Drink get drink => widget.drink;
  @override
  Widget build(BuildContext context) {
    int quantity = 1; // Initialize quantity with a default value
    String milkType = 'Normal';

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
                drink.name,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                drink.description,
                style:
                    const TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              Text(
                'Price: R\$${drink.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Quantity:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<int>(
                    value: quantity,
                    onChanged: (value) {
                      setState(() {
                        quantity = value!;
                      });
                    },
                    items: List.generate(10, (index) => index + 1)
                        .map((value) => DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString()),
                            ))
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // iterate through the customizations list and for each customization name create a checkbox
              ...drink.customizations.map(
                (customization) => Row(
                  children: [
                    Text(
                      customization.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    DropdownButton<String>(
                      items: customization.options
                          .map(
                            (option) => DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          milkType = value!.toString();
                        });
                      },
                      value: milkType,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ), // Add a SizedBox between the customizations and the button)
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.brown[
                          700], // Set the text color to match the border color
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.brown[700]!,
                        width: 2.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      ref.read(ordersProvider.notifier).addDrink(
                            DrinkOrder(
                              name: drink.name,
                              quantity: quantity,
                              price: drink.price,
                              milkType: milkType,
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add to Order'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
