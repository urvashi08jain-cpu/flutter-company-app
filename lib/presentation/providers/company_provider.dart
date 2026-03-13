import 'package:flutter/material.dart';
import '../../core/network/api_service.dart';

class CompanyProvider with ChangeNotifier {

  final ApiService apiService = ApiService();

  List companies = [];

  int page = 1;

  bool isLoading = false;

  bool hasMore = true;

  String? errorMessage;

  Future fetchCompanies() async {

    if (isLoading || !hasMore) return;

    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {

      final data = await apiService.getCompanies(page);

      if (data.isEmpty) {

        hasMore = false;

      } else {

        companies.addAll(data);
        page++;
      }

    } catch (e) {

      errorMessage = "Failed to load companies";

    }

    isLoading = false;

    notifyListeners();
  }

  Future refresh() async {

    companies.clear();
    page = 1;
    hasMore = true;

    await fetchCompanies();
  }
}