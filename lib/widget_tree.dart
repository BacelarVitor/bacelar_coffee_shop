import "package:bacelar_coffee_shop/pages/menu_page.dart";
import "package:bacelar_coffee_shop/pages/order_page.dart";
import "package:bacelar_coffee_shop/providers/widget_tree_provider.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class WidgetTree extends ConsumerStatefulWidget {
  const WidgetTree({super.key});

  @override
  ConsumerState<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends ConsumerState<WidgetTree> {
  List<Widget> pages = const [
    MenuPage(),
    OrderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final int currentIndex = ref.watch(widgetTreeProvider);
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
          ref.read(widgetTreeProvider.notifier).update(index);
        }),
      ),
    );
  }
}
