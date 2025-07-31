import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:japbusi/app/data/auth_provider.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/utils/api_client.dart';
import 'package:japbusi/app/utils/app_theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    GetMaterialApp(
      title: "Japbusi",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    ),
  );
}

Future<void> initServices() async {
  await Get.putAsync(() => ApiClient().init());
  Get.lazyPut(() => AuthProvider());
  await Get.putAsync(() => AuthService().init());
}
