
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(
            dark ? TImages.lightAppLogo : TImages.darkAppLogo,
          ),
        ),
        Text(
          'loginTitle'.tr,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          'loginSubTitle'.tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}