import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00935E),
      body: Center(
        child: Image.asset('assets/icon1024px.png', width: 200, height: 200),
      ),
    );
  }
}
