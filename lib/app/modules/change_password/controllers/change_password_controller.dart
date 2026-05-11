import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class ChangePasswordController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPasswordObscure = true.obs;
  final newPasswordObscure = true.obs;
  final confirmPasswordObscure = true.obs;

  final isLoading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> changePassword() async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      AppSnackbar.error('Error', 'Mohon isi semua field');
      return;
    }

    if (newPassword != confirmPassword) {
      AppSnackbar.error('Error', 'Password baru tidak cocok');
      return;
    }

    try {
      isLoading.value = true;
      await _authService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      AppSnackbar.success('Success', 'Password berhasil diubah');
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      AppSnackbar.error('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
