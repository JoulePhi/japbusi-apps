// lib/app/modules/auth/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/auth_service.dart';

class AuthController extends GetxController {
  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  // Form keys for validation
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Observable properties
  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final isLoginView = true.obs;

  // Services
  final AuthService _authService = Get.find<AuthService>();

  // Toggle password visibility
  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  // Toggle between login and register view
  void toggleAuthView() {
    // print('Toggling auth view: ${isLoginView.value}');
    isLoginView.value = !isLoginView.value;
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }

  // Form validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (!isLoginView.value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      if (value.length < 2) {
        return 'Name must be at least 2 characters';
      }
    }
    return null;
  }

  // Login function
  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await _authService.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Clear form fields
        emailController.clear();
        passwordController.clear();

        // Navigate to home
        Get.offAllNamed('/home');
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Register function
  Future<void> register() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await _authService.register(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Clear form fields
        nameController.clear();
        emailController.clear();
        passwordController.clear();

        // Navigate to home
        Get.offAllNamed('/home');
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
