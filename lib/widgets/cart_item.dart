import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  const CartListItem(
      {super.key,
      required this.id,
      required this.title,
      required this.quantity,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
