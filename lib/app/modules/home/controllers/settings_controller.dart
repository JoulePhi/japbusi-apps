import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class SettingsController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final isLoading = false.obs;

  void logout() async {
    try {
      await _authService.logout();
      Get.offAllNamed(Routes.AUTH); // Navigate to login page after logout
    } catch (e) {
      AppSnackbar.error("Terjadi Kesalahan", "gagal logout");
    }
  }

  void deleteAccount() async {
    try {
      isLoading.value = true;
      await _authService.deleteAccount();
      AppSnackbar.success("Akun Dihapus", "Akun Anda telah dihapus.");
      logout();
    } catch (e) {
      AppSnackbar.error("Terjadi Kesalahan", "Gagal menghapus akun");
    } finally {
      isLoading.value = false;
    }
  }
}
