import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  Cart,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;
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
              setState(() {
                if (val == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                  // productsContainer.showFavoriteOnly(),
                  // Navigator.of(context).pushReplacementNamed('/favorites'),
                } else if (val == FilterOptions.All) {
                  _showOnlyFavorites = false;
                  // productsContainer.showAll(),
                  // Navigator.of(context).pushReplacementNamed('/'),
                } else {
                  // Show cart items
                }
              })
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("All Items"),
                value: FilterOptions.All,
              ),
              const PopupMenuItem(
                child: Text("Favorite Items"),
                value: FilterOptions.Favorites,
              ),
              const PopupMenuItem(
                child: Text("Cart Items"),
                value: FilterOptions.Cart,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
              value: cart.itemCount.toString(),
            ),
          )
        ],
      ),
      body: ProductsGrid(showFavs: _showOnlyFavorites),
    );
  }
}
