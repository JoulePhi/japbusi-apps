import 'package:get/get.dart';
import 'package:japbusi/app/data/models/notification.dart';
import 'package:japbusi/app/data/services/auth_service.dart';

class NotificationsController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;
  final RxList<Notification> notifications = RxList<Notification>([]);

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    try {
      isLoading.value = true;
      await _authService.getNotifications();
    } catch (e) {
      print('Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void markAsRead(int notificationId) async {
    try {
      await _authService.readNotifications(notificationId);
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }
}
