import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';

class GriveanceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://japbusi.org/api';
    httpClient.defaultContentType = 'application/json';
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

  Future<Response> grievances(String? search, {String status = 'all'}) async {
    final response = await get(
      '/grievances',
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
      query: {'search': search, 'status': status},
    );
    print("Requesting grievances with search: $search, status: $status");
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
    print("Response from grievances: ${response.body}");
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }

  Future<Response> grievance(String nomor) async {
    print('Nomor Request $nomor');
    final response = await get(
      '/grievance/$nomor',
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
    );
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
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }

  Future<Response> submitGrievance(Map<String, dynamic> data) async {
    final formMap = Map<String, dynamic>.from(data);
    formMap.remove('files');

    final form = FormData(formMap);
    final response = await post(
      '/submit-grievance',
      form,
      contentType: 'multipart/form-data',
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
    );
    print("Response from submitGrievance: ${response.body}");
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
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }

  Future<Response> submitFeedback(Map<String, dynamic> data) async {
    final formMap = Map<String, dynamic>.from(data);
    formMap.remove('files');

    final form = FormData(formMap);
    print("Submitting feedback with data: $formMap");
    final response = await post(
      '/submit-feedback',
      form,
      contentType: 'multipart/form-data',
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
    );
    print("Response from submitFeedback: ${response.body}");
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
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }
}
