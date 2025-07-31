import 'package:get/get.dart';
import 'package:japbusi/app/modules/home/controllers/main_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
