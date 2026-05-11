// lib/app/data/services/auth_service.dart
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/auth_provider.dart';
import 'package:japbusi/app/data/models/dpc_response.dart';
import 'package:japbusi/app/data/models/notification.dart';
import 'package:japbusi/app/data/models/register_request.dart';
import '../models/user_model.dart';
import '../models/auth_response_model.dart';

class AuthService extends GetxService {
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Observable properties
  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoggedIn = false.obs;
  final RxString _token = ''.obs;
  final RxBool _isLoading = false.obs;
  String _fcmToken = '';
  final RxList<Notification> _notifications = RxList<Notification>([]);

  // Getters
  User? get user => _user.value;
  bool get isLoggedIn => _isLoggedIn.value;
  String get token => _token.value;
  List<Notification> get notifications => _notifications;
  bool get isLoading => _isLoading.value;

  Future<AuthService> init(String fcmToken) async {
    await _loadTokenAndUser();
    _fcmToken = fcmToken;
    return this;
  }

  Future<void> _loadTokenAndUser() async {
    try {
      final token = await _storage.read(key: 'access_token');
      if (token != null) {
        _token.value = token;
        _isLoggedIn.value = true;

        // Load user data
        final userJson = await _storage.read(key: 'user');
        if (userJson != null) {
          _user.value = User.fromJson(
            Map<String, dynamic>.from(jsonDecode(userJson)),
          );
        }
        getNotifications();
      }
    } catch (e) {
      await logout();
      print('Error loading stored auth data: $e');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await _authProvider.login(
      email,
      password,
      fcmToken: _fcmToken,
    );
    await _saveAuthData(response);
  }

  Future<void> _saveAuthData(AuthResponse response) async {
    _token.value = response.accessToken;
    _user.value = response.user;
    _isLoggedIn.value = true;

    await getNotifications();
    await _storage.write(key: 'access_token', value: response.accessToken);
    await _storage.write(
      key: 'user',
      value: jsonEncode(response.user.toJson()),
    );
  }

  Future<DpcResponse> getDpc(int idFederation) async {
    final response = await _authProvider.getDPC(idFederation);
    return response;
  }

  Future<void> register(RegisterRequest request) async {
    final response = await _authProvider.register(request, fcmToken: _fcmToken);
    await _saveAuthData(response);
  }

  Future<void> getNotifications() async {
    if (_token.value.isEmpty) return;
    try {
      print('Fetching notifications with token: ${_token.value}');
      _isLoading.value = true;
      final notifications = await _authProvider.getNotifications(_token.value);
      _notifications.assignAll(notifications);
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      print('Finished fetching notifications');
      _isLoading.value = false;
    }
  }

  Future<void> readNotifications(int notification) async {
    if (_token.value.isEmpty) return;
    try {
      _isLoading.value = true;
      await _authProvider.readNotification(notification);
      // remove from list
      _notifications.removeWhere(
        (n) => (int.tryParse(n.id) ?? 0) == notification,
      );
    } catch (e) {
      print('Error reading notifications: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    if (_token.value.isNotEmpty) {
      try {
        notifications.clear();
        await _authProvider.logout(_token.value);
      } catch (e) {
        print('Error during API logout: $e');
        // Continue with local logout even if API call fails
      }
    }

    // Clear stored data
    await _storage.deleteAll();

    // Reset observable properties
    _token.value = '';
    _user.value = null;
    _isLoggedIn.value = false;
  }

  Future<void> refreshToken() async {
    if (_token.value.isNotEmpty) {
      try {
        final response = await _authProvider.refreshToken(_token.value);
        await _saveAuthData(response);
      } catch (e) {
        // If token refresh fails, force logout
        await logout();
        throw 'Session expired. Please log in again.';
      }
    }
  }

  Future<void> updateProfile(User user) async {
    try {
      final response = await _authProvider.updateProfile(user);
      _user.value = User.fromJson(response.body['user']);
      await _storage.write(
        key: 'user',
        value: jsonEncode(response.body['user']),
      );
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _authProvider.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      throw Exception('Failed to change password: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      final response = await _authProvider.deleteAccount();
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _authProvider.forgotPassword(email);
    } catch (e) {
      throw Exception('Failed to initiate password reset: $e');
    }
  }
}
