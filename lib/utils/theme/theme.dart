import 'package:ecommerce_store/utils/theme/custom_thems/appbar_theme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/bottom_sheet_theme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/checkbox_theme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/chip_theme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/elevated_button_theme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/outlined_button_theme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/text_field_teme.dart';
import 'package:ecommerce_store/utils/theme/custom_thems/text_theme.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'NotoKufiArabic',
    brightness: Brightness.light,
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MyAppTextTheme.lightTextTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlinedButtonTheme,
    appBarTheme: MyAppbarTheme.lightAppBarTheme,
    bottomSheetTheme: MyBottomSheetTheme.lightBottomSheetTheme,
    chipTheme: MyChipTheme.lightChipTheme,
    inputDecorationTheme: MyTextFieldTheme.lightInputDecorationTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'NotoKufiArabic',
    brightness: Brightness.dark,
    primaryColor: TColors.primary,
    scaffoldBackgroundColor: Colors.black,
    textTheme: MyAppTextTheme.darkTextTheme,
    elevatedButtonTheme: MyElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlinedButtonTheme,
    appBarTheme: MyAppbarTheme.darkAppBarTheme,
    bottomSheetTheme: MyBottomSheetTheme.darkBottomSheetTheme,
    chipTheme: MyChipTheme.darkChipTheme,
    inputDecorationTheme: MyTextFieldTheme.darkInputDecorationTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
  );
}
