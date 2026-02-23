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
import '../../presentation/loved_one_preferences/controllers/loved_one_preferences_controller.dart';
import '../../presentation/dislikes/controllers/dislikes_controller.dart';
import '../../presentation/personal_note/controllers/personal_note_controller.dart';
import '../../presentation/subscription/controllers/choose_plan_controller.dart';
import '../../presentation/checkout/controllers/checkout_controller.dart';

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
    Get.lazyPut<LovedOnePreferencesController>(() => LovedOnePreferencesController());
    Get.lazyPut<DislikesController>(() => DislikesController());
    Get.lazyPut<PersonalNoteController>(() => PersonalNoteController());
    Get.lazyPut<ChoosePlanController>(() => ChoosePlanController());
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}
