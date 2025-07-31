// lib/app/utils/api_client.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../data/services/auth_service.dart';

class ApiClient extends GetxService {
  late Dio _dio;
  final String baseUrl = 'https://smilecloud.id/japbusi2/api';

  Future<ApiClient> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(AuthInterceptor());
    return this;
  }

  Dio get dio => _dio;
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authService = Get.find<AuthService>();

    if (authService.isLoggedIn) {
      options.headers['Authorization'] = 'Bearer ${authService.token}';
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token might be expired
      final authService = Get.find<AuthService>();

      // Check if the request was already trying to refresh the token
      if (!err.requestOptions.path.contains('/auth/refresh')) {
        try {
          // Try to refresh the token
          await authService.refreshToken();

          // Retry the original request with the new token
          final options = Options(
            method: err.requestOptions.method,
            headers: {
              'Authorization': 'Bearer ${authService.token}',
              ...err.requestOptions.headers,
            },
          );

          final response = await Get.find<ApiClient>().dio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: options,
          );

          // Return the response from the retried request
          return handler.resolve(response);
        } catch (e) {
          // If refreshing fails, logout and let the error propagate
          await authService.logout();

          // If you have a navigation service or controller
          // Navigate to login page
          Get.offAllNamed('/auth/login');
        }
      }
    }

    // For other errors, just pass them through
    return super.onError(err, handler);
  }
}
