import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/edit_prod_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product prod;
  const UserProductItem({super.key, required this.prod});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(prod.title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(prod.imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductsScreen.routeName);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
