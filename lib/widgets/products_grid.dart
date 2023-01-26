import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavouritesOnly;
  const ProductsGrid({Key? key, required this.showFavouritesOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context); //listener

    final loadedProducts =
        showFavouritesOnly ? productsData.favItem : productsData.item;
    return ListView.builder(
      // padding: const EdgeInsets.all(12),
      itemCount: loadedProducts.length,
      itemBuilder: ((context, index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: Container(
            padding: EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: const ProductItem(),
          ),
        );
      }),
    );

    // return GridView.builder(
    // padding: const EdgeInsets.all(12),
    // itemCount: loadedProducts.length,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: MediaQuery.of(context).size.width < 500 ? 1 : 2,
    //     // maxCrossAxisExtent: 2,
    //     childAspectRatio: 3 / 2,
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 10,
    //   ),
    // itemBuilder: ((context, index) {
    //   return ChangeNotifierProvider.value(
    //     value: loadedProducts[index],
    //     child: const ProductItem(),
    //   );
    // }),
    // );
  }
}
