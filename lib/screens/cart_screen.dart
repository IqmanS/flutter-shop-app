import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 12),
                Chip(label: Text("\$ ${cart.cartTotal}")),
                ElevatedButton(onPressed: (() {}), child: Text("Order Now"))
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: ((context, index) {
              return CartListItem(
                id: cart.items.values.toList()[index].id,
                title: cart.items.values.toList()[index].title,
                quantity: cart.items.values.toList()[index].quantity,
                price: cart.items.values.toList()[index].price,
              );
            }),
          ))
        ]),
      ),
    );
  }
}
