import 'package:flutter/material.dart';
import 'package:machine_test/models/homemodel.dart';
import '../services/api_service.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool isLoading = false;
  String? errorMessage;

  HomeDataModel? homeData;

  Future<void> loadHomeData() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final data = await _apiService.fetchHomeData();

      homeData = HomeDataModel.fromJson(data);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
