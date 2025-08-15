import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/services/griveance_service.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';

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
}
