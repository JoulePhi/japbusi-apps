import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/modules/detail/controllers/detail_controller.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineL extends GetView<DetailController> {
  const TimelineL({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: controller.grievanceDetail.value!.replies != null
                    ? controller.grievanceDetail.value!.replies!.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final reply = entry.value;
                        final isLast =
                            index ==
                            controller.grievanceDetail.value!.replies!.length -
                                1;
                        return TimelineTile(
                          alignment: TimelineAlign.manual,
                          beforeLineStyle: LineStyle(
                            color:
                                AppColors.replyColors[int.parse(reply.step)] ??
                                AppColors.textSecondary,
                            thickness: 2,
                          ),
                          lineXY: 0,
                          isFirst: index == 0,
                          isLast: isLast,
                          indicatorStyle: IndicatorStyle(
                            width: 15,
                            color:
                                AppColors.replyColors[int.parse(reply.step)] ??
                                AppColors.textSecondary,
                          ),
                          startChild: null,
                          endChild: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                            child: Stack(
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () async {
                                    // shows bottom sheet with reply details
                                    var res = await Get.bottomSheet(
                                      Container(
                                        padding: EdgeInsets.all(16),
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            top: BorderSide(
                                              color:
                                                  AppColors
                                                      .replyColors[int.parse(
                                                    reply.step,
                                                  )] ??
                                                  AppColors.textSecondary,
                                              width: 4,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                AppFormatter.getStepIcon(
                                                  int.parse(reply.step),
                                                ),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: SizedBox(
                                                    child: Text(
                                                      AppFormatter.formatStep(
                                                        int.parse(reply.step),
                                                      ),
                                                      softWrap: true,
                                                      style: AppTextStyles
                                                          .caption
                                                          .copyWith(
                                                            color:
                                                                AppColors
                                                                    .replyColors[int.parse(
                                                                  reply.step,
                                                                )],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10.0),
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.user,
                                                  size: 10,
                                                  color:
                                                      AppColors.textSecondary,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  '${reply.user!.name} | ${AppFormatter.formatDateTime(reply.createdAt)}',
                                                  style: AppTextStyles.caption
                                                      .copyWith(
                                                        color: AppColors
                                                            .textSecondary,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            if (reply.feedback == '1')
                                              Text(
                                                'Balasan ini membutuhkan feedback',
                                                style: AppTextStyles.caption
                                                    .copyWith(
                                                      color: Colors.redAccent,
                                                    ),
                                              ),
                                            SizedBox(height: 20.0),
                                            Container(
                                              padding: EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.textPurpleAccent,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Html(
                                                data: reply.answer.isEmpty
                                                    ? 'Tidak ada jawaban'
                                                    : reply.answer,
                                                style: {
                                                  "body": Style(
                                                    color:
                                                        AppColors.textPrimary,
                                                    fontSize: FontSize(14),
                                                  ),
                                                },
                                              ),
                                            ),
                                            if (reply.feedback == '1')
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 20.0),
                                                  TextField(
                                                    maxLines: 4,
                                                    decoration: InputDecoration(
                                                      hintText: 'Feedback Anda',
                                                      border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .textSecondary
                                                              .withOpacity(0.3),
                                                          width: .5,
                                                        ),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .textSecondary,
                                                          width: .5,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  // add pick images button
                                                  Obx(
                                                    () =>
                                                        controller
                                                            .selectedImages
                                                            .isNotEmpty
                                                        ? Wrap(
                                                            spacing: 8.0,
                                                            runSpacing: 8.0,
                                                            children: controller.selectedImages.map((
                                                              image,
                                                            ) {
                                                              return Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                  image: DecorationImage(
                                                                    image:
                                                                        FileImage(
                                                                          image,
                                                                        ),
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          )
                                                        : SizedBox.shrink(),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      controller
                                                          .pickMultipleImages();
                                                    },
                                                    child: Text('Pilih Gambar'),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                    controller.selectedImages.clear();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: 8,
                                      left: 8,
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            AppColors.replyColors[int.parse(
                                              reply.step,
                                            )] ??
                                            AppColors.textSecondary,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                          spreadRadius: .2,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AppFormatter.getStepIcon(
                                              int.parse(reply.step),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: SizedBox(
                                                child: Text(
                                                  AppFormatter.formatStep(
                                                    int.parse(reply.step),
                                                  ),
                                                  softWrap: true,
                                                  style: AppTextStyles.caption
                                                      .copyWith(
                                                        color:
                                                            AppColors
                                                                .replyColors[int.parse(
                                                              reply.step,
                                                            )],
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.user,
                                              size: 10,
                                              color: AppColors.textSecondary,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '${reply.user!.name} | ${AppFormatter.formatDateTime(reply.createdAt)}',
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        if (reply.feedback == '1')
                                          Text(
                                            'Balasan ini membutuhkan feedback',
                                            style: AppTextStyles.caption
                                                .copyWith(
                                                  color: Colors.redAccent,
                                                ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Badge with plus icon
                                if (reply.feedback == '1')
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList()
                    : [Center(child: Text('No replies available'))],
              ),
            ),
    );
  }
}
