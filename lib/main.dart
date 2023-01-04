import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/prod_detail_scree.dart';
import 'package:shop_app/screens/prod_overview_screen.dart';
import 'package:provider/provider.dart';
import './providers/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            primaryColor: Colors.orange,
            fontFamily: GoogleFonts.lato().fontFamily,
            backgroundColor: Colors.grey.shade900,
            scaffoldBackgroundColor: Colors.grey.shade900,
            iconTheme: IconThemeData(color: Colors.deepOrangeAccent.shade700)),
        home: ProductOverviewScreen(),
        routes: {
          ProductOverviewScreen.routeName: ((context) =>
              ProductOverviewScreen()),
          ProductDetailsScreen.routeName: ((context) =>
              const ProductDetailsScreen()),
        },
      ),
    );
  }
}
