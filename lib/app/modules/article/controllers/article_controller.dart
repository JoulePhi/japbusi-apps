import 'package:get/get.dart';
import 'package:japbusi/app/data/models/article_model.dart';
import 'package:japbusi/app/data/services/home_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ArticleDetailController extends GetxController {
  late HomeService _homeService;

  final isArticleLoading = false.obs;
  final Rx<Article?> article = Rx<Article?>(null);

  @override
  void onInit() {
    super.onInit();
    _homeService = Get.find<HomeService>();
    final int articleId = int.parse(Get.arguments['id'].toString());
    fetchArticle(articleId);
  }

  Future<void> fetchArticle(int id) async {
    try {
      isArticleLoading.value = true;
      article.value = await _homeService.getArticle(id);
    } catch (e) {
      print("Error fetching article: $e");
      AppSnackbar.error("Error", "Failed to load article: $e");
    } finally {
      isArticleLoading.value = false;
    }
  }

  void shareArticle() {
    if (article.value != null) {
      final String shareContent =
          "${article.value!.title}\n\nBaca selengkapnya di: https://japbusi.org/detailArtikel/${article.value!.slug}";
      SharePlus.instance.share(ShareParams(text: shareContent));
    } else {
      AppSnackbar.error("Error", "Artikel tidak tersedia untuk dibagikan");
    }
  }
}
