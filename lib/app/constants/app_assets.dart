// lib/app/constants/app_assets.dart
// Local asset paths only. All images under assets/images/ (see assets/images/README.md).
// Replace placeholder PNGs with exports from design when available.

abstract class AppAssets {
  static const String _base = 'assets/images';

  // --- Shared / branding (Splash, Auth, User Type) ---
  /// assets/images/cherish_logo.png
  static const String cherishLogo = '$_base/cherish_logo.png';

  // --- Onboarding intro (HeroBannerDemo) ---
  /// assets/images/onboarding_family_illustration.png
  static const String onboardingFamilyIllustration = '$_base/onboarding_family_illustration.png';
  /// assets/images/cherish_ai_branded_logo.png
  static const String cherishAIBrandedLogo = '$_base/cherish_ai_branded_logo.png';
  /// assets/images/time_clock.png
  static const String timeClock = '$_base/time_clock.png';
  /// assets/images/efforts.png
  static const String efforts = '$_base/efforts.png';
  /// assets/images/emotional_work.png
  static const String emotionalWork = '$_base/emotional_work.png';
  /// assets/images/cherish_ai_logo.png
  static const String cherishAILogo = '$_base/cherish_ai_logo.png';
  /// assets/images/cherish_ai_purple_logo.png
  static const String cherishAIPurpleLogo = '$_base/cherish_ai_purple_logo.png';
  /// assets/images/cherish_ai_logo_text.png
  static const String cherishAILogoText = '$_base/cherish_ai_logo_text.png';
  /// assets/images/cherish_ai_logo_pink.png
  static const String cherishAILogoPink = '$_base/cherish_ai_logo_pink.png';
  /// assets/images/onboarding_background.png
  static const String onboardingBackground = '$_base/onboarding_background.png';
  /// assets/images/onboarding_step2_illustration.png
  static const String onboardingStep2Illustration = '$_base/onboarding_step2_illustration.png';

  // --- User type screen ---
  /// assets/images/individual_illustration.png
  static const String individualIllustration = '$_base/individual_illustration.png';
  /// assets/images/business_illustration.png
  static const String businessIllustration = '$_base/business_illustration.png';

  // --- Icons (social / UI) ---
  static const String iconWhatsapp = '$_base/icon_whatsapp.png';
  static const String iconInstagram = '$_base/icon_instagram.png';
  static const String iconTelegram = '$_base/icon_telegram.png';
  static const String iconFacebook = '$_base/icon_facebook.png';
  static const String iconTiktok = '$_base/icon_tiktok.png';
  static const String iconReddit = '$_base/icon_reddit.png';
  static const String iconSnapchat = '$_base/icon_snapchat.png';
  static const String discoverButton = '$_base/discover_button.png';
  static const String chooseHigherTier = '$_base/choose_higher_tier.png';
  static const String placeholderError = '$_base/placeholder_error.png';
}
