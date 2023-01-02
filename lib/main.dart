import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/screens/prod_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(
      //       fontFamily: GoogleFonts.lato().fontFamily,
      //     ),
      //     bodyText2: TextStyle(
      //       fontFamily: GoogleFonts.lato().fontFamily,
      //     ),
      //     headline1: TextStyle(
      //       fontFamily: GoogleFonts.anton().fontFamily,
      //       letterSpacing: 1.2,
      //     ),
      //     headline2: TextStyle(
      //       fontFamily: GoogleFonts.anton().fontFamily,
      //     ),
      //   ),
      //   primaryColor: Colors.orange,
      //   appBarTheme:
      //       const AppBarTheme(backgroundColor: Colors.deepOrangeAccent),
      // ),
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: Colors.orange,
          fontFamily: GoogleFonts.lato().fontFamily,
          backgroundColor: Colors.grey.shade900,
          scaffoldBackgroundColor: Colors.grey.shade900,
          iconTheme: IconThemeData(color: Colors.deepOrangeAccent.shade700)),
      home: ProductOverviewScreen(),
      routes: {
        ProductOverviewScreen.routeName: ((context) => ProductOverviewScreen()),
      },
    );
  }
}
