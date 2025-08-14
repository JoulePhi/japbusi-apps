import 'package:get/get.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://smilecloud.id/japbusi2/api';
  }

  Future<Response> articles(String? search, {int limit = 10}) async {
    search ??= '';
    final response = await get('/articles?search=$search&limit=$limit');
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    // print("Response from articles: ${response.body}");
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }

  Future<Response> article(int id) async {
    final response = await get('/article/$id');
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    // print("Response from article: ${response.body}");
    return Response(
      statusCode: response.statusCode,
      body: response.body,
      statusText: response.statusText,
    );
  }
}
