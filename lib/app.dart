import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class PerfumeStore extends StatelessWidget {
  const PerfumeStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
    );
  }
}