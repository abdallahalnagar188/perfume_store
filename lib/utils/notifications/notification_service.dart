import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_store/features/personalization/controllers/notification_controller.dart';
import 'package:ecommerce_store/navigation_menu.dart';

/// Top level function to handle background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // 1. Request permissions for iOS and Android 13+
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    // 2. Initialize Local Notifications
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@drawable/logo');
    const DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationTap();
      },
    );

    // 3. Setup Android Heads-up Notifications channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    // 4. Set Foreground Notification Presentation options for iOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    // 5. Handle Background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 6. Handle Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Received foreground message: ${message.notification?.title}");
      _showLocalNotification(message, channel);

      // Note: The UI and unread badges are now automatically updated
      // via the real-time Firestore stream in NotificationController.
    });

    // 7. Handle when app is opened from a terminated state via a push notification
    FirebaseMessaging.instance.getInitialMessage().then((
      RemoteMessage? message,
    ) {
      if (message != null) {
        _handleNotificationTap();
      }
    });

    // 8. Handle when app is opened from background state via a push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap();
    });

    // 9. Fetch and Save FCM Token to Firestore
    try {
      final token = await _fcm.getToken();
      if (token != null) {
        _saveTokenToFirestore(token);
      }
      // Listen to token refreshes
      _fcm.onTokenRefresh.listen(_saveTokenToFirestore);
    } catch (e) {
      log('Failed to fetch FCM token: $e');
    }
  }

  void _saveTokenToFirestore(String fcmToken) async {
    try {
      final authUser = FirebaseAuth.instance.currentUser;
      if (authUser != null && authUser.uid.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(authUser.uid)
            .update({'fcmToken': fcmToken});
        log('FCM Token successfully saved to Firestore: $fcmToken');
      }
    } catch (e) {
      log('Error saving FCM Token to Firestore: $e');
    }
  }

  void _showLocalNotification(
    RemoteMessage message,
    AndroidNotificationChannel channel,
  ) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotificationsPlugin.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@drawable/logo',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }

  void _handleNotificationTap() {
    // Navigate to the Notification Screen
    if (Get.isRegistered<NavigationController>()) {
      final nav = Get.find<NavigationController>();
      // Assuming Notification Screen is at index 4
      nav.selectedIndex.value = 4;
    }
  }
}
