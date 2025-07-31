import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';

class DetailController extends GetxController {
  final _griveanceService = Get.find<GriveanceService>();
  var grievanceDetail = Rxn<Griveance>();
  var isLoading = false.obs;
  var selectedIndex = 0.obs;

  RxList<File> selectedImages = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    var nomor = Get.arguments['nomor'];
    if (nomor != null) {
      try {
        isLoading.value = true;
        _griveanceService.getDetail(nomor).then((grievance) {
          print("Grievance detail fetched: ${grievance.nomor}");
          grievanceDetail.value = grievance;
        });
      } catch (e) {
        Get.snackbar("Error", "Failed to fetch grievance detail");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "No grievance number provided");
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
      Get.snackbar(
        'Error',
        'Failed to pick images: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
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
}
