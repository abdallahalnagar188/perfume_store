
import 'package:ecommerce_store/features/auth/controllers/login/login_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginControllers()) ;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// google
        Container(
          decoration: BoxDecoration(
              border: Border.all(color:TColors.grey),
              borderRadius: BorderRadius.circular(100)
          ),
          child: IconButton(onPressed: () => controller.googleSignIn(), icon: const Image(
              height: TSizes.iconMd,
              width:TSizes.iconMd ,
              image: AssetImage(TImages.google))),
        ),

        const SizedBox(width: TSizes.spaceBtwItems,),

        /// facebook
        Container(
          decoration: BoxDecoration(
              border: Border.all(color:TColors.grey),
              borderRadius: BorderRadius.circular(100)
          ),

          child: IconButton(onPressed: (){}, icon: const Image(
              height: TSizes.iconMd,
              width:TSizes.iconMd ,
              image: AssetImage(TImages.facebook))),
        ),
      ],
    );
  }
}