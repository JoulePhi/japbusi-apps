import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/modules/home/controllers/article_controller.dart';
import 'package:japbusi/app/modules/home/controllers/home_controller.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class ArticleTab extends GetView<ArticleController> {
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
          'Artikel',
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
                          hintText: 'Cari artikel...',
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
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/artikel1.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gapki-Japbusi Sepakati Kolaborasi Bipartit Atasi Pelanggaran Hak Pekerja',
                                  style: AppTextStyles.headline2.copyWith(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.calendar,
                                      size: 12,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      '12 Desember 2023',
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
