import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:japbusi/app/modules/detail/views/gallery.dart';
import 'package:japbusi/app/modules/detail/views/profile_item.dart';
import 'package:japbusi/app/modules/detail/views/timeline_lr.dart';
import 'package:japbusi/app/modules/detail/views/timeline_l.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengaduan'),
        centerTitle: true,
        backgroundColor: AppColors.successColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () =>
              controller.isLoading.value ||
                  controller.grievanceDetail.value == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border(
                          top: BorderSide(
                            color:
                                AppColors.statusColors[controller
                                    .grievanceDetail
                                    .value!
                                    .status] ??
                                AppColors.textSecondary,
                            width: 4,
                          ),
                          right: BorderSide(
                            color:
                                AppColors.statusColors[controller
                                    .grievanceDetail
                                    .value!
                                    .status] ??
                                AppColors.textSecondary,
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color:
                                AppColors.statusColors[controller
                                    .grievanceDetail
                                    .value!
                                    .status] ??
                                AppColors.textSecondary,
                            width: 1,
                          ),
                          left: BorderSide(
                            color:
                                AppColors.statusColors[controller
                                    .grievanceDetail
                                    .value!
                                    .status] ??
                                AppColors.textSecondary,
                            width: 1,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.grievanceDetail.value!.nomor.toString(),
                            style: AppTextStyles.headline3.copyWith(
                              color: AppColors.textPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Text(
                                  AppFormatter.formatDate(
                                    controller.grievanceDetail.value!.createdAt,
                                  ),
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                VerticalDivider(
                                  color: AppColors.textSecondary,
                                  thickness: 1,
                                  width: 20,
                                ),
                                Text(
                                  AppFormatter.formatStatus(
                                    controller.grievanceDetail.value!.status,
                                  ),
                                  style: AppTextStyles.caption.copyWith(
                                    color:
                                        AppColors.statusColors[controller
                                            .grievanceDetail
                                            .value!
                                            .status] ??
                                        AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Tahap Penyelesaian : ',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textPurple,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              AppFormatter.getStepIcon(
                                controller.grievanceDetail.value!.step,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                AppFormatter.formatStep(
                                  controller.grievanceDetail.value!.step,
                                ),
                                style: AppTextStyles.caption.copyWith(
                                  color:
                                      AppColors.stepColors[controller
                                          .grievanceDetail
                                          .value!
                                          .step] ??
                                      AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Tingkat : ',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textPurple,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.textSecondary,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                  horizontal: 10.0,
                                ),
                                child: Text(
                                  controller.grievanceDetail.value!.levelName,
                                  style: AppTextStyles.caption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Kategori : ',
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textPurple,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                controller.grievanceDetail.value!.categoryName,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                            spreadRadius: .2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTabItem(context, 0, Icons.info_outline),
                          _buildTabItem(context, 1, Icons.history_rounded),
                          _buildTabItem(
                            context,
                            2,
                            Icons.file_copy_rounded,
                            total:
                                controller.grievanceDetail.value!.files.length,
                          ),
                        ],
                      ),
                    ),
                    // Only the IndexedStack content is scrollable
                    Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          // Swipe left to go to next tab, right to previous
                          if (details.primaryVelocity != null) {
                            if (details.primaryVelocity! < 0) {
                              // Swipe Left
                              if (controller.selectedIndex.value < 2) {
                                controller.changeTab(
                                  controller.selectedIndex.value + 1,
                                );
                              }
                            } else if (details.primaryVelocity! > 0) {
                              // Swipe Right
                              if (controller.selectedIndex.value > 0) {
                                controller.changeTab(
                                  controller.selectedIndex.value - 1,
                                );
                              }
                            }
                          }
                        },
                        child: Obx(
                          () => IndexedStack(
                            index: controller.selectedIndex.value,
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileInfoItem(
                                      title: 'Nama',
                                      value: controller
                                          .grievanceDetail
                                          .value!
                                          .user!
                                          .name,
                                      icon: Icons.person,
                                    ),
                                    ProfileInfoItem(
                                      title: 'Email',
                                      value: controller
                                          .grievanceDetail
                                          .value!
                                          .user!
                                          .email,
                                      icon: Icons.email_rounded,
                                    ),
                                    ProfileInfoItem(
                                      title: 'Federasi',
                                      value:
                                          controller
                                                  .grievanceDetail
                                                  .value!
                                                  .user!
                                                  .federationName !=
                                              null
                                          ? '${controller.grievanceDetail.value!.user!.federationName} (${controller.grievanceDetail.value!.user!.levelName ?? ''} ${controller.grievanceDetail.value!.user!.subLevelName ?? ''})'
                                          : '-',
                                      icon: Icons.email_rounded,
                                    ),
                                    Text(
                                      'Detail Pengaduan :',
                                      style: AppTextStyles.headline3.copyWith(
                                        color: AppColors.textPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.textPurpleAccent,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Html(
                                        data: controller
                                            .grievanceDetail
                                            .value!
                                            .detail,
                                        style: {
                                          "body": Style(
                                            color: AppColors.textPrimary,
                                            fontSize: FontSize(14),
                                          ),
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TimelineL(),
                              Gallery(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    int index,
    IconData icon, {
    int total = 0,
  }) {
    final isSelected = controller.selectedIndex.value == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Obx(
      () => GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: controller.selectedIndex.value == index
                    ? AppColors.successColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                size: 24,
                color: isSelected
                    ? AppColors.successColor
                    : AppColors.textSecondary,
              ),
            ),
            if (total != 0)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Text(
                    '$total',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(IconData icon, String title) {
    return Container(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Theme.of(Get.context!).primaryColor.withOpacity(0.7),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Theme.of(Get.context!).primaryColor,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tab Content',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(Get.context!).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
