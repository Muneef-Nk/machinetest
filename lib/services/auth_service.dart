import '../core/constants/api_constants.dart';

class AuthService {
  /// Local credential validation (as per machine test requirement)
  bool login(String email, String password) {
    if (email == ApiConstants.testEmail && password == ApiConstants.testPassword) {
      return true;
    }
    return false;
  }
}
