import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/config_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = "/product_details";

  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String prodId = routeArguments['id']!;

    final prod = Provider.of<ProductsProvider>(context).findById(prodId);

    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(prod.title),
      ),
      drawer: const AppDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Colors.white12,
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
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black54,
                            // Colors.black87,
                            Theme.of(context).scaffoldBackgroundColor
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  Colors.black38,
                  Colors.black54,
                ],
              ),
            ),
            height: 120,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      prod.toggleFavourite();
                      setState(() {});
                    },
                    icon: prod.isFavourite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                  ),
                  cart.items.containsKey(prod.id)
                      ? Row(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColorDark),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(59, 60))),
                              onPressed: () {
                                cart.removeSingleItem(prod.id);
                              },
                              child: const Icon(Icons.remove_circle),
                            ),
                            Card(
                              margin: const EdgeInsets.all(0),
                              color: Theme.of(context).primaryColorDark,
                              child: Container(
                                height: 60,
                                width: 60,
                                alignment: Alignment.center,
                                child: Text(
                                    cart.items[prod.id]!.quantity.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColorDark),
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(59, 60))),
                              onPressed: () {
                                cart.addItem(prod.id, prod.title, prod.price);
                              },
                              child: const Icon(Icons.add_circle),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColorDark),
                              fixedSize: MaterialStateProperty.all(
                                  const Size(180, 60))),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () {
                            cart.addItem(prod.id, prod.title, prod.price);

                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: double.infinity,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Added to cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22)),
                                      TextButton(
                                          onPressed: () {
                                            cart.removeSingleItem(prod.id);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("UNDO"))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
