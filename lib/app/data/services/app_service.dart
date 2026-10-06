// lib/app/data/services/auth_service.dart
import 'package:get/get.dart';
import 'package:japbusi/app/data/app_provider.dart';
import 'package:japbusi/app/data/models/appdata_model.dart';
import 'package:japbusi/app/data/models/article_category_model.dart';
import 'package:japbusi/app/data/models/carousel_model.dart';
import 'package:japbusi/app/data/models/city_model.dart';
import 'package:japbusi/app/data/models/federation_model.dart';
import 'package:japbusi/app/data/models/province_model.dart';

class AppService extends GetxService {
  final AppProvider _appProvider = Get.find<AppProvider>();

  Future<AppService> init() async {
    return this;
  }

  Future<AppData> getAppData() async {
    final response = await _appProvider.appData();
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    List<Province> provinces = [];
    List<City> cities = [];
    List<Federation> federations = [];
    List<Carousel> carousels = [];
    List<ArticleCategory> articleCategories = [];
    if (response.body['provinces'] is List) {
      provinces = (response.body['provinces'] as List)
          .map((item) => Province.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    if (response.body['cities'] is List) {
      cities = (response.body['cities'] as List)
          .map((item) => City.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    if (response.body['federations'] is List) {
      federations = (response.body['federations'] as List)
          .map((item) => Federation.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    if (response.body['carousels'] is List) {
      carousels = (response.body['carousels'] as List)
          .map((item) => Carousel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }
    if (response.body['article_categories'] is List) {
      articleCategories = (response.body['article_categories'] as List)
          .map(
            (item) => ArticleCategory.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();
      // push "All" category at the beginning
      articleCategories.insert(
        0,
        ArticleCategory(
          id: '0',
          namaKategori: 'Semua',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }

    return AppData(
      provinces: provinces,
      cities: cities,
      federations: federations,
      carousels: carousels,
      articleCategories: articleCategories,
    );
  }
}
