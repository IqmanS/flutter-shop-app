import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    this.quantity = 1,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      //quantity+1
      _items.update(
          id,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          id,
          (() => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
              )));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.isEmpty ? 0 : _items.length;
  }

  double get cartTotal {
    double total = 0.0;
    _items.forEach((key, value) {
      total = total + value.price * value.quantity;
    });
    return total;
  }

  void removeItem(String prodId) {
    _items.remove(prodId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
