import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavourite() async {
    final url = Uri.parse(
        "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json");
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final res = await http.patch(
        url,
        body: json.encode({"isFavourite": isFavourite}),
      );
      if (res.statusCode >= 400) {
        throw HttpException("Somthing went wrong");
      }
    } catch (err) {
      print(err.toString());
      isFavourite = oldStatus;
      notifyListeners();
      throw err;
    }
  }
}
