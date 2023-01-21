// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

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
                Chip(label: Text("\$ ${cart.cartTotal.toStringAsFixed(2)}")),
                ElevatedButton(
                    onPressed: () {
                      if (cart.items.isNotEmpty) {
                        showModalBottomSheet(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          context: context,
                          builder: ((context) {
                            return Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 80,
                              child: Text(
                                "Order Placed!!",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 22),
                              ),
                            );
                          }),
                        );
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList(), cart.cartTotal);
                        cart.clearCart();
                      }
                    },
                    child: const Text("Order Now"))
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: ((context, index) {
              return CartListItem(
                id: cart.items.values.toList()[index].id,
                prodId: cart.items.keys.toList()[index],
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
