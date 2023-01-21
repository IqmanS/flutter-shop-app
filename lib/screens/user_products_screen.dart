import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_prod_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = "/user-products";
  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.item.length,
          itemBuilder: ((context, index) {
            return UserProductItem(
              prod: productsData.item[index],
            );
          }),
        ),
      ),
    );
  }
}
