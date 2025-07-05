
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../verfiy_email.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
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
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Phone Number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Password
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          /// Terms and Conditions Checkbox
          Row(
            children: [
              SizedBox(height: 24,width: 24,child: Checkbox(value: true, onChanged: (value){}),),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(text: '${TTexts.iAgreeTo} ',style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '${TTexts.privacyPolicy} ',style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark? TColors.white : TColors.primary,
                        )),
                        TextSpan(text: '${TTexts.and} ',style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: '${TTexts.termsOfUse} ',style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark? TColors.white : TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: dark? TColors.white : TColors.primary,
                        )),
                      ]
                  )
              )

            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          /// signup button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to( () =>  const VerifyEmailScreen()),
              child: Text(TTexts.createAccount),
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwSections),
          /// divider
          FormDivider(dark: dark),
          const SizedBox(height: TSizes.spaceBtwSections,),

          /// footer
          SocialButtons()

        ],
      ),
    );
  }
}