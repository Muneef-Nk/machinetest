import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/api_constants.dart';
import '../models/login_model.dart';

class ApiService {
  Future<LoginModel> login({required String email, required String password}) async {
    final url = Uri.parse(
      "${ApiConstants.apiBaseUrl}${ApiConstants.login}"
      "?email_phone=$email&password=$password",
    );

    final response = await http.post(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == 1) {
        return LoginModel.fromJson(data);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception("Login failed (${response.statusCode})");
    }
  }

  Future<Map<String, dynamic>> fetchHomeData() async {
    final prefs = await SharedPreferences.getInstance();

    final String? id = prefs.getString("user_id");
    final String? token = prefs.getString("auth_token");

    if (id == null || token == null) {
      throw Exception("User session not found");
    }

    final url = Uri.parse("${ApiConstants.apiBaseUrl}${ApiConstants.home}?id=$id&token=$token");

    print("HOME URL: $url");

    final response = await http.post(url);

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load home data");
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails({required int id, required String slug}) async {
    final uri = Uri.parse(
      "${ApiConstants.apiBaseUrl}"
      "${ApiConstants.productDetails}/$slug",
    );

    print("URL: $uri");

    final response = await http.post(uri, body: {"id": id.toString(), "store": "swan"});

    print("Status Code: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed: ${response.statusCode} - ${response.body}");
    }
  }
}
