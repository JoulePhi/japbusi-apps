import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';

class GriveanceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://smilecloud.id/japbusi2/api';
    httpClient.defaultContentType = 'application/json';
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

  Future<Response> grievances(String? search) async {
    final response = await get(
      '/grievances',
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
      query: {'search': search},
    );
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    print("Response from grievances: ${response.body}");
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }

  Future<Response> grievance(int nomor) async {
    final response = await get(
      '/grievance/$nomor',
      headers: {'authorization': 'Bearer ${Get.find<AuthService>().token}'},
    );
    if (response.status.hasError) {
      throw Exception(response.statusText);
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
      throw Exception(response.statusText);
    }
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }
}
