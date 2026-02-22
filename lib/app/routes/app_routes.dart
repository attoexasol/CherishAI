// lib/app/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/splash/views/splash_screen.dart';
import '../../presentation/onboarding/views/onboarding_intro_screen.dart';
import '../../presentation/auth/views/auth_screen.dart';
import '../../presentation/onboarding/views/user_type_screen.dart';
import '../bindings/initial_binding.dart';
import '../bindings/auth_binding.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String onboardingIntro = '/onboarding-intro';
  static const String userType = '/user-type';
  static const String individualUserInfo = '/individual/user-info';
  static const String businessSplash = '/business/splash';

  static List<GetPage> get pages => [
        GetPage(
          name: splash,
          page: () => const SplashScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: onboardingIntro,
          page: () => const OnboardingIntroScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: auth,
          page: () => const AuthScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: userType,
          page: () => const UserTypeScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualUserInfo,
          page: () => const _PlaceholderScreen(title: 'User Info'),
          binding: InitialBinding(),
        ),
        GetPage(
          name: businessSplash,
          page: () => const _PlaceholderScreen(title: 'Business'),
          binding: InitialBinding(),
        ),
      ];
}

/// Placeholder until individual/business flows are implemented.
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
