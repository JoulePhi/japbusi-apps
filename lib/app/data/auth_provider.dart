import 'package:get/get.dart';
import 'package:japbusi/app/data/models/auth_response_model.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://smilecloud.id/japbusi2/api';
  }

  Future<AuthResponse> login(String email, String password) async {
    final response = await post('/login', {
      'email': email,
      'password': password,
    });
    if (response.status.hasError) {
      print('Login error: ${response.statusText}');
      throw Exception(response.statusText);
    }
    print('Login response: ${response.body}');
    return AuthResponse.fromJson(response.body);
  }

  Future<AuthResponse> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password,
    });
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    return AuthResponse.fromJson(response.body);
  }

  Future<void> logout(String token) async {
    final response = await post(
      '/auth/logout',
      {},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
  }

  Future<AuthResponse> refreshToken(String token) async {
    final response = await post(
      '/auth/refresh',
      {},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    return AuthResponse.fromJson(response.body);
  }
}
