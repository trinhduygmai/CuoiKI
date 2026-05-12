import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../services/token_service.dart';
import '../constants.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
    ),
  );

  static Dio get instance {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenService.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (kDebugMode) {
            print('REQUEST[${options.method}] => PATH: ${options.path}');
            print('HEADERS: ${options.headers}');
            print('DATA: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
            print('DATA: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
            print('MESSAGE: ${e.message}');
            print('RESPONSE DATA: ${e.response?.data}');
          }
          if (e.response?.statusCode == 401) {
            // Handle auto-logout or refresh token here
            // For now, clear tokens might be enough
            TokenService.clearTokens();
          }
          return handler.next(e);
        },
      ),
    );
    return _dio;
  }
}
