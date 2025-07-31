import 'package:get/get.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';

class GrievancesController extends GetxController {
  late GriveanceService _grievanceService;
  var grievances = <Griveance>[];
  var isLoading = false;
  @override
  void onInit() {
    super.onInit();
    _grievanceService = Get.find<GriveanceService>();
    // fetchGrievances();
  }

  void fetchGrievances() async {
    print("Fetching grievances...");
    isLoading = true;
    update();
    try {
      grievances = await _grievanceService.getGrievances();
    } catch (e) {
      print("Error fetching grievances: $e");
      Get.snackbar("Error", "Failed to fetch grievances");
    } finally {
      isLoading = false;
      update();
    }
  }
}
