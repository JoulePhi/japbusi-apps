import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:japbusi/app/modules/home/controllers/main_controller.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<MainController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.selectedMenu.value,
          children: [
            Navigator(
              key: Get.nestedKey(1), // Unique key for first tab
              initialRoute: '/',
              onGenerateRoute: (settings) => controller.getRoute(settings, 1),
            ),
            Navigator(
              key: Get.nestedKey(2), // Unique key for second tab
              initialRoute: '/',
              onGenerateRoute: (settings) => controller.getRoute(settings, 2),
            ),
            Navigator(
              key: Get.nestedKey(3), // Unique key for third tab
              initialRoute: '/',
              onGenerateRoute: (settings) => controller.getRoute(settings, 3),
            ),
            Navigator(
              key: Get.nestedKey(4), // Unique key for fourth tab
              initialRoute: '/',
              onGenerateRoute: (settings) => controller.getRoute(settings, 4),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedMenu.value,
          onTap: controller.switchTab,
          type: BottomNavigationBarType.shifting,
          useLegacyColorScheme: false,
          selectedItemColor: AppColors.successColor,
          unselectedItemColor: AppColors.successColor.withValues(alpha: 0.6),
          selectedLabelStyle: AppTextStyles.success.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: AppTextStyles.success.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          iconSize: 20,
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.commentDots),
              label: 'Pengaduan',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bookOpen),
              label: 'Artikel',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.gear),
              label: 'Pengaturan',
            ),
          ],
        ),
      ),
    );
  }
}
