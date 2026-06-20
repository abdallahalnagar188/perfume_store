import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_store/features/personalization/controllers/notification_controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'.tr),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.trash),
            onPressed: () {
              controller.markAllAsRead();
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.notification_bing, size: 100, color: Colors.grey),
                const SizedBox(height: 16),
                Text('No new notifications', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            final isRead = notification.isRead;
            
            return InkWell(
              onTap: () {
                if (!isRead) {
                  controller.markAsRead(notification.id);
                }
                // Optional: Route to order details if notification.orderId != null
              },
              child: Container(
                color: isRead ? Colors.transparent : Theme.of(context).primaryColor.withOpacity(0.1),
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Iconsax.notification),
                  ),
                  title: Text(
                    notification.title, 
                    style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold),
                  ),
                  subtitle: Text(
                    notification.body,
                    style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.w600),
                  ),
                  trailing: Text(
                    DateFormat('hh:mm a').format(notification.createdAt),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
