import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/modules/home/bindings/article_binding.dart';
import 'package:japbusi/app/modules/home/bindings/grievances_binding.dart';
import 'package:japbusi/app/modules/home/bindings/home_binding.dart';
import 'package:japbusi/app/modules/home/bindings/settings_binding.dart';
import 'package:japbusi/app/modules/home/controllers/article_controller.dart';
import 'package:japbusi/app/modules/home/controllers/grievances_controller.dart';
import 'package:japbusi/app/modules/home/controllers/home_controller.dart';
import 'package:japbusi/app/modules/home/controllers/settings_controller.dart';
import 'package:japbusi/app/modules/home/views/article_tab.dart';
import 'package:japbusi/app/modules/home/views/grievances_tab.dart';
import 'package:japbusi/app/modules/home/views/home_tab.dart';
import 'package:japbusi/app/modules/home/views/settings_tab.dart';

class MainController extends GetxController {
  final selectedMenu = 0.obs;

  Route getRoute(RouteSettings settings, int tabId) {
    Widget page;
    switch (tabId) {
      case 1:
        page = HomeTab();
        break;
      case 2:
        page = GrievancesTab(); // Assuming you have a GrievancesTab view
        break;
      case 3:
        page = ArticleTab(); // Assuming you have a ArticleTab view
        break;
      case 4:
        page = SettingsTab(); // Assuming you have a SettingsTab view
        break;
      default:
        page = HomeTab(); // Default to HomeTab if no match
        break;
    }

    return GetPageRoute(
      page: () => page,
      binding: getBinding(tabId), // Get the appropriate binding
      settings: settings,
    );
  }

  Bindings? getBinding(int tabId) {
    switch (tabId) {
      case 1:
        return HomeBinding();
      case 2:
        return GrievancesBinding(); // Assuming you have a GrievancesBinding
      case 3:
        return ArticleBinding(); // Assuming you have a ArticleBinding
      case 4:
        return SettingsBinding(); // Assuming you have a SettingsBinding
      default:
        return HomeBinding();
    }
  }

  void switchTab(int index) {
    // First update the current index
    print("Switching to tab: $index");
    selectedMenu.value = index;

    // Then reinitialize the binding for the selected tab
    switch (index) {
      case 1:
        Get.delete<HomeController>();
        HomeBinding().dependencies();
        break;
      case 2:
        Get.delete<GrievancesController>();
        GrievancesBinding().dependencies();
        break;
      case 3:
        Get.delete<ArticleController>();
        ArticleBinding().dependencies();
        break;
      case 4:
        Get.delete<SettingsController>();
        SettingsBinding().dependencies();
        break;
    }
  }
}
