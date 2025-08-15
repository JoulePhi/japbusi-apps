import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/utils/app_colors.dart';

class AppSnackbar {
  static void show(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
    );
  }

  static void success(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
      backgroundColor: AppColors.successColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  static void error(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: duration,
      backgroundColor: AppColors.errorColor,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }
}
