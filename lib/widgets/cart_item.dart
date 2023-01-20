// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

import '../providers/cart.dart';

class CartListItem extends StatefulWidget {
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
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final prodPro = Provider.of<ProductsProvider>(context, listen: false);
    final prod = prodPro.item.firstWhere((element) {
      return element.id == widget.prodId.toString();
    });
    return Dismissible(
      key: ValueKey(widget.id),
      onDismissed: (direction) {
        cart.removeItem(widget.prodId);
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
          child: Column(
            children: [
              ListTile(
                leading: Chip(
                  backgroundColor: Theme.of(context).primaryColorLight,
                  label: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("\$${widget.quantity * widget.price}"),
                    ),
                  ),
                ),
                title: Text(widget.title),
                subtitle: Text("Price: \$${widget.price}"),
                trailing: Text("x${widget.quantity}"),
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
              if (_expanded == true)
                Container(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        child: Image.network(
                          prod.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: 100,
                              width: 200,
                              child: Text(
                                prod.description,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              )),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    cart.removeSingleItem(widget.prodId);
                                  },
                                  child: const Icon(Icons.remove),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cart.addItem(widget.prodId, widget.title,
                                        widget.price);
                                  },
                                  child: const Icon(Icons.add),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
