import 'package:dio/dio.dart';

class DioClient {

  final Dio dio;

  DioClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: "https://fake-json-api.mock.beeceptor.com/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ) {

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}