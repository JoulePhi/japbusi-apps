// lib/app/data/services/auth_service.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:japbusi/app/data/griveance_provider.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';

class GriveanceService extends GetxService {
  final GriveanceProvider _grievanceProvider = Get.find<GriveanceProvider>();

  Future<GriveanceService> init() async {
    return this;
  }

  Future<List<Griveance>> getGrievances() async {
    final response = await _grievanceProvider.grievances();
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    List<Griveance> grievances = [];
    if (response.body['data'] is List) {
      grievances = (response.body['data'] as List)
          .map((item) => Griveance.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    return grievances;
  }

  Future<Griveance> getDetail(int nomor) async {
    final response = await _grievanceProvider.grievance(nomor);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    print("Response body: ${response.body}");
    Griveance grievance = Griveance.fromJson(
      Map<String, dynamic>.from(response.body),
    );
    return grievance;
  }
}
