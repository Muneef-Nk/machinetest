import 'package:flutter/material.dart';

import '../../screens/login/login_screen.dart';

class AppRoutes {
  static const login = '/';
  static const home = '/home';
  static const products = '/products';
  static const productDetails = '/product-details';
  static const cart = '/cart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
