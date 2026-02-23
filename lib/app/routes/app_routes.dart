// lib/app/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/splash/views/splash_screen.dart';
import '../../presentation/onboarding/views/onboarding_intro_screen.dart';
import '../../presentation/auth/views/auth_screen.dart';
import '../../presentation/onboarding/views/user_type_screen.dart';
import '../../presentation/onboarding/views/individual_step1_profile_screen.dart';
import '../../presentation/onboarding/views/individual_step2_add_loved_one_screen.dart';
import '../../presentation/onboarding/views/individual_step3_relationship_goals_screen.dart';
import '../../presentation/onboarding/views/individual_step4_secondary_goals_screen.dart';
import '../../presentation/loved_one_preferences/views/loved_one_preferences_screen.dart';
import '../../presentation/dislikes/views/dislikes_screen.dart';
import '../../presentation/personal_note/views/personal_note_screen.dart';
import '../../presentation/subscription/views/choose_plan_screen.dart';
import '../../presentation/checkout/views/checkout_screen.dart';
import '../bindings/initial_binding.dart';
import '../bindings/auth_binding.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String onboardingIntro = '/onboarding-intro';
  static const String userType = '/user-type';
  static const String individualUserInfo = '/individual/user-info';
  static const String individualAddLovedOne = '/individual/add-loved-one';
  static const String individualRelationshipGoals = '/individual/relationship-goals';
  static const String individualSecondaryGoals = '/individual/secondary-goals';
  static const String lovedOnePreferences = '/loved-one-preferences';
  static const String dislikes = '/dislikes';
  static const String personalNote = '/personal-note';
  static const String choosePlan = '/choose-plan';
  static const String checkout = '/checkout';
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
          page: () => const IndividualStep1ProfileScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualAddLovedOne,
          page: () => const IndividualStep2AddLovedOneScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualRelationshipGoals,
          page: () => const IndividualStep3RelationshipGoalsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: individualSecondaryGoals,
          page: () => const IndividualStep4SecondaryGoalsScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: lovedOnePreferences,
          page: () => const LovedOnePreferencesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: dislikes,
          page: () => const DislikesScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: personalNote,
          page: () => const PersonalNoteScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: choosePlan,
          page: () => const ChoosePlanScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: checkout,
          page: () => const CheckoutScreen(),
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
