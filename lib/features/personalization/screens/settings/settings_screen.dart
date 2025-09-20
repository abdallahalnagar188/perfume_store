import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/image/t_circular_image.dart';
import 'package:ecommerce_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/data/dummy_data/t_dummy_data.dart';
import 'package:ecommerce_store/data/repo/banner/banner_repo.dart';
import 'package:ecommerce_store/data/repo/brands/brand_repo.dart';
import 'package:ecommerce_store/data/repo/products/products_repo.dart';
import 'package:ecommerce_store/features/personalization/screens/address/address_screen.dart';
import 'package:ecommerce_store/features/shop/screens/cart/cart_screen.dart';
import 'package:ecommerce_store/features/shop/screens/orders/order_screen.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../utils/exceptions/TFirebaseStorageService.dart';
import '../profile/profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BrandRepo());
    Get.put(TFirebaseStorageService());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  TAppbar(
                    title: Text(
                      "account".tr,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium!.apply(color: TColors.white),
                    ),
                  ),

                  /// User Profile Card
                  TUserProfileTitle(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Account Settings
                  TSectionHeading(
                    title: 'accountSetting'.tr,
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'myAddress'.tr,
                    subTitle: 'addressTitle'.tr,
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'myCart'.tr,
                    subTitle: 'cartTitle'.tr,
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'myOrders'.tr,
                    subTitle: 'orderTitle'.tr,
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  /// App Settings
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'appSettings'.tr,
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.language_circle,
                    title: 'language'.tr, // localized
                    subTitle: 'choose_language'.tr, // localized
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              Center(
                                child: Text(
                                  'choose_language'.tr,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                leading: const Icon(Icons.language),
                                title: Text('english'.tr),
                                onTap: () async {
                                  var locale = const Locale('en', 'US');
                                  Get.updateLocale(locale);
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setString('langCode', 'en');
                                  await prefs.setString('countryCode', 'US');
                                  Get.back(); // close bottom sheet
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.language),
                                title: Text('arabic'.tr),
                                onTap: () async {
                                  var locale = const Locale('ar', 'EG');
                                  Get.updateLocale(locale);
                                  final prefs = await SharedPreferences.getInstance();
                                  await prefs.setString('langCode', 'ar');
                                  await prefs.setString('countryCode', 'EG');
                                  Get.back(); // close bottom sheet
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => AuthenticationRepo.instance.logout(),
                      child:  Text('logout'.tr,style: Theme.of(context).textTheme.titleLarge),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
