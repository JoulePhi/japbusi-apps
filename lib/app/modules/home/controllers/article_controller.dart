import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/article_model.dart';
import 'package:japbusi/app/data/services/home_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class ArticleController extends GetxController {
  late HomeService _homeService;
  final isArticleLoading = false.obs;
  final RxList<Article> articles = <Article>[].obs;
  var isMoreLoading = false.obs;
  var page = 1;
  final int limit = 10;
  var hasMore = true.obs;
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

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
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        if (hasMore.value && !isMoreLoading.value) {
          loadMoreArticles(
            searchController.text.isEmpty ? null : searchController.text,
          );
        }
      }
    });
  }

  Future<void> fetchArticles(String? search) async {
    try {
      isArticleLoading.value = true;
      final fetched = await _homeService.getArticles(
        search,
        page: page,
        limit: limit,
      );
      articles.assignAll(fetched);
      if (fetched.length < limit) hasMore(false);
    } catch (e) {
      print("Error fetching articles: $e");
      AppSnackbar.error("Terjadi Kesalahan", 'gagal mendapatkan artikel');
    } finally {
      isArticleLoading.value = false;
    }
  }

  Future<void> loadMoreArticles(String? search) async {
    if (!hasMore.value || isMoreLoading.value) return;
    isMoreLoading(true);
    page++;
    try {
      final fetched = await _homeService.getArticles(
        search,
        page: page,
        limit: limit,
      );
      if (fetched.isNotEmpty) {
        articles.addAll(fetched);
        if (fetched.length < limit) hasMore(false);
      } else {
        hasMore(false);
      }
    } finally {
      isMoreLoading(false);
    }
  }
}
