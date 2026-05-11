import 'package:get/get.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://japbusi.org/api';
  }

  Future<Response> articles(
    String? search, {
    int page = 1,
    int limit = 10,
    String category = '0',
  }) async {
    search ??= '';
    final response = await get(
      '/articles?search=$search&page=$page&limit=$limit&category=$category',
    );
    print(
      "Requested URL: ${httpClient.baseUrl}/articles?search=$search&page=$page&limit=$limit&category=$category",
    );
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
