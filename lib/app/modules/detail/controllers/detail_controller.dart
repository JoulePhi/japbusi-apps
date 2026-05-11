import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/models/reply_model.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class DetailController extends GetxController {
  final _griveanceService = Get.find<GriveanceService>();
  var grievanceDetail = Rxn<Griveance>();
  var isLoading = false.obs;
  var selectedIndex = 0.obs;
  final isSubmitting = false.obs;
  final descriptionController = TextEditingController();
  final Rx<Reply?> selectedReplyId = Rxn<Reply?>();

  RxList<File> selectedImages = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void viewImage(String imageUrl) {
    Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(imageUrl),
            TextButton(onPressed: () => Get.back(), child: Text('Tutup')),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    var nomor = Get.arguments['nomor'];
    print('Nomor Detail Aduan $nomor');
    if (nomor != null) {
      try {
        isLoading.value = true;
        _griveanceService.getDetail(nomor).then((grievance) {
          grievanceDetail.value = grievance;
        });
      } catch (e) {
        AppSnackbar.error("Terjadi Kesalahan", e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      AppSnackbar.error("Terjadi Kesalahan", "Gagal mendapatkan detail");
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
      AppSnackbar.error("Terjadi Kesalahan", "Gagal mendapatkan gambar");
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

  Future<void> submitFeedback() async {
    try {
      if (isSubmitting.value) return; // Prevent multiple submissions
      isSubmitting.value = true;

      if (selectedReplyId.value == null) {
        AppSnackbar.error(
          "Terjadi Kesalahan",
          "Pilih balasan yang ingin diberi feedback",
        );
        return;
      }

      Map<String, dynamic> data = {
        'reply_id': selectedReplyId.value!.id,
        'feedback_text': descriptionController.text,
        'feedback_files[]': [],
      };
      if (selectedImages.isNotEmpty) {
        data['feedback_files[]'] = selectedImages.map((file) {
          final mimeType =
              lookupMimeType(file.path) ?? 'application/octet-stream';
          final typeSplit = mimeType.split('/');
          return MultipartFile(
            file.path,
            filename: file.path.split('/').last,
            contentType: MediaType(typeSplit[0], typeSplit[1]).toString(),
          );
        }).toList();
      }
      await _griveanceService.submitFeedback(data);

      clearImages();
      descriptionController.clear();
      AppSnackbar.success("Berhasil", "Feedback berhasil dikirim");
      grievanceDetail.value = await _griveanceService.getDetail(
        grievanceDetail.value?.nomor ?? '',
      );
    } catch (e) {
      print("Error submitting feedback: $e");
      AppSnackbar.error("Terjadi Kesalahan", e.toString());
      return;
    } finally {
      isSubmitting.value = false;
    }
  }
}
