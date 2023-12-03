import 'package:bacelar_coffee_shop/class/order.dart';
import 'package:bacelar_coffee_shop/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderPage extends ConsumerStatefulWidget {
  final Order order;

  const OrderPage({super.key, required this.order});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  String? address;

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    order.address = address!;
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
