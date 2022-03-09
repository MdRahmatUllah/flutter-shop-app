import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    // ignore: unnecessary_null_comparison
    return _items.values.fold(0, (sum, item) {
      return sum + item.quantity;
    });
  }

  int isItInTheCart(String productId) {
    return _items.containsKey(productId) ? _items[productId]!.quantity : 0;
  }

  double get totalPrice {
    return _items.values.fold(0, (sum, item) {
      return sum + (item.quantity * item.price);
    });
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void increaseOrDecreaseItem(
    CartItem product,
    bool sign, // true for increase, false for decrease
  ) {
    print(product);
    print(sign);

    if (_items.containsKey(product.id)) {
      print('Contains key');
      if (!sign) {
        print('Item quantity is');
        var q = product.quantity as int;
        print('Item quantity is $q');
        if (q <= 1) {
          _items.remove(product.id);
          print('Item Removed ${product.id}');
        } else {
          _items.update(
            product.id,
            (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity - 1,
            ),
          );
        }
      } else {
        _items.update(
          product.id,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity + 1,
          ),
        );
      }
    } else {
      print('Does not contain key');
      _items.remove(product);
    }
    notifyListeners();
  }
}
