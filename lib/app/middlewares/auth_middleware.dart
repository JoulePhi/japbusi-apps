import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();

    if (_isPublicRoute(route)) {
      if (authService.isLoggedIn && (route == Routes.AUTH)) {
        return RouteSettings(name: '/');
      }
      return null;
    }

    if (!authService.isLoggedIn) {
      return RouteSettings(name: Routes.AUTH, arguments: {'redirectTo': route});
    }

    return null;
  }

  bool _isPublicRoute(String? route) {
    return route == Routes.AUTH;
  }
}
