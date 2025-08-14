import 'package:get/get.dart';
import 'package:japbusi/app/data/models/article_model.dart';
import 'package:japbusi/app/data/services/home_service.dart';

class ArticleDetailController extends GetxController {
  late HomeService _homeService;

  final isArticleLoading = false.obs;
  final Rx<Article?> article = Rx<Article?>(null);

  @override
  void onInit() {
    super.onInit();
    _homeService = Get.find<HomeService>();
    final int articleId = Get.arguments['id'];
    fetchArticle(articleId);
  }

  Future<void> fetchArticle(int id) async {
    try {
      isArticleLoading.value = true;
      article.value = await _homeService.getArticle(id);
    } catch (e) {
      print("Error fetching article: $e");
      Get.snackbar("Error", "Failed to load article: $e");
    } finally {
      isArticleLoading.value = false;
    }
  }
}
