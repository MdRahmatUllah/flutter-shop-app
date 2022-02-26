import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final products = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (ctx, index) => ProductItem(
        id: products[index].id,
        title: products[index].title,
        imageUrl: products[index].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}
