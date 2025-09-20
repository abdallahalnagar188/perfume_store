import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'data/repo/auth/auth_repo.dart';
import 'firebase_options.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  /// GetX Storage
  await GetStorage.init();

  /// Preserve native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// Firebase init + register repo
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepo()));

  /// Load saved language
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('langCode') ?? 'en';
  final countryCode = prefs.getString('countryCode') ?? 'US';
  final savedLocale = Locale(langCode, countryCode);

  runApp(PerfumeStore(savedLocale: savedLocale));
}
