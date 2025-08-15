import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/appdata_model.dart';
import 'package:japbusi/app/data/services/app_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final AppService _apiService = Get.find<AppService>();
  final Rx<AppData?> appData = Rx<AppData?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchAppData();
  }

  void fetchAppData() async {
    try {
      print('Fetching app data...');
      appData.value = await _apiService.getAppData();
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print('Error fetching app data: $e');
    }
  }
}
