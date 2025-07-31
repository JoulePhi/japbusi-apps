import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/modules/home/controllers/grievances_controller.dart';
import 'package:japbusi/app/modules/home/controllers/home_controller.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class GrievancesTab extends GetView<GrievancesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.successColor,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Pengaduan Saya',
          style: AppTextStyles.headline3.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidBell,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: AppColors.orangeColor,
                    ),
                    // add vertical divider
                    VerticalDivider(
                      color: AppColors.orangeColor,
                      thickness: 1,
                      width: 40,
                    ),
                    Expanded(
                      child: TextField(
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textPrimary,
                        ),

                        decoration: InputDecoration(
                          hintText: 'Cari pengaduan...',
                          hintStyle: AppTextStyles.caption.copyWith(
                            color: AppColors.successColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 1,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: AppColors.orangeColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // add horizontal divider
              SizedBox(height: 10.0),
              Divider(color: AppColors.orangeColor, thickness: 1),
              SizedBox(height: 16.0),
              GetBuilder<GrievancesController>(
                init: GrievancesController(),
                initState: (_) {
                  // Fetch grievances when the controller is initialized
                  controller.fetchGrievances();
                },
                builder: (c) {
                  // Ensure grievances are fetched
                  if (c.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }
                  if (c.grievances.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada pengaduan yang ditemukan',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () {
                        c.fetchGrievances();
                        return Future.value();
                      },
                      child: ListView.builder(
                        itemCount: c.grievances.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border(
                                top: BorderSide(
                                  color:
                                      AppColors.statusColors[c
                                          .grievances[index]
                                          .status] ??
                                      AppColors.textSecondary,
                                  width: 4,
                                ),
                                right: BorderSide(
                                  color:
                                      AppColors.statusColors[c
                                          .grievances[index]
                                          .status] ??
                                      AppColors.textSecondary,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color:
                                      AppColors.statusColors[c
                                          .grievances[index]
                                          .status] ??
                                      AppColors.textSecondary,
                                  width: 1,
                                ),
                                left: BorderSide(
                                  color:
                                      AppColors.statusColors[c
                                          .grievances[index]
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
                                  c.grievances[index].nomor.toString(),
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
                                          c.grievances[index].createdAt,
                                        ),
                                        style: AppTextStyles.caption.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      // add vertical divider
                                      VerticalDivider(
                                        color: AppColors.textSecondary,
                                        thickness: 1,
                                        width: 20,
                                      ),
                                      Text(
                                        AppFormatter.formatStatus(
                                          c.grievances[index].status,
                                        ),
                                        style: AppTextStyles.caption.copyWith(
                                          color:
                                              AppColors.statusColors[c
                                                  .grievances[index]
                                                  .status] ??
                                              AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Divider(
                                  color: AppColors.textSecondary,
                                  thickness: .5,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  'Kronologi :',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textPurple,
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
                                    data: c.grievances[index].detail,
                                    style: {
                                      "body": Style(
                                        color: AppColors.textPrimary,
                                        fontSize: FontSize(14),
                                      ),
                                    },
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Divider(
                                  color: AppColors.textSecondary,
                                  thickness: .5,
                                ),
                                SizedBox(height: 8.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(
                                        Routes.DETAIL,
                                        arguments: {
                                          'nomor': c.grievances[index].nomor,
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                    child: Text(
                                      'Lihat Detail',
                                      style: AppTextStyles.button,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
