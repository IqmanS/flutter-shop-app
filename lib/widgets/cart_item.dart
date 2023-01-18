import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final String prodId;
  final String title;
  final int quantity;
  final double price;
  const CartListItem(
      {super.key,
      required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.prodId});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        cart.removeItem(prodId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 8, color: Theme.of(context).scaffoldBackgroundColor),
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).errorColor,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: Chip(
              backgroundColor: Theme.of(context).primaryColorLight,
              label: FittedBox(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(price.toString()),
              )),
            ),
            title: Text(title),
            subtitle: Text("Total: ${quantity * price}"),
            trailing: Text("x$quantity"),
          ),
        ),
      ),
    );
  }
}
