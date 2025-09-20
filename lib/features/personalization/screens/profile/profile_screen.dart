import 'package:ecommerce_store/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_store/common/widgets/image/t_circular_image.dart';
import 'package:ecommerce_store/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_store/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce_store/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:ecommerce_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_store/features/personalization/screens/profile/widgets/re_auth_user_login_form.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: TAppbar(showBackArrow: true, title: Text('account'.tr,style: Theme.of(context).textTheme.headlineMedium)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Image
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image = networkImage.isNotEmpty
                          ? networkImage
                          : TImages.user;

                      return controller.imageUploading.value
                          ? const TShimmerEffect(
                              width: 80,
                              height: 80,
                              radius: 80,
                            )
                          : TCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: networkImage.isNotEmpty,
                            );
                    }),

                    TextButton(
                      onPressed: () => controller.uploadUserProfileImage(),
                      child: Text('changeImage'.tr,style: TextStyle(color: TColors.primary),),
                    ),
                  ],
                ),
              ),

              /// Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Profile info
              TSectionHeading(
                title: 'profileInfo'.tr,
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                onPressed: () => Get.to(ChangeName()),
                title: 'name'.tr,
                value: controller.user.value.fullName,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'username'.tr,
                value: controller.user.value.username,
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal info
              TSectionHeading(
                title: 'personalInfo'.tr,
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                onPressed: () {},
                title: 'userId'.tr,
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'email'.tr,
                value: controller.user.value.email,
              ),
              TProfileMenu(
                onPressed: () {},
                title: 'phoneNo'.tr,
                value: controller.user.value.phoneNumber,
              ),
              // TProfileMenu(onPressed: () {}, title: 'Gender', value: 'Mail'),
              // TProfileMenu(
              //   onPressed: () {},
              //   title: 'Date of Birth',
              //   value: '18 Ogs, 2002',
              // ),
              const SizedBox(height: TSizes.spaceBtwItems),

              Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: Text(
                    'closeAccount'.tr,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
