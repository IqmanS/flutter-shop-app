import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

import '../screens/orders_screen.dart';
import '../screens/prod_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        // DrawerHeader(
        //   padding: const EdgeInsets.all(8),
        //   child: Container(
        //       child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: const [
        //       CircleAvatar(
        //         minRadius: 35,
        //         child: Text("U", style: TextStyle(fontSize: 22)),
        //       ),
        //       Text(
        //         "Username",
        //         style: TextStyle(
        //           // color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ],
        //   )),
        // ),
        AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          elevation: 0,
          title: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorLight,
                child: const Text("U"),
              ),
              const SizedBox(
                width: 18,
              ),
              const Text("Username"),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        const SizedBox(height: 12),
        ListTile(
          leading: const Icon(
            Icons.shop,
            color: Colors.white,
          ),
          title: const Text("Shop"),
          onTap: () {
            Navigator.of(context).pushNamed(ProductOverviewScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.local_shipping,
            color: Colors.white,
          ),
          title: const Text("Orders"),
          onTap: () {
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          title: const Text("Admin: Manage Products"),
          onTap: () {
            Navigator.of(context).pushNamed(UserProductsScreen.routeName);
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: const Text("Logout"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/");
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ]),
    );
  }
}
