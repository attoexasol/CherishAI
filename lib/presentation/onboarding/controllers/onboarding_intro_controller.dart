// lib/presentation/onboarding/controllers/onboarding_intro_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Mirrors HeroBannerDemo UI state and actions. Flow: Continue → Auth.
class OnboardingIntroController extends GetxController {
  final RxBool showLanguageMenu = false.obs;
  final RxString selectedLanguage = 'English'.obs;

  static const List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'it', 'name': 'Italiano', 'flag': '🇮🇹'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇵🇹'},
    {'code': 'zh', 'name': '中文', 'flag': '🇨🇳'},
    {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
    {'code': 'ko', 'name': '한국어', 'flag': '🇰🇷'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
    {'code': 'hi', 'name': 'हिन्दी', 'flag': '🇮🇳'},
    {'code': 'ru', 'name': 'Русский', 'flag': '🇷🇺'},
  ];

  void onTapGlobe() {
    showLanguageMenu.value = !showLanguageMenu.value;
  }

  void handleLanguageSelect(String name) {
    selectedLanguage.value = name;
    showLanguageMenu.value = false;
  }

  /// Flow: onboarding intro → auth
  void onTapContinue() {
    Get.offNamed(AppRoutes.auth);
  }

  void closeLanguageMenu() {
    showLanguageMenu.value = false;
  }
}
