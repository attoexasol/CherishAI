// lib/app/theme/app_gradients.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Gradient tokens from React SplashScreen (135deg ≈ Flutter Alignment.topLeft to bottomRight).
abstract class AppGradients {
  /// Page background: linear-gradient(180deg, ...)
  static const LinearGradient splashPageBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.splashBgStart,
      AppColors.splashBg25,
      AppColors.splashBg50,
      AppColors.splashBg75,
      AppColors.splashBgEnd,
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  /// Logo / primary CTA: linear-gradient(135deg, #E91E63 0%, #9C27B0 100%)
  static const LinearGradient primaryPinkPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryPink, AppColors.primaryPurple],
  );

  /// Brand name text gradient: C2185B → E91E63 → 9C27B0 → 7B1FA2
  static const LinearGradient brandText = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.pinkDark,
      AppColors.primaryPink,
      AppColors.primaryPurple,
      AppColors.purpleDark,
    ],
    stops: [0.0, 0.25, 0.75, 1.0],
  );

  /// Headline "Unforgettable" gradient
  static const LinearGradient headlineAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryPink, AppColors.primaryPurple],
  );

  /// Badge background (soft)
  static const LinearGradient badgeBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1AE91E63),
      Color(0x1A9C27B0),
    ],
  );

  /// Stat gradients
  static const LinearGradient statUsers = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryPink, AppColors.pinkAccent],
  );
  static const LinearGradient statMoments = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryPurple, AppColors.purpleAccent],
  );
  static const LinearGradient statRating = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.pinkAccent, AppColors.pinkLight],
  );

  /// Feature 1: Heart
  static const LinearGradient feature1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryPink, AppColors.pinkAccent],
  );
  /// Feature 2: Calendar
  static const LinearGradient feature2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryPurple, AppColors.purpleAccent],
  );
  /// Feature 3: Gift
  static const LinearGradient feature3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.pinkAccent, AppColors.pinkLight],
  );

  /// Onboarding Intro: top card / CTA card gradient (135deg, white 0.95 -> pink tint 0.9)
  static const LinearGradient onboardingCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF2FFFFFF),
      Color(0xE6FFF1F7),
    ],
  );
  /// Onboarding "How it works" card gradient (slightly different tint)
  static const LinearGradient onboardingHowCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xD9FFFFFF),
      Color(0xCCFFF1F7),
    ],
  );
  /// Onboarding card 2 (heavy lifting) - FEF2F8 tint
  static const LinearGradient onboardingHeavyCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xD9FFFFFF),
      Color(0xCCFEF2F8),
    ],
  );
  /// Globe button / language menu
  static const LinearGradient onboardingGlobeBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF2FFFFFF),
      Color(0xE6FFF1F7),
    ],
  );
  /// Continue button: FB7185 -> F472B6
  static const LinearGradient onboardingContinueBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFB7185),
      Color(0xFFF472B6),
    ],
  );
  /// Value prop text gradient: E11D48 -> EC4899 -> A855F7
  static const LinearGradient onboardingValuePropText = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.onboardingValuePropRed,
      AppColors.onboardingValuePropPink,
      AppColors.onboardingValuePropPurple,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Number circle background (soft pink)
  static const LinearGradient onboardingStepCircleBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x26FB7185),
      Color(0x26F472B6),
    ],
  );
  /// Auth: back button, tab active, CTA button (rose -> pink -> purple, horizontal)
  static const LinearGradient authTabAndCta = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFF43F5E),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Auth screen back button (white/pink tint)
  static const LinearGradient authBackButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF2FFFFFF),
      Color(0xE6FFF1F7),
    ],
  );

  /// User Type: page background (purple-100 -> pink-50 -> rose-100)
  static const LinearGradient userTypePageBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF3E8FF),
      Color(0xFFFDF2F8),
      Color(0xFFFFE4E6),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// User Type: back button (same as auth-style)
  static const LinearGradient userTypeBackButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF2FFFFFF),
      Color(0xE6FFF1F7),
    ],
  );
  /// User Type: checkmark circle / card selected gradient
  static const LinearGradient userTypeCheckGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFB7185),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );

  /// Business card gradient (purple tint shadow)
  static const LinearGradient onboardingBusinessCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xF2FFFFFF),
      Color(0xEBFEF2F8),
    ],
  );
}
