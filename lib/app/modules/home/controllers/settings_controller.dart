import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';

class SettingsController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  void logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(Routes.AUTH); // Navigate to login page after logout
    } catch (e) {
      Get.snackbar('Error', 'Failed to logout: $e');
    }
  }
}
