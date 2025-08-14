import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/article_model.dart';
import 'package:japbusi/app/data/services/home_service.dart';

class ArticleController extends GetxController {
  late HomeService _homeService;
  final isArticleLoading = false.obs;
  final RxList<Article> articles = <Article>[].obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _homeService = Get.find<HomeService>();
    fetchArticles(null);
    searchController.addListener(() {
      final query = searchController.text.isEmpty
          ? null
          : searchController.text;

      articles.clear();
      if (query != null && query.length >= 3) {
        fetchArticles(query);
      } else {
        fetchArticles(null);
      }
    });
  }

  Future<void> fetchArticles(String? search) async {
    try {
      isArticleLoading.value = true;
      articles.value = await _homeService.getArticles(search, limit: 20);
    } catch (e) {
      print("Error fetching articles: $e");
      Get.snackbar("Error", "Failed to load articles: $e");
    } finally {
      isArticleLoading.value = false;
    }
  }
}
