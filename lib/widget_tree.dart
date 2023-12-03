import "package:bacelar_coffee_shop/pages/menu_page.dart";
import "package:bacelar_coffee_shop/pages/order_page.dart";
import "package:flutter/material.dart";

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentIndex = 0;
  List<Widget> pages = const [
    MenuPage(),
    OrderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
