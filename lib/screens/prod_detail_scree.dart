import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "/product_details";

  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String prodId = routeArguments['id']!;
    final prod = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(prodId);
    return Scaffold(
      appBar: AppBar(
        title: Text(prod.title),
      ),
    );
  }
}
