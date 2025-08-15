// lib/app/data/services/auth_service.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:japbusi/app/data/griveance_provider.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/services/auth_service.dart';

class GriveanceService extends GetxService {
  final GriveanceProvider _grievanceProvider = Get.find<GriveanceProvider>();

  Future<GriveanceService> init() async {
    return this;
  }

  Future<List<Griveance>> getGrievances(String? search) async {
    final response = await _grievanceProvider.grievances(search);
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

  Future<Griveance> getDetail(String nomor) async {
    final response = await _grievanceProvider.grievance(nomor);
    if (response.status.hasError) {
      final messages = response.body['messages'] ?? [];
      String error = '';
      if (messages is Map) {
        error = messages.values.first;
      } else {
        error = messages;
      }
      throw Exception(error);
    }
    Griveance grievance = Griveance.fromJson(
      Map<String, dynamic>.from(response.body),
    );
    return grievance;
  }

  Future<String> submitGrievance(Map<String, dynamic> data) async {
    final response = await _grievanceProvider.submitGrievance(data);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    return response.body['nomor'] as String;
  }
}
