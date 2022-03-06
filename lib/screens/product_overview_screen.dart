import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsContainer =
        Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop App"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions val) => {
              // print(val),
              if (val == FilterOptions.Favorites)
                {
                  productsContainer.showFavoriteOnly(),
                  // Navigator.of(context).pushReplacementNamed('/favorites'),
                }
              else
                {
                  productsContainer.showAll(),
                  // Navigator.of(context).pushReplacementNamed('/'),
                },
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("All Items"),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text("Favorite Items"),
                value: FilterOptions.Favorites,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
