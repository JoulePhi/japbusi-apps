import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japbusi/app/data/models/grievance_model.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/modules/home/controllers/home_controller.dart';
import 'package:japbusi/app/modules/home/views/widgets/anggota_widget.dart';
import 'package:japbusi/app/modules/home/views/widgets/category_chart.dart';
import 'package:japbusi/app/modules/home/views/widgets/dashboard_card.dart';
import 'package:japbusi/app/modules/home/views/widgets/grievance_tren_chart.dart';
import 'package:japbusi/app/modules/home/views/widgets/visitor_chart.dart';
import 'package:japbusi/app/modules/splash/controllers/splash_controller.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_snackbar.dart';
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
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.NOTIFICATIONS);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.solidBell,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            // Badge
                            Obx(
                              () => Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    Get.find<AuthService>().notifications.length
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Obx(
                      () => controller.dashboard.value == null
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                if (Get.find<AuthService>().user!.isMax)
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Expanded(
                                        child: DashboardCard(
                                          title: 'TOTAL ADUAN',
                                          mainValue: controller
                                              .dashboard
                                              .value!
                                              .totalGrievances
                                              .toString(),
                                          subtitle: 'MENUNGGU VERIFIKASI',
                                          subValue: controller
                                              .dashboard
                                              .value!
                                              .totalGrievancesWaiting
                                              .toString(),
                                          backgroundColor: const Color(
                                            0xFFE8E5FF,
                                          ),
                                          icon: Icons.report_problem_outlined,
                                        ),
                                      ),
                                      Expanded(
                                        child: DashboardCard(
                                          title: 'TOTAL PENGGUNA',
                                          mainValue: controller
                                              .dashboard
                                              .value!
                                              .totalPelapor
                                              .toString(),
                                          subtitle: '',
                                          subValue: '',
                                          backgroundColor: const Color(
                                            0xFFD4F4DD,
                                          ),
                                          icon: Icons.article_outlined,
                                        ),
                                      ),
                                    ],
                                  ),

                                if (!Get.find<AuthService>().user!.isMax)
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Expanded(
                                        child: DashboardCard(
                                          title: 'TOTAL ADUAN',
                                          mainValue: controller
                                              .dashboard
                                              .value!
                                              .totalGrievances
                                              .toString(),
                                          subtitle: 'MENUNGGU VERIFIKASI',
                                          subValue: controller
                                              .dashboard
                                              .value!
                                              .totalGrievancesWaiting
                                              .toString(),
                                          backgroundColor: const Color(
                                            0xFFE8E5FF,
                                          ),
                                          icon: Icons.report_problem_outlined,
                                        ),
                                      ),
                                      Expanded(
                                        child: DashboardCard(
                                          title: 'TOTAL PENGGUNA',
                                          mainValue: controller
                                              .dashboard
                                              .value!
                                              .totalPelapor
                                              .toString(),
                                          subtitle: '',
                                          subValue: '',
                                          backgroundColor: const Color(
                                            0xFFD4F4DD,
                                          ),
                                          icon: Icons.article_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 20),
                                Text(
                                  'Aduan Terbaru',
                                  style: AppTextStyles.headline2.copyWith(
                                    fontSize: 22,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  children: controller
                                      .dashboard
                                      .value!
                                      .recentGrievances
                                      .map(
                                        (grievance) => Card(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: ListTile(
                                            leading: FaIcon(
                                              FontAwesomeIcons.commentDots,
                                              color: AppColors.primaryColor,
                                            ),
                                            title: Text(
                                              grievance.detail.length > 50
                                                  ? '${grievance.detail.substring(0, 50)}...'
                                                  : grievance.detail,
                                              style: AppTextStyles.caption
                                                  .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            subtitle: Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              grievance.nomor.toString(),
                                              style: AppTextStyles.caption,
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                            ),
                                            onTap: () {
                                              Get.toNamed(
                                                Routes.DETAIL,
                                                arguments: {
                                                  'nomor': grievance.nomor,
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),

                                AnggotaWidget(
                                  totalMember: controller
                                      .dashboard
                                      .value!
                                      .totalPopulation,
                                  maleMember:
                                      controller.dashboard.value!.totalMale,
                                  femaleMember:
                                      controller.dashboard.value!.totalFemale,
                                ),
                                SizedBox(height: 20),
                                if (Get.find<AuthService>().user!.isMax &&
                                    Get.find<AuthService>().user!.roleName ==
                                        'Federasi')
                                  ProfileVisitorChart(
                                    chartData: controller
                                        .dashboard
                                        .value!
                                        .visitorStats
                                        .map(
                                          (e) => FlSpot(
                                            controller
                                                .dashboard
                                                .value!
                                                .visitorStats
                                                .indexOf(e)
                                                .toDouble(),
                                            double.tryParse(e.visitCount) ?? 0,
                                          ),
                                        )
                                        .toList(),
                                    dateLabels: controller
                                        .dashboard
                                        .value!
                                        .visitorStats
                                        .map(
                                          (e) => AppFormatter.formatDate(
                                            e.visitDate,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                if (Get.find<AuthService>().user!.isMax)
                                  SizedBox(height: 20),
                                if (Get.find<AuthService>().user!.isMax)
                                  GrievanceTrenChart(
                                    chartData:
                                        controller
                                            .dashboard
                                            .value!
                                            .grievancesEachDay
                                            .isEmpty
                                        ? []
                                        : controller
                                              .dashboard
                                              .value!
                                              .grievancesEachDay
                                              .map(
                                                (e) => FlSpot(
                                                  controller
                                                      .dashboard
                                                      .value!
                                                      .grievancesEachDay
                                                      .indexOf(e)
                                                      .toDouble(),
                                                  double.tryParse(
                                                        e.grievanceCount,
                                                      ) ??
                                                      0,
                                                ),
                                              )
                                              .toList(),
                                    dateLabels: controller
                                        .dashboard
                                        .value!
                                        .grievancesEachDay
                                        .map(
                                          (e) => AppFormatter.formatDate(
                                            e.grievanceDate,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                if (Get.find<AuthService>().user!.isMax)
                                  SizedBox(height: 20),
                                if (Get.find<AuthService>().user!.isMax)
                                  CategoryPieChart(
                                    chartData: [
                                      ChartCategory(
                                        name: "Perselisihan Hak",
                                        province: '',
                                        value: controller
                                            .dashboard
                                            .value!
                                            .grievancesByCategory
                                            .perselisihanHak,
                                        color: Colors.blue,
                                      ),
                                      ChartCategory(
                                        name: "Perselisihan Kepentingan",
                                        province: '',
                                        value: controller
                                            .dashboard
                                            .value!
                                            .grievancesByCategory
                                            .perselisihanKepentingan,
                                        color: Colors.green,
                                      ),
                                      ChartCategory(
                                        name:
                                            "Perselisihan Antar Serikat Buruh",
                                        province: '',
                                        value: controller
                                            .dashboard
                                            .value!
                                            .grievancesByCategory
                                            .perselisihanAntarSerikatBuruhDalamSatuPerusahaan,
                                        color: Colors.red,
                                      ),
                                      ChartCategory(
                                        name:
                                            "Perselisihan Pemutusan Hubungan Kerja",
                                        province: '',
                                        value: controller
                                            .dashboard
                                            .value!
                                            .grievancesByCategory
                                            .perselisihanPemutusanHubunganKerja,
                                        color: Colors.orange,
                                      ),
                                      ChartCategory(
                                        name: "Jam Kerja",
                                        province: '',
                                        value: controller
                                            .dashboard
                                            .value!
                                            .grievancesByCategory
                                            .jamKerja,
                                        color: Colors.purple,
                                      ),
                                      ChartCategory(
                                        name: "Upah",
                                        province: '',
                                        value: controller
                                            .dashboard
                                            .value!
                                            .grievancesByCategory
                                            .upah,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(meta: meta, child: text);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
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
