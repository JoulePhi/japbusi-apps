import 'package:get/get.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GriveanceService());
    Get.put<DetailController>(DetailController());
  }
}
