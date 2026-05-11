import 'dart:convert';

import 'package:get/get.dart';
import 'package:japbusi/app/routes/app_pages.dart';

void handlePayload(String? payload) {
  if (payload != null) {
    final data = jsonDecode(payload);
    switch (data['type_notif']) {
      case 'grievance':
        Get.toNamed(
          Routes.DETAIL,
          arguments: {'nomor': data['id_data']},
          parameters: {'fromNotification': 'true'},
        );
        break;
      case 'article':
        Get.toNamed(
          Routes.ARTICLE,
          arguments: {'id': data['id_data']},
          parameters: {'fromNotification': 'true'},
        );
        break;
      default:
        Get.toNamed(Routes.HOME);
        break;
    }
  }
}
