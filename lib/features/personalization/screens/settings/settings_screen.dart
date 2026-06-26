import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/data/repo/brands/brand_repo.dart';
import 'package:ecommerce_store/features/personalization/screens/address/address_screen.dart';
import 'package:ecommerce_store/features/shop/screens/cart/cart_screen.dart';
import 'package:ecommerce_store/features/shop/screens/orders/order_screen.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../utils/exceptions/TFirebaseStorageService.dart';
import '../profile/profile_screen.dart';
import 'widgets/language_bottom_sheet.dart';

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
                    onTap: () => Get.bottomSheet(const LanguageBottomSheet()),
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
