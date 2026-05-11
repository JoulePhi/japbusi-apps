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
  Map<String, String> tabs = {
    "all": "Semua",
    "0": "Proses",
    "1": "Selesai",
    "2": "Arsip",
  };
  RxString selectedTabIndex = "all".obs;
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
        fetchGrievances();
      } else {
        fetchGrievances();
      }
    });
    // fetchGrievances();
  }

  void fetchGrievances() async {
    isLoading = true;
    update();
    try {
      grievances = await _grievanceService.getGrievances(
        searchController.text.isEmpty ? null : searchController.text,
        selectedTabIndex.value,
      );
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
