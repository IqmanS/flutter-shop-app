import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';

import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  static const routeName = "/producy_overview";
  ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop App"),
      ),
      body: ProductsGrid(),
    );
  }
}
