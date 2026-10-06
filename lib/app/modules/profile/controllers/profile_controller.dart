import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final emailController = TextEditingController(
    text: Get.find<AuthService>().user!.email,
  );
  final phoneController = TextEditingController(
    text: Get.find<AuthService>().user!.phone,
  );
  final nameController = TextEditingController(
    text: Get.find<AuthService>().user!.name,
  );
  final federationController = TextEditingController(
    text: Get.find<AuthService>().user!.federationName,
  );
  final levelController = TextEditingController(
    text: Get.find<AuthService>().user!.levelName,
  );
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      _authService.updateProfile(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
      AppSnackbar.success('Sukses', 'Profil berhasil diperbarui');
    } catch (e) {
      AppSnackbar.error('Error', 'Gagal memperbarui profil: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    phoneController.dispose();
    nameController.dispose();
  }
}
