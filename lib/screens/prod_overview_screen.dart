import 'package:flutter/material.dart';
import 'package:shop_app/dummy_products.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = DUMMY_PRODUCTS;
  static const routeName = "/producy_overview";
  ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop App"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: mediaQuery.size.width < 400 ? 1 : 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: ((context, index) {
          return ProductItem(
            selectedProduct: loadedProducts[index],
          );
        }),
      ),
    );
  }
}
