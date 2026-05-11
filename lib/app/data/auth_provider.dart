import 'package:get/get.dart';
import 'package:japbusi/app/data/models/auth_response_model.dart';
import 'package:japbusi/app/data/models/dpc_response.dart';
import 'package:japbusi/app/data/models/notification.dart';
import 'package:japbusi/app/data/models/register_request.dart';
import 'package:japbusi/app/data/models/user_model.dart';
import 'package:japbusi/app/data/services/auth_service.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://japbusi.org/api';
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

  Future<List<Notification>> getNotifications(String token) async {
    final response = await get(
      '/notifications',
      headers: {'Authorization': 'Bearer $token'},
    );
    print("Notifications response: ${response.body}");
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
    // Process notifications if needed
    List<Notification> notifications = [];
    if (response.body['notifications'] != null) {
      notifications = List<Notification>.from(
        response.body['notifications'].map((x) => Notification.fromJson(x)),
      );
    }
    return notifications;
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

  Future<void> readNotification(int notificationId) async {
    final response = await post(
      '/read-notification',
      {'id': notificationId},
      headers: {'Authorization': 'Bearer ${Get.find<AuthService>().token}'},
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

  Future<Response> updateProfile(User user) async {
    final response = await post(
      '/update-profile',
      user.toJson(),
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
    );
    print('Update profile response: ${response.body}');
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
    return response;
  }

  Future<Response> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await post(
      '/change-password',
      {
        'old_password': oldPassword,
        'new_password': newPassword,
        'confirm_password': confirmPassword,
      },
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
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
    return response;
  }

  Future<Response> deleteAccount() async {
    final response = await post(
      '/delete-account',
      {},
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
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
    return response;
  }

  Future<void> forgotPassword(String email) async {
    final response = await post('/forgot-password', {'email': email});
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
}
