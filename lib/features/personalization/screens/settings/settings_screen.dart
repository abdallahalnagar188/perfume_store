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

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../data/repo/auth/auth_repo.dart';
import '../../../../data/repo/category/category_repo.dart';
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
                      "Account",
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
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-progress and Completed Orders',
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.bank,
                  //   title: 'Back Account',
                  //   subTitle: 'Withdraw balance to register back account',
                  //   onTap: () {},
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.discount_shape,
                  //   title: 'My Coupons',
                  //   subTitle: 'List of all the discount coupons',
                  //   onTap: () {},
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.notification,
                  //   title: 'Notifications',
                  //   subTitle: 'Set any kind of Notifications message',
                  //   onTap: () {},
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.security_card,
                  //   title: 'Account Privacy ',
                  //   subTitle: 'Mange data usage and connected accounts',
                  //   onTap: () {},
                  // ),

                  /// App Settings
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(height: TSizes.spaceBtwItems),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.document_upload,
                  //   title: 'Load Data',
                  //   subTitle: 'Upload Data to your Firebase',
                  //   onTap: () {}
                  //   // async {
                  //   //   try {
                  //   //     await ProductRepo.instance.uploadProductCategory(
                  //   //       TDummyData.productsForCategory,
                  //   //     );
                  //   //     Get.snackbar(
                  //   //       'Success',
                  //   //       'Dummy data uploaded successfully',
                  //   //     );
                  //   //   } catch (e) {
                  //   //     print( e.toString());
                  //   //     Get.snackbar('Error', e.toString(),animationDuration:Duration(milliseconds: 5000) );
                  //   //   }
                  //   // },
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.location,
                  //   title: 'Location',
                  //   subTitle: 'Set recommended based in location',
                  //   trailing: Switch(value: true, onChanged: (value) {}),
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.security_user,
                  //   title: 'Safe Mode',
                  //   subTitle: 'Search result is safe for all ages',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ),
                  // TSettingsMenuTile(
                  //   icon: Iconsax.image,
                  //   title: 'HD Image Quality',
                  //   subTitle: 'Set Image quality to be seen',
                  //   trailing: Switch(value: false, onChanged: (value) {}),
                  // ),
                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => AuthenticationRepo.instance.logout(),
                      child: const Text('Logout'),
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
