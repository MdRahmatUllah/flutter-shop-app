import 'package:flutter/material.dart';
import './screens/product_overview_screen.dart';
import 'screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (ctx) => ProductsProvider(),
    return ChangeNotifierProvider(
      // value: ProductsProvider(),
      create: (ctx) => ProductsProvider(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
        },
      ),
    );
  }
}
