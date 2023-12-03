import 'package:bacelar_coffee_shop/class/order.dart' as pedido;
import 'package:bacelar_coffee_shop/providers/order_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  String? address;

  // ignore: non_constant_identifier_names
  Future<void> FinishOrder(pedido.Order order) async {
    FirebaseFirestore.instance
        .collection('orders')
        .add({
          'drinks': order.drinks.map((drink) {
            return {
              'name': drink.name,
              'quantity': drink.quantity,
              'price': drink.price,
            };
          }).toList(),
          'address': order.address,
        })
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  @override
  Widget build(BuildContext context) {
    final order = ref.watch(ordersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: order.drinks.length,
                  itemBuilder: (context, index) {
                    final drink = order.drinks[index];
                    return ListTile(
                      title: Text(drink.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          // Remove the drink from the order
                          setState(() {
                            order.drinks.removeAt(index);
                          });
                        },
                      ),
                      // Add more details about the drink here
                    );
                  },
                ),
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Endereço de Entrega'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor informe seu endereço de entrega';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
              ),
              ElevatedButton(
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    order.address = address!;
                    await FinishOrder(order);
                    ref.read(ordersProvider.notifier).clearOrder();
                  }
                },
                child: const Text('Finalizar Pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
