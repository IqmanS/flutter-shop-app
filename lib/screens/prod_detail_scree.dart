import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/model/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "/product_details";

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, Product>;
    final selectedProduct = routeArguments['product'];
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct!.title),
      ),
    );
  }
}
