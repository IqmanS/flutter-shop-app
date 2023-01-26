// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_final_fields

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
    // fetchAndSetOrders();
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total,
      String authToken, String userId) async {
    final url = Uri.parse(
        "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken");
    final prod = [];
    cartProducts.forEach((item) => prod.add(item.toMap()));
    final res = await http.post(
      url,
      body: json.encode(
        {
          "amount": total,
          "products": json.encode(prod),
          "dateTime": DateTime.now().toString(),
        },
      ),
    );
    final orderIdfromFirebase = json.decode(res.body)["name"].toString();
    _orders.insert(
      0,
      OrderItem(
        id: orderIdfromFirebase,
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders(String authToken, String userId) async {
    final url = Uri.parse(
        "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken");
    final res = await http.get(url);

    final orderData = jsonDecode(res.body) as Map<String, dynamic>;
    final List<OrderItem> loadedOrders = [];

    orderData.forEach(
      (key, value) {
        // print(json.decode(value["products"]));
        final prods = json.decode(value["products"]) as List;
        final List<CartItem> orderProds = [];
        prods.forEach((element) {
          orderProds.add(fromMap(element));
        });
        loadedOrders.insert(
          0,
          OrderItem(
            id: key.toString(),
            amount: value["amount"],
            products: orderProds,
            dateTime: DateTime.parse(value["dateTime"]),
          ),
        );
      },
    );
    _orders = loadedOrders;
    notifyListeners();
  }
}

CartItem fromMap(Map<String, dynamic> map) {
  return CartItem(
    id: DateTime.now().toString(),
    title: map["title"],
    price: map["price"],
    quantity: map["quantity"],
  );
}
