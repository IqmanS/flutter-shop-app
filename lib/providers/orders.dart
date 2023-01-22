import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    // final url = Uri.parse(
    //     "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json");
    // print(cartProducts.toString());
    // final res = await http
    //     .post(
    //   url,
    //   body: json.encode(
    //     {
    //       "amount": total,
    //       "products": cartProducts.toString(),
    //       "dateTime": DateTime.now().toString(),
    //     },
    //   ),
    // )
    //     .catchError((err) {
    //   print(err.toString());
    // });
    // print(json.decode(res.body));
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json");
    final res = await http.get(url);

    print(res.body);
  }
}
