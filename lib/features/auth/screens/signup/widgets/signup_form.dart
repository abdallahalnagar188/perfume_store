import 'package:ecommerce_store/features/auth/controllers/signup/signup_controller.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../verfiy_email.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('First Name', value),
                  decoration:  InputDecoration(
                    labelText: 'firstName'.tr,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Last Name', value),

                  expands: false,
                  decoration:  InputDecoration(
                    labelText:"lastName".tr,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// User name
          TextFormField(
            expands: false,
            controller: controller.username,
            validator: (value) =>
                TValidator.validateEmptyText('UserName', value),
            decoration:  InputDecoration(
              labelText: 'username'.tr,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),

            expands: false,
            decoration:  InputDecoration(
              labelText: 'email'.tr,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => TValidator.validatePhoneNumber(value),

            expands: false,
            decoration:  InputDecoration(
              labelText: 'phoneNo'.tr,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              expands: false,
              decoration: InputDecoration(
                labelText: 'password'.tr,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Terms and Conditions Checkbox
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Obx(
                  () => Checkbox(
                    value: controller.privacyPolicy.value,
                    onChanged: (value) => controller.privacyPolicy.value =
                        !controller.privacyPolicy.value,
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${'iAgreeTo'.tr} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '${'privacyPolicy'.tr} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                    TextSpan(
                      text: '${'and'.tr} ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextSpan(
                      text: '${'termsOfUse'.tr} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                        overflow: TextOverflow.ellipsis,
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: dark ? TColors.white : TColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// signup button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: Text('createAccount'.tr,style: Theme.of(context).textTheme.titleMedium,),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// divider
          FormDivider(dark: dark),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// footer
          SocialButtons(),
        ],
      ),
    );
  }
}
