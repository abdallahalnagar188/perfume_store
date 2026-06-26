import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  static LocalizationController get instance => Get.find();

  RxString currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    currentLanguage.value = prefs.getString('langCode') ?? 'en';
  }

  Future<void> changeLanguage(String langCode, String countryCode) async {
    currentLanguage.value = langCode;
    var locale = Locale(langCode, countryCode);
    Get.updateLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', langCode);
    await prefs.setString('countryCode', countryCode);
    Get.back(); // close bottom sheet
  }
}
