import 'package:ecommerce_store/features/personalization/controllers/localization_controller.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LocalizationController());

    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle pill
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: TColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(
            'choose_language'.tr,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          
          _LanguageTile(
            flag: '🇺🇸',
            languageName: 'English',
            langCode: 'en',
            countryCode: 'US',
            controller: controller,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          _LanguageTile(
            flag: '🇸🇦',
            languageName: 'العربية',
            langCode: 'ar',
            countryCode: 'EG',
            controller: controller,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.flag,
    required this.languageName,
    required this.langCode,
    required this.countryCode,
    required this.controller,
  });

  final String flag;
  final String languageName;
  final String langCode;
  final String countryCode;
  final LocalizationController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.currentLanguage.value == langCode;
      
      return InkWell(
        onTap: () => controller.changeLanguage(langCode, countryCode),
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.md, vertical: TSizes.sm),
          decoration: BoxDecoration(
            color: isSelected ? TColors.primary.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
            border: Border.all(
              color: isSelected ? TColors.primary.withOpacity(0.5) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  languageName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? TColors.primary : null,
                  ),
                ),
              ),
              if (isSelected)
                const Icon(Iconsax.tick_circle5, color: TColors.primary),
            ],
          ),
        ),
      );
    });
  }
}
