import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  // Create an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create an instance of a class or perform some action here
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Function to handle the logout button press
  Future<void> _logout() async {
    await _auth.signOut();
    navigatorKey.currentState?.pop();
  }

  final List<Drink> drinks = [
    const Drink(
      image: 'images/coffe_logo.png',
      name: 'Cappuccino',
      description: 'A classic Italian coffee drink.',
      price: 3.99,
    ),
    const Drink(
      image: 'images/coffe_logo.png',
      name: 'Espresso',
      description: 'A strong and concentrated coffee.',
      price: 2.99,
    ),
    // Add more drinks here...
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bacelar Co'),
        actions: [
          IconButton(
            onPressed: () async {
              await _logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final drink = drinks[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DrinkCard(
              image: drink.image,
              name: drink.name,
              description: drink.description,
              price: drink.price,
            ),
          );
        },
      ),
    );
  }
}

class DrinkCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final double price;

  const DrinkCard({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(name),
        subtitle: Text(description),
        trailing: Text('\$${price.toStringAsFixed(2)}'),
      ),
    );
  }
}

class Drink {
  final String image;
  final String name;
  final String description;
  final double price;

  const Drink({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });
}
