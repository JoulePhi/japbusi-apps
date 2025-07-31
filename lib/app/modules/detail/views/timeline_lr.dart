import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/modules/detail/controllers/detail_controller.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineLr extends GetView<DetailController> {
  const TimelineLr({super.key});
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
                        final isLeft = index % 2 == 0;
                        final isLast =
                            index ==
                            controller.grievanceDetail.value!.replies!.length -
                                1;
                        return Column(
                          children: [
                            if (index != 0)
                              TimelineDivider(
                                begin: 0.021,
                                end: 0.98,
                                thickness: 2,
                                color:
                                    AppColors.replyColors[int.parse(
                                      reply.step,
                                    )] ??
                                    AppColors.textSecondary,
                              ),
                            TimelineTile(
                              alignment: TimelineAlign.manual,
                              beforeLineStyle: LineStyle(
                                color:
                                    AppColors.replyColors[int.parse(
                                      reply.step,
                                    )] ??
                                    AppColors.textSecondary,
                                thickness: 2,
                              ),
                              lineXY: isLeft ? 0 : 1,
                              isFirst: index == 0,
                              isLast: isLast,
                              indicatorStyle: IndicatorStyle(
                                width: 15,
                                color:
                                    AppColors.replyColors[int.parse(
                                      reply.step,
                                    )] ??
                                    AppColors.textSecondary,
                              ),
                              startChild: isLeft
                                  ? null
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 40,
                                        horizontal: 10,
                                      ),
                                      child: Container(
                                        height: 80,
                                        margin: EdgeInsets.only(left: 8),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color:
                                                AppColors.replyColors[int.parse(
                                                  reply.step,
                                                )] ??
                                                AppColors.textSecondary,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
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
                                            Text(
                                              AppFormatter.formatStep(
                                                int.parse(reply.step),
                                              ),
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    color:
                                                        AppColors
                                                            .replyColors[int.parse(
                                                          reply.step,
                                                        )],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Text(
                                              '${reply.user!.name} | ${AppFormatter.formatDate(reply.createdAt)}',
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              endChild: isLeft
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 40,
                                        horizontal: 10,
                                      ),
                                      child: Container(
                                        height: 80,
                                        margin: EdgeInsets.only(
                                          right: 8,
                                          left: 8,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color:
                                                AppColors.replyColors[int.parse(
                                                  reply.step,
                                                )] ??
                                                AppColors.textSecondary,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.1,
                                              ),
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
                                            Text(
                                              AppFormatter.formatStep(
                                                int.parse(reply.step),
                                              ),
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    color:
                                                        AppColors
                                                            .replyColors[int.parse(
                                                          reply.step,
                                                        )],
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Text(
                                              '${reply.user!.name} | ${AppFormatter.formatDate(reply.createdAt)}',
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        );
                      }).toList()
                    : [Center(child: Text('No replies available'))],
              ),
            ),
    );
  }
}
