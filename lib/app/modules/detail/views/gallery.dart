import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/modules/detail/controllers/detail_controller.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class Gallery extends GetView<DetailController> {
  const Gallery({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text('Lampiran', style: AppTextStyles.caption),
          ),
          Obx(() {
            if (controller.grievanceDetail.value!.files.isEmpty) {
              return Center(
                child: Text('Tidak ada lampiran', style: AppTextStyles.caption),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: controller.grievanceDetail.value!.files.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl:
                      controller.grievanceDetail.value!.files[index] ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
