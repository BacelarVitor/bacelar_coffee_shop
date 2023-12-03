import "package:bacelar_coffee_shop/class/drink.dart";
import 'package:bacelar_coffee_shop/pages/coffee_page.dart';
import "package:bacelar_coffee_shop/widgets/drink_card.dart";
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

  void _navigateToDrinkPage(Drink drink) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoffeePage(drink: drink),
      ),
    );
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
                return GestureDetector(
                  onTap: () {
                    _navigateToDrinkPage(drink);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DrinkCard(
                      name: drink.name,
                      description: drink.description,
                      price: drink.price,
                      customizations: drink.customizations,
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
