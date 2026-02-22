// lib/app/bindings/initial_binding.dart
import 'package:get/get.dart';
import '../../presentation/splash/controllers/splash_controller.dart';
import '../../presentation/onboarding/controllers/onboarding_intro_controller.dart';
import '../../presentation/auth/controllers/auth_controller.dart';
import '../../presentation/onboarding/controllers/user_type_controller.dart';
import '../../presentation/onboarding/controllers/individual_step1_profile_controller.dart';
import '../../presentation/onboarding/controllers/individual_step2_add_loved_one_controller.dart';
import '../../presentation/onboarding/controllers/individual_step3_relationship_goals_controller.dart';
import '../../presentation/onboarding/controllers/individual_step4_secondary_goals_controller.dart';

/// Registers global/splash/onboarding/auth dependencies. Extend when adding more screens.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<OnboardingIntroController>(() => OnboardingIntroController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UserTypeController>(() => UserTypeController());
    Get.lazyPut<IndividualStep1ProfileController>(() => IndividualStep1ProfileController());
    Get.lazyPut<IndividualStep2AddLovedOneController>(() => IndividualStep2AddLovedOneController());
    Get.lazyPut<IndividualStep3RelationshipGoalsController>(() => IndividualStep3RelationshipGoalsController());
    Get.lazyPut<IndividualStep4SecondaryGoalsController>(() => IndividualStep4SecondaryGoalsController());
  }
}
