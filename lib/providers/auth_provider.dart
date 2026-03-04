import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 1));

      final result = _authService.login(email, password);

      return result;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
