import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/widgets/badge.dart';

import '../providers/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';

// ignore: constant_identifier_names
enum FilterOptions { Favourites, All }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = "/producy_overview";
  ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavouritesOnly = false;
  bool _isLoading = false;

  Future<void> _refreshProducts() async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(Provider.of<Auth>(context, listen: false).userId);
  }

  @override
  void initState() {
    //do not use "context" in init state us in didChangeDependencies
    setState(() {
      _isLoading = true;
    });

    Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(Provider.of<Auth>(context, listen: false).userId)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    //we dont use it here as listen: false works
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.Favourites) {
                  _showFavouritesOnly = true;
                } else {
                  _showFavouritesOnly = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.Favourites,
                child: Text('Favourites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, a) => Badge(
              value: cart.itemCount.toString(),
              color: Theme.of(context).primaryColor,
              child: IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ),
        ],
        title: const Text("Shop App"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshProducts,
              backgroundColor: Theme.of(context).primaryColorLight,
              child: ProductsGrid(
                showFavouritesOnly: _showFavouritesOnly,
              ),
            ),
    );
  }
}
