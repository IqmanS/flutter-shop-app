import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/auth.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = "/orders";
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    Provider.of<Orders>(context, listen: false)
        .fetchAndSetOrders(auth.token, auth.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: ordersData.orders.isEmpty
          ? Center(
              child: Text(
                "No Orders Yet",
                style: TextStyle(
                    fontSize: 30, color: Theme.of(context).primaryColorLight),
              ),
            )
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (context, index) =>
                  OrderListItem(ordItem: ordersData.orders[index]),
            ),
    );
  }
}
