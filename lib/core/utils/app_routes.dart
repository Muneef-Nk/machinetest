import 'package:flutter/material.dart';
import 'package:machine_test/bottomnavigation.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/product/product_details_screen.dart';

class AppRoutes {
  static const String bottomNavigation = "/bottomnavigation";
  static const String login = "/login";
  static const String home = "/home";
  static const String productDetails = "/product_details";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case bottomNavigation:
        return MaterialPageRoute(builder: (_) => const BottomNavigationScreen());

      case productDetails:
        final args = settings.arguments as Map<String, dynamic>?;

        if (args != null && args.containsKey('productId') && args.containsKey('slug')) {
          return MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(productId: args['productId'], slug: args['slug']),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text("Product details data not provided"))),
          );
        }

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
