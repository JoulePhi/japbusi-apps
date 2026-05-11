import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_field.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password'),
        centerTitle: true,
        backgroundColor: AppColors.successColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Obx(
                  () => TextFormField(
                    controller: controller.oldPasswordController,
                    decoration: AppField.primaryField(
                      'Password Lama',
                      'Masukkan password lama Anda',
                      Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.oldPasswordObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.oldPasswordObscure.value =
                              !controller.oldPasswordObscure.value;
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.oldPasswordObscure.value,
                  ),
                ),
                SizedBox(height: 16),

                // Phone Number
                Obx(
                  () => TextFormField(
                    controller: controller.newPasswordController,
                    decoration: AppField.primaryField(
                      'Password Baru',
                      'Masukkan password baru Anda',
                      Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.newPasswordObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.newPasswordObscure.value =
                              !controller.newPasswordObscure.value;
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.newPasswordObscure.value,
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    controller: controller.confirmPasswordController,
                    decoration: AppField.primaryField(
                      'Konfirmasi Password',
                      'Konfirmasi password baru Anda',
                      Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.confirmPasswordObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.confirmPasswordObscure.value =
                              !controller.confirmPasswordObscure.value;
                        },
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.confirmPasswordObscure.value,
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangeColor,
                      ),
                      onPressed: () {
                        controller.changePassword();
                      },
                      child: Text(
                        controller.isLoading.value ? 'Loading...' : 'Simpan',
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
