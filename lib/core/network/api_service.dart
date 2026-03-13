import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiService {

  final DioClient _dioClient = DioClient();

  Future<List<dynamic>> getCompanies(int page) async {

    try {

      final response = await _dioClient.dio.get(
        "companies",
        queryParameters: {
          "page": page
        },
      );

      return response.data;

    } on DioException catch (e) {

      throw Exception(e.message);
    }
  }

  Future<Map<String, dynamic>> getCompanyDetails(int id) async {

    try {

      final response = await _dioClient.dio.get(
        "companies/$id",
      );

      return response.data;

    } on DioException catch (e) {

      throw Exception(e.message);
    }
  }
}