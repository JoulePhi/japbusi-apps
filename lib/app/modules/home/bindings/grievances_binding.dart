import 'package:get/get.dart';
import 'package:japbusi/app/data/griveance_provider.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';
import 'package:japbusi/app/modules/home/controllers/grievances_controller.dart';

import '../controllers/home_controller.dart';

class GrievancesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrievancesController>(() => GrievancesController());
  }
}
