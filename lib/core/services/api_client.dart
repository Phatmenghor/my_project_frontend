import 'package:dio/dio.dart';
import 'package:my_project/core/services/logger.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options
      ..baseUrl = "https://jsonplaceholder.typicode.com"
      ..connectTimeout = 5000 as Duration? // 5 seconds
      ..receiveTimeout = 3000 as Duration?; // 3 seconds

    // Adding interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          CustomLogger.instance.i("Request: ${options.method} ${options.uri}");
          // Continue with the request
          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          CustomLogger.instance.i(
              "Response: ${response.statusCode} ${response.requestOptions.uri}");
          // Continue with the response
          handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          CustomLogger.instance.e(
              "Error: ${error.response?.statusCode} ${error.requestOptions.uri}",
              error: error.error,
              stackTrace: error.stackTrace);
          // Continue with the error
          handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get<T>(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      CustomLogger.instance.e("GET request failed: ${e.message}", error: e);
      if (e.response?.statusCode == 401) {
        // Handle unauthorized access
      }
      rethrow;
    }
  }

  Future<Response<T>> post<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post<T>(path,
          data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      CustomLogger.instance.e("POST request failed: ${e.message}", error: e);
      rethrow;
    }
  }

  Future<Response<T>> put<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.put<T>(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      CustomLogger.instance.e("PUT request failed: ${e.message}", error: e);
      rethrow;
    }
  }

  Future<Response<T>> delete<T>(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete<T>(path,
          data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      CustomLogger.instance.e("DELETE request failed: ${e.message}", error: e);
      rethrow;
    }
  }
}
