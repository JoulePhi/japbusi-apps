import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:japbusi/app/data/services/auth_service.dart';
import 'package:japbusi/app/routes/app_pages.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';
import 'package:japbusi/app/utils/handle_payload.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
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
          'Notifikasi',
          style: AppTextStyles.headline3.copyWith(color: Colors.white),
        ),
      ),
      body: Obx(() {
        if (Get.find<AuthService>().isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (Get.find<AuthService>().notifications.isEmpty) {
          return Center(child: Text('Tidak ada notifikasi'));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchNotifications();
            },
            child: ListView.builder(
              itemCount: Get.find<AuthService>().notifications.length,
              itemBuilder: (context, index) {
                final notification =
                    Get.find<AuthService>().notifications[index];
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        style: AppTextStyles.body1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    AppFormatter.formatDateTime(notification.createdAt),
                    textAlign: TextAlign.end,
                    style: AppTextStyles.caption,
                  ),
                  onTap: () {
                    controller.markAsRead(
                      int.parse(notification.id.toString()),
                    );
                    handlePayload(jsonEncode(notification.toJson()));
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
