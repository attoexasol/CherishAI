// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(const CherishApp());
}

class CherishApp extends StatelessWidget {
  const CherishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cherish AI',
      theme: AppTheme.light,
      initialRoute: AppRoutes.onboardingIntro,
      getPages: AppRoutes.pages,
    );
  }
}
