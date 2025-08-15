// lib/app/data/services/auth_service.dart
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/auth_provider.dart';
import 'package:japbusi/app/data/models/dpc_response.dart';
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
  String _fcmToken = '';

  // Getters
  User? get user => _user.value;
  bool get isLoggedIn => _isLoggedIn.value;
  String get token => _token.value;

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

  Future<void> logout() async {
    if (_token.value.isNotEmpty) {
      try {
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
}
