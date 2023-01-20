// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import 'dart:math';

class OrderListItem extends StatefulWidget {
  final OrderItem ordItem;
  const OrderListItem({super.key, required this.ordItem});

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListTile(
            title: Text("\$ ${widget.ordItem.amount}"),
            subtitle: Text(setDate(widget.ordItem.dateTime)),
            trailing: IconButton(
              icon: _expanded == true
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded == true)
            Container(
                height: min(widget.ordItem.products.length * 28.0, 150),
                child: ListView(
                  children: widget.ordItem.products.map((prod) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            child: Text(
                              prod.title,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text("${prod.price}  x${prod.quantity}"),
                          SizedBox(
                            width: 50,
                            child:
                                Text((prod.quantity * prod.price).toString()),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                )),
        ],
      ),
    );
  }
}

String setDate(DateTime dt) {
  String date = "${dt.day}-${dt.month}-${dt.year}";
  return date;
}

String setTime(DateTime dt) {
  String time = dt.hour.toString();
  if (dt.hour < 10) time = time + dt.hour.toString();
  time += ":${dt.minute}";
  return time;
}
