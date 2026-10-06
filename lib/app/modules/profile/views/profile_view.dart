import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_field.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: AppColors.successColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: AppField.primaryField(
                    'Nama Lengkap',
                    'Masukkan nama lengkap Anda',
                    Icons.person_outline,
                  ),
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
                TextFormField(
                  readOnly: true,
                  controller: controller.federationController,
                  decoration: AppField.primaryField(
                    'Federasi *',
                    'Masukkan federasi Anda',
                    Icons.group_outlined,
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  controller: controller.levelController,
                  decoration: AppField.primaryField(
                    'Tingkatan *',
                    'Masukkan tingkatan Anda',
                    Icons.bar_chart_outlined,
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
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
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orangeColor,
                      ),
                      onPressed: () {
                        controller.updateProfile();
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
