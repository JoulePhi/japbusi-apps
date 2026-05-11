import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/appdata_model.dart';
import 'package:japbusi/app/data/services/app_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/handle_payload.dart';
import 'package:japbusi/main.dart';

class SplashController extends GetxController {
  final AppService _apiService = Get.find<AppService>();
  final Rx<AppData?> appData = Rx<AppData?>(null);

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
          print("Payload: ${launchDetails!.notificationResponse!.payload}");
          handlePayload(launchDetails!.notificationResponse!.payload);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e, trace) {
      print('Error fetching app data: $e');
      print('Stack trace: $trace');
    }
  }
}
