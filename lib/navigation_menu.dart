import 'package:ecommerce_store/features/personalization/screens/settings/settings_screen.dart';
import 'package:ecommerce_store/features/shop/screens/store/store_screen.dart';
import 'package:ecommerce_store/features/shop/screens/wishlist/wishlist_screen.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ecommerce_store/features/personalization/controllers/notification_controller.dart';
import 'package:ecommerce_store/features/personalization/screens/notifications/notification_screen.dart';

import 'features/shop/screens/home/home_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final notifController = Get.put(NotificationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? Colors.black:Colors.white,
          indicatorColor: darkMode ? Colors.white.withOpacity(0.12):Colors.black.withOpacity(0.12),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'.tr),
            NavigationDestination(
              icon: Obx(() => badges.Badge(
                showBadge: notifController.unreadCount.value > 0,
                badgeContent: Text(
                  notifController.unreadCount.value.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: const Icon(Iconsax.notification),
              )),
              label: 'Notifi'.tr,
            ),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Shop'.tr),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'.tr),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'.tr),

          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const StoreScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),

  ];
}
