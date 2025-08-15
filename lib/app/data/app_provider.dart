import 'package:get/get.dart';

class AppProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://smilecloud.id/japbusi2/api';
  }

  Future<Response> appData() async {
    final response = await get('/app-data');
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
