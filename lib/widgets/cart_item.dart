import 'package:flutter/material.dart';
import '../providers/cart.dart';

class CartItemViewer extends StatelessWidget {
  final CartItem cartItem;
  const CartItemViewer({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cartItem == null
        ? Center(
            child: Text('Data Error!!!'),
          )
        : Card(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  child: FittedBox(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('\$${cartItem.price.toStringAsFixed(2)}'),
                  )),
                ),
                title: Text(cartItem.title),
                subtitle: Text('Quantity: ${cartItem.quantity}x'),
                trailing: Text(
                    'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
              ),
            ),
          );
  }
}
