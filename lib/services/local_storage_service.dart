import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _keyUserId = "user_id";
  static const String _keyToken = "auth_token";

  /// Save login session
  Future<void> saveUserSession(String userId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, userId);
    await prefs.setString(_keyToken, token);
  }

  /// Get stored userId
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  /// Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  /// Clear session
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyToken);
  }
}
