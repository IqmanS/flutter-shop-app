import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';

class Product with ChangeNotifier {
  // String authToken;
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    // this.authToken = "",
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavourite(String authToken, String userId) async {
    final url = Uri.parse(
        "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/userFav/$userId/$id.json?auth=$authToken");
    // print(url);
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final res = await http.put(
        url,
        body: json.encode(isFavourite),
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
