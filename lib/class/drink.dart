import 'package:bacelar_coffee_shop/class/customization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Drink {
  final String id;
  final String name;
  final String description;
  final double price;
  final List<Customization> customizations;

  const Drink({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.customizations,
  });

  factory Drink.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Drink(
      id: snapshot.id,
      name: data['name'],
      description: data['description'],
      price: data['price'],
      customizations:
          (data['customizations'] as List<dynamic>).map((customizationData) {
        return Customization(
          customizationData['name'] as String,
          (customizationData['options'] as List<dynamic>)
              .map((option) => option as String)
              .toList(),
        );
      }).toList(),
    );
  }
}
