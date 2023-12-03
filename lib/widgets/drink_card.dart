import 'package:bacelar_coffee_shop/class/customization.dart';
import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final List<Customization> customizations;

  const DrinkCard({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.customizations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.brown[50], // Light caramel color
      child: Column(
        children: [
          ListTile(
            title: Text(
              name,
              style: const TextStyle(
                fontSize: 18, // Increased font size
                fontWeight: FontWeight.bold, // Added bold font weight
              ),
            ),
            subtitle: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              'R\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20, // Increased font size
                fontWeight: FontWeight.bold, // Added bold font weight
              ),
            ),
          ),
        ],
      ),
    );
  }
}
