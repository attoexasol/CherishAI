// lib/app/bindings/initial_binding.dart
import 'package:get/get.dart';
import '../../presentation/splash/controllers/splash_controller.dart';
import '../../presentation/onboarding/controllers/onboarding_intro_controller.dart';
import '../../presentation/auth/controllers/auth_controller.dart';
import '../../presentation/onboarding/controllers/user_type_controller.dart';

/// Registers global/splash/onboarding/auth dependencies. Extend when adding more screens.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<OnboardingIntroController>(() => OnboardingIntroController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UserTypeController>(() => UserTypeController());
  }
}
