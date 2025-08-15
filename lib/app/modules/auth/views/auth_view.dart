// lib/app/modules/auth/views/auth_view.dart (continued)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japbusi/app/data/models/city_model.dart';
import 'package:japbusi/app/data/models/federation_model.dart';
import 'package:japbusi/app/data/models/sublevel_model.dart';
import 'package:japbusi/app/modules/splash/controllers/splash_controller.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_field.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      'assets/access1.png',
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                    Image.asset(
                      'assets/access2.png',
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Obx(
                      () => controller.isLoginView.value
                          ? Image.asset('assets/logo.png', height: 100)
                          : const SizedBox(),
                    ),
                    Obx(
                      () => controller.isLoginView.value
                          ? const SizedBox(height: 30)
                          : const SizedBox(),
                    ),

                    // Form
                    Obx(
                      () => controller.isLoginView.value
                          ? _buildLoginForm()
                          : _buildRegisterForm(),
                    ),

                    const SizedBox(height: 20),

                    // Switch between Login/Register
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.isLoginView.value
                                ? 'Belum punya akun? '
                                : 'Sudah punya akun? ',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.toggleAuthView,
                            child: Text(
                              controller.isLoginView.value
                                  ? 'Daftar Sekarang'
                                  : 'Masuk',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: AppField.primaryField(
              'Email atau Nomor Telepon',
              'Masukan email atau nomor telepon Anda',
              Icons.email_outlined,
            ),
            validator: controller.validateEmailOrPhone,
          ),

          const SizedBox(height: 16),

          // Password Field
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword.value,
              decoration: AppField.primaryField(
                'Kata Sandi',
                'Masukan kata sandi Anda',
                Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
              validator: controller.validatePassword,
            ),
          ),

          const SizedBox(height: 10),

          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Navigate to forgot password
                Get.toNamed('/auth/forgot-password');
              },
              child: Text(
                'Lupa Kata Sandi?',
                style: AppTextStyles.primary.copyWith(fontSize: 14),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Login Button
          Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Login', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm() {
    return Obx(
      () => Form(
        key: controller.registerFormKey,
        child: Stepper(
          currentStep: controller.currentStep.value,
          onStepTapped: controller.goToStep,
          physics: AlwaysScrollableScrollPhysics(),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children: [
                if (details.stepIndex < 2)
                  ElevatedButton(
                    onPressed: controller.nextStep,
                    child: Text('Selanjutnya', style: AppTextStyles.button),
                  ),
                if (details.stepIndex == 2)
                  Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.register,
                      child: controller.isLoading.value
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Daftar'),
                    ),
                  ),
                SizedBox(width: 8),
                if (details.stepIndex > 0)
                  ElevatedButton(
                    onPressed: controller.previousStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangeColor,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Kembali', style: AppTextStyles.button),
                  ),
              ],
            );
          },
          steps: [
            Step(
              title: Text('Informasi Pribadi', style: AppTextStyles.body1),
              content: _buildPersonalInfoStep(),
              isActive: controller.currentStep.value >= 0,
            ),
            Step(
              title: Text('Informasi Pekerjaan', style: AppTextStyles.body1),
              content: _buildProfessionalInfoStep(),
              isActive: controller.currentStep.value >= 1,
            ),
            Step(
              title: Text('Informasi Akun', style: AppTextStyles.body1),
              content: _buildAccountInfoStep(),
              isActive: controller.currentStep.value >= 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Full Name
          TextFormField(
            controller: controller.fullNameController,
            decoration: AppField.primaryField(
              'Nama Lengkap',
              'Masukkan nama lengkap Anda',
              Icons.person_outline,
            ),
          ),
          SizedBox(height: 16),

          // Email (Optional)
          TextFormField(
            controller: controller.emailController,
            decoration: AppField.primaryField(
              'Email (Optional)',
              'Masukkan alamat email Anda',
              Icons.email_outlined,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),

          // Phone Number
          TextFormField(
            controller: controller.phoneController,
            decoration: AppField.primaryField(
              'Nomor Telepon *',
              'Masukkan nomor telepon Anda',
              Icons.phone_outlined,
            ),
            keyboardType: TextInputType.phone,
            maxLength: 12,
          ),
          SizedBox(height: 16),

          // Gender
          Obx(
            () => DropdownButtonFormField<String>(
              value: controller.selectedGender.value.isEmpty
                  ? null
                  : controller.selectedGender.value,
              decoration: AppField.primaryField(
                'Jenis Kelamin *',
                'Pilih jenis kelamin Anda',
                Icons.person_outline,
              ),
              items: controller.genderOptions.map((String gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedGender.value = newValue;
                }
              },
            ),
          ),
          SizedBox(height: 16),

          // Birth Date
          Obx(
            () => InkWell(
              onTap: () => controller.selectBirthDate(Get.context!),
              child: InputDecorator(
                decoration: AppField.primaryField(
                  'Tanggal Lahir *',
                  'Pilih tanggal lahir Anda',
                  Icons.calendar_today_outlined,
                ),
                child: Text(
                  controller.selectedBirthDate.value != null
                      ? DateFormat(
                          'dd/MM/yyyy',
                        ).format(controller.selectedBirthDate.value!)
                      : 'Pilih tanggal lahir anda',
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // City
          Obx(
            () => Autocomplete<City>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                final cities =
                    Get.find<SplashController>().appData.value!.cities;
                if (textEditingValue.text.isEmpty) {
                  return cities;
                }
                return cities.where((City city) {
                  final query = textEditingValue.text.toLowerCase();
                  return ('${city.type} ${city.name}').toLowerCase().contains(
                    query,
                  );
                });
              },
              displayStringForOption: (City city) =>
                  '${city.type} ${city.name}',
              initialValue: controller.selectedCity.value.isNotEmpty
                  ? TextEditingValue(
                      text:
                          Get.find<SplashController>().appData.value!.cities
                              .firstWhereOrNull(
                                (c) => c.id == controller.selectedCity.value,
                              )
                              ?.let((c) => '${c.type} ${c.name}') ??
                          '',
                    )
                  : const TextEditingValue(),
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: AppField.primaryField(
                        'Kota Tempat Tinggal *',
                        'Pilih kota Anda',
                        Icons.location_city_outlined,
                      ),
                      onChanged: (value) {
                        // Optionally clear selectedCity if user clears input
                        if (value.isEmpty) controller.selectedCity.value = '';
                      },
                    );
                  },
              onSelected: (City city) {
                controller.selectedCity.value = city.id;
              },
              optionsViewBuilder: (context, onSelected, options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final City city = options.elementAt(index);
                          return ListTile(
                            title: Text('${city.type} ${city.name}'),
                            onTap: () => onSelected(city),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),

          // Address (Text Area)
          TextFormField(
            controller: controller.addressController,
            decoration: AppField.primaryField(
              'Alamat Anda *',
              'Masukkan alamat Anda',
              Icons.home,
            ),
            maxLines: 3,
            textInputAction: TextInputAction.newline,
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInfoStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Company Name
          TextFormField(
            controller: controller.companyNameController,
            decoration: AppField.primaryField(
              'Nama Perusahaan *',
              'Masukkan nama perusahaan Anda',
              Icons.business_outlined,
            ),
          ),
          SizedBox(height: 16),

          // NIP (Optional)
          TextFormField(
            controller: controller.nipController,
            decoration: AppField.primaryField(
              'NIP (Optional)',
              'Masukkan NIP Anda',
              Icons.badge_outlined,
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),

          // Job
          TextFormField(
            controller: controller.jobController,
            decoration: AppField.primaryField(
              'Jenis Pekerjaan *',
              'Masukkan jenis pekerjaan Anda',
              Icons.work,
            ),
          ),
          SizedBox(height: 16),

          // Federation
          Obx(
            () => DropdownButtonFormField<String>(
              isExpanded: true,
              value: controller.selectedFederation.value.isEmpty
                  ? null
                  : controller.selectedFederation.value,
              decoration: AppField.primaryField(
                'Federasi *',
                'Pilih federasi Anda',
                Icons.group,
              ),
              items: Get.find<SplashController>().appData.value!.federations
                  .map((Federation federation) {
                    return DropdownMenuItem<String>(
                      value: federation.idFederation,
                      child: Text(federation.nameFederation),
                    );
                  })
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedFederation.value = newValue;
                }
              },
            ),
          ),
          SizedBox(height: 16),

          // DPC
          Obx(
            () => controller.dpcLoading.value && controller.level.value == null
                ? CircularProgressIndicator()
                : (controller.subLevelOptions.isNotEmpty
                      ? Column(
                          children: [
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: controller.selectedDpc.value.isEmpty
                                  ? null
                                  : controller.selectedDpc.value,
                              decoration: AppField.primaryField(
                                '${controller.level.value == null ? 'DPC' : controller.level.value!.name} *',
                                'Pilih ${controller.level.value == null ? 'DPC' : controller.level.value!.name} Anda',
                                Icons.location_city,
                              ),
                              items: controller.subLevelOptions.map((
                                SubLevel dpc,
                              ) {
                                return DropdownMenuItem<String>(
                                  value: dpc.id.toString(),
                                  child: Text(
                                    '${controller.level.value == null ? "DPC" : controller.level.value!.name} ${dpc.name}',
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  controller.selectedDpc.value = newValue;
                                }
                              },
                            ),
                            SizedBox(height: 16),
                          ],
                        )
                      : const SizedBox()),
          ),

          Obx(
            () =>
                controller.selectedFederation.value.isNotEmpty &&
                    int.parse(controller.selectedFederation.value) < 0
                ? Column(
                    children: [
                      Autocomplete<City>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          final cities = Get.find<SplashController>()
                              .appData
                              .value!
                              .cities;
                          if (textEditingValue.text.isEmpty) {
                            return cities;
                          }
                          return cities.where((City city) {
                            final query = textEditingValue.text.toLowerCase();
                            return ('${city.type} ${city.name}')
                                .toLowerCase()
                                .contains(query);
                          });
                        },
                        displayStringForOption: (City city) =>
                            '${city.type} ${city.name}',
                        initialValue:
                            controller.selectedOtherCity.value.isNotEmpty
                            ? TextEditingValue(
                                text:
                                    Get.find<SplashController>()
                                        .appData
                                        .value!
                                        .cities
                                        .firstWhereOrNull(
                                          (c) =>
                                              c.id ==
                                              controller
                                                  .selectedOtherCity
                                                  .value,
                                        )
                                        ?.let((c) => '${c.type} ${c.name}') ??
                                    '',
                              )
                            : const TextEditingValue(),
                        fieldViewBuilder:
                            (
                              context,
                              textEditingController,
                              focusNode,
                              onFieldSubmitted,
                            ) {
                              return TextFormField(
                                controller: textEditingController,
                                focusNode: focusNode,
                                decoration: AppField.primaryField(
                                  'Kota/Kabupaten',
                                  'Pilih kota Anda',
                                  Icons.location_city_outlined,
                                ),
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    controller.selectedOtherCity.value = '';
                                  }
                                },
                              );
                            },
                        onSelected: (City city) {
                          controller.selectedOtherCity.value = city.id;
                        },
                        optionsViewBuilder: (context, onSelected, options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final City city = options.elementAt(index);
                                    return ListTile(
                                      title: Text('${city.type} ${city.name}'),
                                      onTap: () => onSelected(city),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : const SizedBox(),
          ),
          Obx(
            () => controller.selectedFederation.value == "-3"
                ? Column(
                    children: [
                      TextFormField(
                        controller: controller.federationName,
                        decoration: AppField.primaryField(
                          'Nama Federasi *',
                          'Masukkan nama federasi Anda',
                          Icons.group,
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  )
                : const SizedBox(),
          ),
          // KTA
          TextFormField(
            controller: controller.ktaController,
            decoration: AppField.primaryField(
              'KTA',
              'Masukkan KTA Anda',
              Icons.badge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Password
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              obscureText: controller.isPasswordHidden.value,
              decoration: AppField.primaryField(
                'Kata Sandi *',
                'Masukkan kata sandi Anda',
                Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: controller.togglePasswordRegVisibility,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Confirm Password
          Obx(
            () => TextFormField(
              controller: controller.confirmPasswordController,
              obscureText: controller.isConfirmPasswordHidden.value,
              decoration: AppField.primaryField(
                'Konfirmasi Kata Sandi *',
                'Masukkan konfirmasi kata sandi Anda',
                Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isConfirmPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),

          // Terms and Conditions
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Syarat dan Ketentuan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Dengan mendaftar, Anda setuju dengan syarat dan ketentuan kami. Data Anda akan diproses sesuai dengan kebijakan privasi kami.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on City? {
  String? let(String Function(dynamic c) param0) {
    if (this == null) return null;
    return param0(this);
  }
}
