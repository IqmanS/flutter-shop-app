import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = "/orders";
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) =>
            OrderListItem(ordItem: ordersData.orders[index]),
      ),
    );
  }
}
