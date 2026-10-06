import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class ForgotPasswordController extends GetxController {
  var emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void submit() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      AppSnackbar.error('Error', 'Email tidak boleh kosong');
      return;
    }
    final authService = Get.find<AuthService>();
    authService
        .forgotPassword(email)
        .then((_) {
          AppSnackbar.success(
            'Success',
            'Link reset password telah dikirim ke email Anda',
          );
        })
        .catchError((error) {
          AppSnackbar.error('Error', error.toString());
        });
  }
}
