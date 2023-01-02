import 'package:flutter/material.dart';
import 'package:shop_app/screens/prod_detail_scree.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  final Product selectedProduct;
  const ProductItem({super.key, required this.selectedProduct});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          trailing: IconButton(
            color: Theme.of(context).iconTheme.color,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
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
                arguments: {'product': selectedProduct});
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