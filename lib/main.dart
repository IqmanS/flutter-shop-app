import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_prod_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/prod_detail_scree.dart';
import 'package:shop_app/screens/prod_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import './providers/products_provider.dart';
import 'providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.white, fontSize: 18)),
          cardColor: Colors.grey.shade200,
          primarySwatch: Colors.green,
          primaryColor: Colors.green,
          fontFamily: GoogleFonts.lato().fontFamily,
          backgroundColor: Colors.grey.shade900,
          scaffoldBackgroundColor: Colors.grey.shade900,
          iconTheme: IconThemeData(color: Colors.greenAccent.shade700),
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.green),
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductOverviewScreen.routeName: ((context) =>
              ProductOverviewScreen()),
          ProductDetailsScreen.routeName: ((context) =>
              const ProductDetailsScreen()),
          CartScreen.routeName: ((context) => const CartScreen()),
          OrdersScreen.routeName: ((context) => const OrdersScreen()),
          UserProductsScreen.routeName: ((context) =>
              const UserProductsScreen()),
          EditProductsScreen.routeName: ((context) =>
              const EditProductsScreen())
        },
      ),
    );
  }
}
