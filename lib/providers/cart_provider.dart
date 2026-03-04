import 'package:flutter/material.dart';
import '../models/homemodel.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.product.productId == product.productId);
    if (index >= 0) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.removeWhere((item) => item.product.productId == product.productId);
    notifyListeners();
  }

  void decreaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.product.productId == product.productId);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += (double.tryParse(item.product.price ?? "0") ?? 0) * item.quantity;
    }
    return total;
  }
}
