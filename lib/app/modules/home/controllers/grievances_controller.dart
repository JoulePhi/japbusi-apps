import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class GrievancesController extends GetxController {
  late GriveanceService _grievanceService;
  var grievances = <Griveance>[];
  var isLoading = false;
  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    _grievanceService = Get.find<GriveanceService>();
    searchController.addListener(() {
      final query = searchController.text.isEmpty
          ? null
          : searchController.text;

      grievances.clear();
      if (query != null && query.length >= 3) {
        fetchGrievances(query);
      } else {
        fetchGrievances(null);
      }
    });
    // fetchGrievances();
  }

  void fetchGrievances(String? search) async {
    isLoading = true;
    update();
    try {
      search ??= '';
      grievances = await _grievanceService.getGrievances(search);
    } catch (e) {
      if (e.toString().contains('Unauthorized')) {
        await Get.find<AuthService>().logout();
      } else {
        print("Error fetching grievances: $e");
        AppSnackbar.error("Terjadi Kesalahan", 'gagal mendapatkan list aduan');
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}
