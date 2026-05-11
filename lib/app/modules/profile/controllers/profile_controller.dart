import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/user_model.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/modules/splash/controllers/splash_controller.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class ProfileController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final emailController = TextEditingController(
    text: Get.find<AuthService>().user!.email,
  );
  final phoneController = TextEditingController(
    text: Get.find<AuthService>().user!.phone ?? '',
  );
  final nameController = TextEditingController(
    text: Get.find<AuthService>().user!.name,
  );

  final federationController = TextEditingController(
    text: Get.find<AuthService>().user!.federationName ?? '',
  );
  final levelController = TextEditingController(
    text: Get.find<AuthService>().user!.levelName ?? '',
  );
  final subLevelController = TextEditingController(
    text:
        '${Get.find<AuthService>().user!.levelName ?? ''} ${Get.find<AuthService>().user!.subLevelName ?? ''}',
  );
  final addressController = TextEditingController(
    text: Get.find<AuthService>().user!.address ?? '',
  );
  final companyController = TextEditingController(
    text: Get.find<AuthService>().user!.companyName,
  );
  final workplaceController = TextEditingController(
    text: Get.find<AuthService>().user!.workPlace ?? '',
  );

  Future<void> selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate.value ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedBirthDate.value = picked;
    }
  }

  var selectedGender = ''.obs;
  var selectedBirthDate = Rx<DateTime?>(Get.find<AuthService>().user!.dob);
  var selectedCity = ''.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.find<AuthService>().user!.cityId != null) {
      selectedCity.value = Get.find<AuthService>().user!.cityId.toString();
    }
  }

  @override
  void onReady() {
    super.onReady();
    selectGender(Get.find<AuthService>().user!.gender ?? '');
    print('Selected Gender: ${selectedGender.value}');
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      User updatedUser = User(
        id: Get.find<AuthService>().user!.id,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text.isNotEmpty
            ? phoneController.text
            : Get.find<AuthService>().user!.phone,
        companyName: companyController.text.isNotEmpty
            ? companyController.text
            : Get.find<AuthService>().user!.companyName,
        roleId: Get.find<AuthService>().user!.roleId,
        roleName: Get.find<AuthService>().user!.roleName,
        federationId: Get.find<AuthService>().user!.federationId,
        federationName: Get.find<AuthService>().user!.federationName,
        level: Get.find<AuthService>().user!.level,
        levelName: Get.find<AuthService>().user!.levelName,
        subLevel: Get.find<AuthService>().user!.subLevel,
        subLevelName: Get.find<AuthService>().user!.subLevelName,
        cityId: selectedCity.value.isNotEmpty
            ? int.tryParse(selectedCity.value)
            : Get.find<AuthService>().user!.cityId,
        address: addressController.text.isNotEmpty
            ? addressController.text
            : Get.find<AuthService>().user!.address,
        workPlace: workplaceController.text.isNotEmpty
            ? workplaceController.text
            : Get.find<AuthService>().user!.workPlace,
        gender: selectedGender.value.isNotEmpty
            ? selectedGender.value
            : Get.find<AuthService>().user!.gender,
        dob: selectedBirthDate.value,
      );
      await _authService.updateProfile(updatedUser);
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
