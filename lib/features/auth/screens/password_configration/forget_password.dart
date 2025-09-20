import 'package:ecommerce_store/features/auth/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce_store/features/auth/screens/password_configration/reset_password.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:ecommerce_store/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headline
            Text(
              'forgetPasswordTitle'.tr,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'forgetPasswordSubTitle'.tr,
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: TSizes.spaceBtwSections *2),
            /// Text Field

            /// Email
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail,
                expands: false,
                decoration:  InputDecoration(
                  labelText: 'email'.tr,
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.sendResetPasswordEmail(),
                child:  Text('submit'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
