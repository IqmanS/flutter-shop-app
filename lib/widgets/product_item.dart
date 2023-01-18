import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              selectedProduct.toggleFavourite();
            },
          ),
          trailing: IconButton(
            // color: Theme.of(context).iconTheme.color,
            color: Colors.grey,
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(selectedProduct.id, selectedProduct.title,
                  selectedProduct.price);
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
          child: Image.network(
            selectedProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
