import 'package:flutter/material.dart';

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
          title: const Text("Username"),
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
      ]),
    );
  }
}
