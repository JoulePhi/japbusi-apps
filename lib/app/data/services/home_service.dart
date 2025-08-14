// lib/app/data/services/auth_service.dart
import 'package:get/get.dart';
import 'package:japbusi/app/data/home_provicer.dart';
import 'package:japbusi/app/data/models/article_model.dart';

class HomeService extends GetxService {
  final HomeProvider _articleProvider = Get.find<HomeProvider>();

  Future<HomeService> init() async {
    return this;
  }

  Future<List<Article>> getArticles(String? search, {int limit = 10}) async {
    final response = await _articleProvider.articles(search, limit: limit);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    List<Article> articles = [];
    if (response.body['data'] is List) {
      articles = (response.body['data'] as List)
          .map((item) => Article.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    return articles;
  }

  Future<Article> getArticle(int id) async {
    final response = await _articleProvider.article(id);
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    Article article = Article.fromJson(
      Map<String, dynamic>.from(response.body['data'] as Map<String, dynamic>),
    );
    return article;
  }
}
