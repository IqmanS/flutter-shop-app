// ignore_for_file: prefer_final_fields
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get item {
    return [..._items];
    //Returns copy of items
    //if given direct access we give pointer to main file
  }

  List<Product> get favItem {
    return _items.where((element) => element.isFavourite == true).toList();
    //Returns copy of items
    //if given direct access we give pointer to main file
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product prod) {
    final url = Uri.parse(
        "https://flutter-shop-app-6ea2d-default-rtdb.asia-southeast1.firebasedatabase.app/products.json");
    return http
        .post(
      url,
      body: json.encode({
        "title": prod.title,
        "description": prod.description,
        "price": prod.price,
        "imageUrl": prod.imageUrl,
        "isFavourite": prod.isFavourite
      }),
    )
        .then((res) {
      //res is response after executing http.post which returns unique id
      final prodIdfromFirebase = json.decode(res.body)['name'].toString();
      final Product newProd = Product(
          id: prodIdfromFirebase,
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);
      _items.add(newProd);
      notifyListeners();
    }).catchError((err) {
      print(err);
      throw err;
    });
  }

  void updateProduct(String id, Product prod) {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = prod;
      notifyListeners();
    }
  }

  void deleteProd(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
