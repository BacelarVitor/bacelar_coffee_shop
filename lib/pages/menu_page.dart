import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late List<Drink> drinks = [];

  @override
  void initState() {
    super.initState();
    _loadDrinks();
  }

  Future<void> _loadDrinks() async {
    final drinksSnapshot =
        await FirebaseFirestore.instance.collection('drinks').get();
    setState(() {
      drinks =
          drinksSnapshot.docs.map((doc) => Drink.fromSnapshot(doc)).toList();
    });
  }

  Future<void> _logout() async {
    await _auth.signOut();
    navigatorKey.currentState?.pop();
  }

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
      body: drinks.isNotEmpty
          ? ListView.builder(
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
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class DrinkCard extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final double price;

  const DrinkCard({
    Key? key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

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
  final String id;
  final String image;
  final String name;
  final String description;
  final double price;
  final List<Customization> customizations;

  const Drink({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.customizations,
  });

  factory Drink.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Drink(
      id: snapshot.id,
      image: data['image'],
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

class Customization {
  final String name;
  final List<String> options;

  Customization(this.name, this.options);
}
