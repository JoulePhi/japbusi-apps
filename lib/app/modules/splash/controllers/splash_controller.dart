import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/appdata_model.dart';
import 'package:japbusi/app/data/services/app_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/main.dart';

class SplashController extends GetxController {
  final AppService _apiService = Get.find<AppService>();
  final Rx<AppData?> appData = Rx<AppData?>(null);

  void _handlePayload(String? payload) {
    if (payload != null) {
      final data = jsonDecode(payload);
      switch (data['type']) {
        case 'article':
          Get.toNamed(Routes.ARTICLE, arguments: {"id": data['id']});
          break;
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();

    fetchAppData();
  }

  void fetchAppData() async {
    try {
      appData.value = await _apiService.getAppData();
      final launchDetails = await flutterLocalNotificationsPlugin
          .getNotificationAppLaunchDetails();

      if (launchDetails?.didNotificationLaunchApp ?? false) {
        if (launchDetails?.notificationResponse != null) {
          _handlePayload(launchDetails!.notificationResponse!.payload);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      print('Error fetching app data: $e');
    }
  }
}
