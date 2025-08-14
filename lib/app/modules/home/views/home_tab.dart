import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/modules/home/controllers/home_controller.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

class HomeTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/access1.png')),
          Container(
            width: Get.width,
            height: Get.height * .25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.successColor,
                  AppColors.successAccentColor,
                ],
                stops: [0.2, 0.9, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Image(
              image: AssetImage('assets/logo_tp.png'),
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getGreeting(),
                              style: AppTextStyles.white.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              Get.find<AuthService>().user!.name,
                              style: AppTextStyles.white.copyWith(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.solidBell,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/banner.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bersama JAPBUSI Untuk Kerja Layak dan Bermartabat',
                              style: AppTextStyles.white.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Laporkan masalah Andan dengan aman, depat dan terpercaya',
                              style: AppTextStyles.white.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    if (Get.find<AuthService>().user!.roleName == 'Pelapor')
                      Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.textSecondary.withOpacity(0.3),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kronologi Kejadian',
                              style: AppTextStyles.headline2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Cerita kamu sangat penting agar kami dapat membantu menyelesaikan pengaduanmu',
                              style: AppTextStyles.caption.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 10),
                            // text area for input
                            TextField(
                              maxLines: 4,
                              controller: controller.descriptionController,
                              decoration: InputDecoration(
                                hintText: 'Deskripsi',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.textSecondary.withOpacity(
                                      0.3,
                                    ),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColors.textSecondary,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Dokumen Pendukung",
                                  style: AppTextStyles.headline3.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(2),
                                    backgroundColor: AppColors.successColor,
                                  ),
                                  onPressed: () {
                                    controller.pickMultipleImages();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Obx(
                              () => controller.selectedImages.isNotEmpty
                                  ? Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: controller.selectedImages.map((
                                        image,
                                      ) {
                                        return Stack(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: FileImage(image),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 4,
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.selectedImages
                                                      .remove(image);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.errorColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  padding: EdgeInsets.all(4),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    )
                                  : SizedBox.shrink(),
                            ),
                            SizedBox(height: 15),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final result = await controller
                                          .submitGrievance();
                                      if (result > 0) {
                                        Get.toNamed(
                                          Routes.DETAIL,
                                          arguments: {'nomor': result},
                                        );
                                        Get.snackbar(
                                          "Sukses",
                                          "Pengaduan berhasil dikirim",
                                        );
                                      } else {
                                        Get.snackbar(
                                          "Gagal",
                                          "Pengaduan gagal dikirim",
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 20,
                                      ),
                                    ),
                                    child: controller.isSubmitting.value
                                        ? CircularProgressIndicator()
                                        : Text(
                                            'Kirim Pengaduan',
                                            style: AppTextStyles.button
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Artikel',
                          style: AppTextStyles.headline2.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/grievances', id: 1);
                          },
                          child: Text(
                            'Lihat Semua',
                            style: AppTextStyles.primary.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // make 16/9 carousel slider
                    Obx(
                      () => controller.isArticleLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : SizedBox(
                              height: 200,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                ),
                                items: controller.articles.map((article) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.ARTICLE,
                                        arguments: {'id': article.id},
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                            article.thumbnail,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primaryColor
                                                  .withOpacity(0.8),
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article.title,
                                              style: AppTextStyles.white
                                                  .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.calendar,
                                                  size: 12,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  AppFormatter.formatDate(
                                                    article.createdAt,
                                                  ),
                                                  style: AppTextStyles.white
                                                      .copyWith(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.successColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.textSecondary.withOpacity(0.3),
                          width: 1,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            child: Image.asset(
                              'assets/present.png',
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ayo Ajak Temanmu',
                                  style: AppTextStyles.headline2.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Untuk download aplikasi JAPBUSI',
                                  style: AppTextStyles.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle contact action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.orangeColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 20,
                                    ),
                                  ),
                                  child: Text(
                                    'Share',
                                    style: AppTextStyles.button.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 18) {
      return 'Selamat Siang';
    } else {
      return 'Selamat Malam';
    }
  }
}
