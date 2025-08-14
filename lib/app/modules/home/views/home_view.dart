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
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        physics: const BouncingScrollPhysics(),
        children: [
          Navigator(
            key: Get.nestedKey(1),
            initialRoute: '/',
            onGenerateRoute: (settings) => controller.getRoute(settings, 1),
          ),
          Navigator(
            key: Get.nestedKey(2),
            initialRoute: '/',
            onGenerateRoute: (settings) => controller.getRoute(settings, 2),
          ),
          Navigator(
            key: Get.nestedKey(3),
            initialRoute: '/',
            onGenerateRoute: (settings) => controller.getRoute(settings, 3),
          ),
          Navigator(
            key: Get.nestedKey(4),
            initialRoute: '/',
            onGenerateRoute: (settings) => controller.getRoute(settings, 4),
          ),
        ],
        // Set the current page to match the selected menu
        // This is handled by controller.pageController.animateToPage in onTap/onPageChanged
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.selectedMenu.value,
          onTap: (index) {
            controller.switchTab(index);
            controller.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          type: BottomNavigationBarType.shifting,
          useLegacyColorScheme: false,
          selectedItemColor: AppColors.successColor,
          unselectedItemColor: AppColors.successColor.withAlpha(153),
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
