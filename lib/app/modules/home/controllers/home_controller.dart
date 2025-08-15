import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:japbusi/app/data/models/article_model.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';
import 'package:japbusi/app/data/services/home_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

class HomeController extends GetxController {
  late GriveanceService _grievanceService;
  late HomeService _homeService;
  RxList<File> selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController descriptionController = TextEditingController();
  final isSubmitting = false.obs;
  final isArticleLoading = false.obs;
  final RxList<Article> articles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    _grievanceService = Get.find<GriveanceService>();
    _homeService = Get.find<HomeService>();
    // close keyboard
    FocusScope.of(Get.context!).unfocus();
    fetchArticles(null);
    // fetchGrievances();
  }

  Future<void> fetchArticles(String? search) async {
    try {
      isArticleLoading.value = true;
      articles.value = await _homeService.getArticles(search, limit: 5);
    } catch (e) {
      print("Error fetching articles: $e");
      AppSnackbar.error("Terjadi Kesalahan", "gagal mendapatkan artikel");
    } finally {
      isArticleLoading.value = false;
    }
  }

  Future<void> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();

      if (images.isNotEmpty) {
        // Convert XFile to File and add to our observable list
        for (var image in images) {
          selectedImages.add(File(image.path));
        }
      }
    } catch (e) {
      AppSnackbar.error("Terjadi Kesalahan", "gagal mendapatkan gambar");
    }
  }

  void clearImages() {
    selectedImages.clear();
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  Future<String> submitGrievance() async {
    try {
      if (isSubmitting.value) return ''; // Prevent multiple submissions
      isSubmitting.value = true;
      if (descriptionController.text.isEmpty) {
        AppSnackbar.error("Gagal Mengirim", "Deskripsi tidak boleh kosong");
        return '';
      }
      Map<String, dynamic> data = {
        'description': descriptionController.text,
        'files[]': [],
      };
      if (selectedImages.isNotEmpty) {
        data['files[]'] = selectedImages
            .map(
              (file) =>
                  MultipartFile(file.path, filename: file.path.split('/').last),
            )
            .toList();
      }
      String grievanceId = await _grievanceService.submitGrievance(data);

      clearImages();
      descriptionController.clear();
      return grievanceId;
    } catch (e) {
      print("Error submitting grievance: $e");
      AppSnackbar.error("Terjadi Kesalahan", "gagal mengirim aduan");
      return '';
    } finally {
      isSubmitting.value = false;
    }
  }
}
