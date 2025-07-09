import 'package:ecommerce_store/utils/theme/theme.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {

/// Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(const PerfumeStore());
}



