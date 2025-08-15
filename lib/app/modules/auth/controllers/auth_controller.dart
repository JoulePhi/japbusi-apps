// lib/app/modules/auth/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/level_model.dart';
import 'package:japbusi/app/data/models/register_request.dart';
import 'package:japbusi/app/data/models/sublevel_model.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';
import '../../../data/services/auth_service.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final companyNameController = TextEditingController();
  final nipController = TextEditingController();
  final jobController = TextEditingController();
  final ktaController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final federationName = TextEditingController();
  var currentStep = 0.obs;

  var selectedGender = ''.obs;
  var selectedBirthDate = Rx<DateTime?>(null);
  var selectedCity = ''.obs;
  var selectedOtherCity = ''.obs;
  var selectedFederation = ''.obs;
  var selectedDpc = ''.obs;

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final isLoginView = true.obs;
  final genderOptions = ['Pria', 'Wanita'];
  final dpcLoading = false.obs;
  final AuthService _authService = Get.find<AuthService>();
  final Rx<Level?> level = Rx<Level?>(null);
  final RxList<SubLevel> subLevelOptions = <SubLevel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to federation changes to update DPC options
    ever(selectedFederation, (String federation) {
      int idFederation = int.tryParse(federation) ?? 0;
      if (idFederation > 0) {
        updateDpcOptions(federation);
      } else {
        level.value = null;
        subLevelOptions.clear();
        selectedDpc.value = '';
      }
    });
  }

  void updateDpcOptions(String federation) async {
    dpcLoading.value = true;
    if (federation.isNotEmpty) {
      _authService
          .getDpc(int.parse(federation))
          .then((dpcResponse) {
            level.value = dpcResponse.level;
            subLevelOptions.value = dpcResponse.subLevels;
            selectedDpc.value = '';
            dpcLoading.value = false;
          })
          .catchError((error) {
            print("Error fetching DPC: $error");
            AppSnackbar.error("Terjadi Kesalahan", error.toString());
            dpcLoading.value = false;
          });
    } else {
      subLevelOptions.clear();
      selectedDpc.value = '';
    }
  }

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;
  void togglePasswordRegVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;
  void toggleAuthView() {
    isLoginView.value = !isLoginView.value;
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }

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

  String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Silakan masukkan email atau nomor telepon Anda';
    }
    if (GetUtils.isEmail(value)) {
      return null;
    }
    if (GetUtils.isPhoneNumber(value)) {
      return null;
    }
    return 'Silakan masukkan email atau nomor telepon yang valid';
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Silakan masukkan kata sandi Anda';
    }
    if (value.length < 6) {
      return 'Kata sandi minimal 6 karakter';
    }
    return null;
  }

  String? validateName(String? value) {
    if (!isLoginView.value) {
      if (value == null || value.isEmpty) {
        return 'Silakan masukkan nama Anda';
      }
      if (value.length < 2) {
        return 'Nama minimal 2 karakter';
      }
    }
    return null;
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await _authService.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        emailController.clear();
        passwordController.clear();
        Get.offAllNamed('/home');
      } catch (e) {
        AppSnackbar.error("Terjadi Kesalahan", e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> register() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await _authService.register(
          RegisterRequest(
            name: fullNameController.text.trim(),
            email: emailController.text.trim(),
            phone: phoneController.text.trim(),
            gender: selectedGender.value,
            dob: selectedBirthDate.value!,
            city: selectedCity.value,
            address: addressController.text.trim(),
            company: companyNameController.text.trim(),
            workPlace: jobController.text.trim(),
            federation: int.parse(selectedFederation.value),
            dpc: selectedDpc.value.isNotEmpty
                ? int.parse(selectedDpc.value)
                : null,
            password: passwordController.text.trim(),
            confirmPassword: confirmPasswordController.text.trim(),
            companyCity: selectedOtherCity.value.isNotEmpty
                ? selectedOtherCity.value
                : null,
            federationName: federationName.text.trim().isNotEmpty
                ? federationName.text.trim()
                : null,
          ),
        );

        nameController.clear();
        emailController.clear();
        passwordController.clear();
        Get.offAllNamed('/home');
      } catch (e) {
        print("Error during registration: $e");
        AppSnackbar.error("Terjadi Kesalahan", e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  void nextStep() {
    if (currentStep.value < 2) {
      if (validateCurrentStep()) {
        currentStep.value++;
      }
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    currentStep.value = step;
  }

  bool validateCurrentStep() {
    switch (currentStep.value) {
      case 0:
        return validatePersonalInfo();
      case 1:
        return validateProfessionalInfo();
      case 2:
        return validateAccountInfo();
      default:
        return false;
    }
  }

  bool validatePersonalInfo() {
    if (fullNameController.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Nama lengkap wajib diisi');
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Nomor telepon wajib diisi');
      return false;
    }
    if (phoneController.text.trim().length < 10 ||
        phoneController.text.trim().length > 12) {
      AppSnackbar.error(
        'Terjadi Kesalahan',
        'Nomor telepon harus terdiri dari 10 hingga 12 digit',
      );
      return false;
    }
    if (selectedGender.value.isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Silakan pilih jenis kelamin');
      return false;
    }
    if (selectedBirthDate.value == null) {
      AppSnackbar.error('Terjadi Kesalahan', 'Silakan pilih tanggal lahir');
      return false;
    }
    if (selectedCity.value.isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Silakan pilih kota');
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Alamat wajib diisi');
      return false;
    }
    return true;
  }

  bool validateProfessionalInfo() {
    if (companyNameController.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Nama perusahaan wajib diisi');
      return false;
    }
    if (jobController.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Pekerjaan wajib diisi');
      return false;
    }
    if (selectedFederation.value.isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Silakan pilih federasi');
      return false;
    }
    if (int.parse(selectedFederation.value) < 0 &&
        selectedOtherCity.value.isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Silakan pilih kota/kabupaten');
      return false;
    }
    if (selectedFederation.value == "-3" &&
        federationName.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Nama federasi wajib diisi');
      return false;
    }
    if (int.parse(selectedFederation.value) > 0 && selectedDpc.value.isEmpty) {
      AppSnackbar.error(
        'Terjadi Kesalahan',
        'Silakan pilih ${level.value != null ? level.value!.name : 'DPC'}',
      );
      return false;
    }
    return true;
  }

  bool validateAccountInfo() {
    if (passwordController.text.trim().isEmpty) {
      AppSnackbar.error('Terjadi Kesalahan', 'Kata sandi wajib diisi');
      return false;
    }
    if (passwordController.text.length < 6) {
      AppSnackbar.error('Terjadi Kesalahan', 'Kata sandi minimal 6 karakter');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      AppSnackbar.error('Terjadi Kesalahan', 'Kata sandi tidak cocok');
      return false;
    }
    return true;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    companyNameController.dispose();
    nipController.dispose();
    jobController.dispose();
    ktaController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
