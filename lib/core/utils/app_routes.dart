import 'package:flutter/material.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/home/home_screen.dart';

class AppRoutes {
  static const String login = "/login";
  static const String home = "/home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
