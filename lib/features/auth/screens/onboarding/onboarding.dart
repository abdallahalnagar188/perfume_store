import 'package:ecommerce_store/features/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:ecommerce_store/features/auth/screens/onboarding/widgets/onbaording_skip.dart';
import 'package:ecommerce_store/features/auth/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:ecommerce_store/features/auth/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:ecommerce_store/features/auth/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecommerce_store/utils/constants/image_strings.dart';
import 'package:ecommerce_store/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: 'onBoardingTitle1'.tr,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: 'onBoardingTitle2'.tr,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: 'onBoardingTitle3'.tr,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          OnBoardingSkip(),

          OnBoardingDotNavigation(),

          OnBoardingNextButton(),
        ],
      ),
    );
  }
}

