import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/widgets/badge.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // not full build to get the product
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: true);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // with Consumer only rebuilds the widget when the product changes
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: ItemCartInItems(cart: cart, product: product),
        ),
      ),
    );
  }
}

class ItemCartInItems extends StatelessWidget {
  const ItemCartInItems({
    Key? key,
    required this.cart,
    required this.product,
  }) : super(key: key);

  final Cart cart;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (ctx, producct, _) => cart.isItInTheCart(producct.id) > 0
          ? Badge(
              child: shoppingCartButton(cart: cart, product: product),
              value: cart.isItInTheCart(producct.id).toString(),
              color: Colors.white,
            )
          : shoppingCartButton(cart: cart, product: product),
    );
  }
}

class shoppingCartButton extends StatelessWidget {
  const shoppingCartButton({
    Key? key,
    required this.cart,
    required this.product,
  }) : super(key: key);

  final Cart cart;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.red,
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        cart.addItem(
          product.id,
          product.title,
          product.price,
        );
      },
    );
  }
}
