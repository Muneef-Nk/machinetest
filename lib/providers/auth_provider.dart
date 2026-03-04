import 'package:flutter/material.dart';
import '../models/login_model.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final LocalStorageService _storage = LocalStorageService();

  bool isLoading = false;
  String? errorMessage;

  String? userId;
  String? token;

  /// LOGIN
  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final LoginModel response = await _apiService.login(email: email, password: password);

      userId = response.customerData?.id;
      token = response.customerData?.token;

      if (userId != null && token != null) {
        await _storage.saveUserSession(userId!, token!);
      }

      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// LOAD SESSION ON APP START
  Future<bool> loadSession() async {
    userId = await _storage.getUserId();
    token = await _storage.getToken();

    notifyListeners();

    return userId != null && token != null;
  }

  /// LOGOUT
  Future<void> logout() async {
    userId = null;
    token = null;
    await _storage.clearSession();
    notifyListeners();
  }
}
