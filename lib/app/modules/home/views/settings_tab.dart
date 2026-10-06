import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/modules/home/controllers/article_controller.dart';
import 'package:japbusi/app/modules/home/controllers/home_controller.dart';
import 'package:japbusi/app/modules/home/controllers/settings_controller.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class SettingsTab extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.successColor,
        centerTitle: false,
        title: Text(
          'Pengaturan',
          style: AppTextStyles.headline3.copyWith(color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.NOTIFICATIONS);
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidBell,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              // Badge
              Obx(
                () => Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      Get.find<AuthService>().notifications.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.faceSmile,
                        color: AppColors.orangeColor,
                      ),
                      title: Text(
                        'Profil',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.PROFILE);
                      },
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.lock,
                        color: AppColors.orangeColor,
                      ),
                      title: Text(
                        'Ganti Password',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () {
                        Get.toNamed(Routes.CHANGE_PASSWORD);
                      },
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: AppColors.orangeColor,
                      ),
                      title: Text(
                        'Logout',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () {
                        controller.logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
