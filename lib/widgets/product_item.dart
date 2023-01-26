import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/prod_detail_scree.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedProduct = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final authToken = Provider.of<Auth>(context).token;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            color: selectedProduct.isFavourite
                ? Theme.of(context).iconTheme.color
                : Colors.grey,
            icon: selectedProduct.isFavourite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            onPressed: () {
              selectedProduct.toggleFavourite(authToken);
            },
          ),
          trailing: IconButton(
            // color: Theme.of(context).iconTheme.color,
            color: Colors.grey,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(selectedProduct.id, selectedProduct.title,
                  selectedProduct.price);

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Added to cart",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22)),
                            TextButton(
                                onPressed: () {
                                  cart.removeSingleItem(selectedProduct.id);
                                  Navigator.pop(context);
                                },
                                child: const Text("UNDO"))
                          ]),
                    );
                  });
            },
          ),
          backgroundColor: Colors.black87,
          title: Text(
            selectedProduct.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                arguments: {
                  'product': selectedProduct,
                  "id": selectedProduct.id
                });
          },
          child: Container(
            color: Colors.white12,
            child: Image.network(
              selectedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
