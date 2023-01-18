import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

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
      drawer: const AppDrawer(),
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  prod.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.black54,
                    // Colors.black87,
                    Theme.of(context).scaffoldBackgroundColor
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Price: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 20),
              ),
              const SizedBox(width: 10),
              Chip(label: Text("\$${prod.price}"))
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              prod.description,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
