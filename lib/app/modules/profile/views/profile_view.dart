import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:japbusi/app/data/models/city_model.dart';
import 'package:japbusi/app/modules/splash/controllers/splash_controller.dart';
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
          physics: const BouncingScrollPhysics(),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    () => Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectGender('l'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.selectedGender.value == 'l'
                                      ? Colors.blue
                                      : Colors.grey.shade400,
                                ),
                                color: controller.selectedGender.value == 'l'
                                    ? Colors.blue.shade50
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    color:
                                        controller.selectedGender.value == 'l'
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Laki-laki",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          controller.selectedGender.value == 'l'
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.selectGender('p'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.selectedGender.value == 'p'
                                      ? Colors.pink
                                      : Colors.grey.shade400,
                                ),
                                color: controller.selectedGender.value == 'p'
                                    ? Colors.pink.shade50
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female,
                                    color:
                                        controller.selectedGender.value == 'p'
                                        ? Colors.pink
                                        : Colors.grey,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Perempuan",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          controller.selectedGender.value == 'p'
                                          ? Colors.pink
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
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
                          return ('${city.type} ${city.name}')
                              .toLowerCase()
                              .contains(query);
                        });
                      },
                      displayStringForOption: (City city) =>
                          '${city.type} ${city.name}',
                      initialValue: controller.selectedCity.value.isNotEmpty
                          ? TextEditingValue(
                              text:
                                  Get.find<SplashController>()
                                      .appData
                                      .value!
                                      .cities
                                      .firstWhereOrNull(
                                        (c) =>
                                            c.id ==
                                            controller.selectedCity.value,
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
                                if (value.isEmpty)
                                  controller.selectedCity.value = '';
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.companyController,
                    decoration: AppField.primaryField(
                      'Nama Perusahaan *',
                      'Masukkan nama perusahaan Anda',
                      Icons.business_outlined,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: controller.workplaceController,
                    decoration: AppField.primaryField(
                      'Jenis Pekerjaan *',
                      'Masukkan jenis pekerjaan Anda',
                      Icons.work_outline,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    readOnly: true,
                    controller: controller.federationController,
                    decoration: AppField.primaryField(
                      'Federasi',
                      'Masukkan federasi Anda',
                      Icons.group_outlined,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    readOnly: true,
                    controller: controller.subLevelController,
                    decoration: AppField.primaryField(
                      controller.levelController.text,
                      'Masukkan ${controller.levelController.text} Anda',
                      Icons.bar_chart_outlined,
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
