import 'package:ecommerce_store/bindings/general_bindings.dart';
import 'package:ecommerce_store/routes/app_routes.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load saved locale before starting app
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('langCode') ?? 'en';
  final countryCode = prefs.getString('countryCode') ?? 'US';
  final savedLocale = Locale(langCode, countryCode);

  runApp(PerfumeStore(savedLocale: savedLocale));
}

class PerfumeStore extends StatelessWidget {
  final Locale savedLocale;

  const PerfumeStore({super.key, required this.savedLocale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      locale: savedLocale,
      fallbackLocale: const Locale('en', 'US'),
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: TColors.white),
        ),
      ),
    );
  }
}
