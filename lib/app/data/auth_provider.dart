import 'package:get/get.dart';
import 'package:japbusi/app/data/models/auth_response_model.dart';
import 'package:japbusi/app/data/models/dpc_response.dart';
import 'package:japbusi/app/data/models/register_request.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://smilecloud.id/japbusi2/api';
  }

  Future<AuthResponse> login(
    String email,
    String password, {
    String fcmToken = '',
  }) async {
    final response = await post('/login', {
      'email': email,
      'password': password,
      'fcm_token': fcmToken,
    });
    if (response.status.hasError) {
      final messages = response.body['messages'] ?? [];
      String error = '';
      if (messages is Map) {
        error = messages.values.first;
      } else {
        error = messages;
      }
      throw Exception(error);
    }
    return AuthResponse.fromJson(response.body);
  }

  Future<AuthResponse> register(
    RegisterRequest request, {
    String fcmToken = '',
  }) async {
    final body = request.toJson()..['fcm_token'] = fcmToken;
    final response = await post('/register', body);
    print("Register response: ${response.body}");
    if (response.status.hasError) {
      final messages = response.body['messages'] ?? [];
      String error = '';
      if (messages is Map) {
        error = messages.values.first;
      } else {
        error = messages;
      }
      throw Exception(error);
    }
    return AuthResponse.fromJson(response.body);
  }

  Future<void> logout(String token) async {
    final response = await post(
      '/logout',
      {},
      headers: {'Authorization': 'Bearer $token'},
    );
    print("Logout response: ${response.body}");
    if (response.status.hasError) {
      final messages = response.body['messages'] ?? [];
      String error = '';
      if (messages is Map) {
        error = messages.values.first;
      } else {
        error = messages;
      }
      throw Exception(error);
    }
  }

  Future<AuthResponse> refreshToken(String token) async {
    final response = await post(
      '/auth/refresh',
      {},
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.status.hasError) {
      final messages = response.body['messages'] ?? [];
      String error = '';
      if (messages is Map) {
        error = messages.values.first;
      } else {
        error = messages;
      }
      throw Exception(error);
    }
    return AuthResponse.fromJson(response.body);
  }

  Future<DpcResponse> getDPC(int idFederation) async {
    final response = await post('/get-dpc', {'id_federation': idFederation});
    if (response.status.hasError) {
      final messages = response.body['messages'] ?? [];
      String error = '';
      if (messages is Map) {
        error = messages.values.first;
      } else {
        error = messages;
      }
      throw Exception(error);
    }
    return DpcResponse.fromJson(response.body['data']);
  }
}
