import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_store/data/repo/auth/auth_repo.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/models/notification_model.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();
  
  // State
  final RxInt unreadCount = 0.obs;
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  StreamSubscription<QuerySnapshot>? _notificationSubscription;

  @override
  void onInit() {
    super.onInit();
    _listenToNotifications();
  }

  @override
  void onClose() {
    _notificationSubscription?.cancel();
    super.onClose();
  }

  void _listenToNotifications() {
    final userId = AuthenticationRepo.instance.authUser?.uid;
    if (userId == null || userId.isEmpty) return;

    _notificationSubscription = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((snapshot) {
      notifications.assignAll(
          snapshot.docs.map((doc) => NotificationModel.fromSnapshot(doc)).toList());
      
      // Update unread count
      unreadCount.value = notifications.where((n) => !n.isRead).length;
    }, onError: (error) {
      print('Notification Stream Error: $error');
    });
  }

  /// Mark a single notification as read
  Future<void> markAsRead(String notificationId) async {
    final userId = AuthenticationRepo.instance.authUser?.uid;
    if (userId == null || userId.isEmpty) return;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Notifications')
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  /// Mark all as read
  Future<void> markAllAsRead() async {
    final userId = AuthenticationRepo.instance.authUser?.uid;
    if (userId == null || userId.isEmpty) return;

    final batch = FirebaseFirestore.instance.batch();
    final unreadDocs = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Notifications')
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in unreadDocs.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    
    await batch.commit();
  }
}
