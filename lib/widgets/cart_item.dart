import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemViewer extends StatelessWidget {
  final CartItem cartItem;
  final String prodId;
  const CartItemViewer({Key? key, required this.cartItem, required this.prodId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var crt = Provider.of<Cart>(context, listen: false);
    return cartItem == null
        ? Center(
            child: Text('Data Error!!!'),
          )
        : Dismissible(
            key: ValueKey(cartItem.id),
            background: Container(
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 40,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              crt.removeItem(prodId);
            },
            child: Card(
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
                  subtitle: Text(
                      'Total: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          crt.increaseOrDecreaseItem(
                              prodId, false); // true for increase
                        },
                      ),
                      Text('${cartItem.quantity}x'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          crt.increaseOrDecreaseItem(
                              prodId, true); // true for increase
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
