import 'package:ecommerce_store/common/styles/spacing_styles.dart';
import 'package:ecommerce_store/features/auth/screens/login/widgets/login_form.dart';
import 'package:ecommerce_store/features/auth/screens/login/widgets/login_header.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppbarHeight,
          child: Column(
            children: [
              /// logo and title and subTitle
              LoginHeader(dark: dark),

              /// email , password , remember and forget password , signIn button , create account
              LoginForm(),

              /// divider
              FormDivider(dark: dark),
              const SizedBox(height: TSizes.spaceBtwSections,),

              /// footer
              SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
