// lib/app/theme/app_colors.dart
import 'package:flutter/material.dart';

/// Design tokens for colors. Extracted from React SplashScreen computed/source.
abstract class AppColors {
  // --- Splash / Marketing palette ---
  static const Color splashBgStart = Color(0xFFFFFBFC);
  static const Color splashBg25 = Color(0xFFFFF5F7);
  static const Color splashBg50 = Color(0xFFFFEFF3);
  static const Color splashBg75 = Color(0xFFFCE8ED);
  static const Color splashBgEnd = Color(0xFFF5E0E7);

  static const Color primaryPink = Color(0xFFE91E63);
  static const Color primaryPurple = Color(0xFF9C27B0);
  static const Color pinkDark = Color(0xFFC2185B);
  static const Color purpleDark = Color(0xFF7B1FA2);
  static const Color pinkAccent = Color(0xFFF06292);
  static const Color pinkLight = Color(0xFFF48FB1);
  static const Color purpleAccent = Color(0xFFBA68C8);

  static const Color textPrimary = Color(0xFF4A1942);
  static const Color textSecondary = Color(0xFF6B2C4D);
  static const Color textMuted = Color(0xFF9C7B8A);

  static const Color success = Color(0xFF10B981);

  static const Color white = Color(0xFFFFFFFF);
  static const Color white70 = Color(0xB3FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white40 = Color(0x66FFFFFF);

  // --- Onboarding Intro (HeroBannerDemo) ---
  static const Color onboardingPageBg = Color(0xFFFFFFFF);
  static const Color onboardingHeadline = Color(0xFF7A3E55);
  static const Color onboardingBulletText = Color(0xFFA84968);
  static const Color onboardingSubtext = Color(0xFF8B4A65);
  static const Color onboardingThatsAll = Color(0xFFB05A78);
  static const Color onboardingValuePropRed = Color(0xFFE11D48);
  static const Color onboardingValuePropPink = Color(0xFFEC4899);
  static const Color onboardingValuePropPurple = Color(0xFFA855F7);
  static const Color onboardingPinkFill = Color(0xFFF9A8D4);
  static const Color onboardingRoseFill = Color(0xFFFB7185);
  static const Color onboardingCardBorder = Color(0x4DFBCFE8);
  static const Color onboardingCardBorderStrong = Color(0x80FB7185);
  static const Color onboardingGlobeBorder = Color(0x66FBCFE8);

  // --- Auth (Sign Up / Login) ---
  static const Color authBackBg = Color(0xFFEFE8FF);
  static const Color authWelcomeTitle = Color(0xFFE22B69);
  static const Color authSubtitle = Color(0xFF333333);
  static const Color authTabContainerBg = Color(0xFFF8F8F8);
  static const Color authTabInactiveText = Color(0xFF333333);
  static const Color authSocialButtonBg = Color(0xFFFFFFFF);
  static const Color authSocialButtonText = Color(0xFF333333);
  static const Color authDividerLine = Color(0xFFE5E5E5);
  static const Color authDividerText = Color(0xFFAAAAAA);
  static const Color authInputBg = Color(0xFFFFF2F6);
  static const Color authInputPlaceholder = Color(0xFFF28BA8);
  static const Color authInputBorder = Color(0xFFFECDD3);
  static const Color authInputFocusBorder = Color(0xFFE91E63);
  static const Color authFooterText = Color(0xB3666666);
  static const Color authErrorBg = Color(0xFFFEF2F2);
  static const Color authErrorBorder = Color(0xFFFECACA);
  static const Color authErrorText = Color(0xFFB91C1C);

  // --- User Type selection ---
  static const Color userTypeBgStart = Color(0xFFF3E8FF);
  static const Color userTypeBgMid = Color(0xFFFDF2F8);
  static const Color userTypeBgEnd = Color(0xFFFFE4E6);
  static const Color userTypeTitle = Color(0xFF6B21A8);
  static const Color userTypeTitleAccent = Color(0xFFE11D48);
  static const Color userTypeSubtitle = Color(0xFFF43F5E);
  static const Color userTypeCardBg = Color(0xCCFFFFFF);
  static const Color userTypeCardTitle = Color(0xFF6B21A8);
  static const Color userTypeCardDesc = Color(0xFF374151);
  static const Color userTypeCardBorder = Color(0x99FDA4AF);
  static const Color userTypeCardBorderSelected = Color(0xB3FB7185);
  static const Color userTypeCardBorderBusiness = Color(0x99C4B5FD);
  static const Color userTypeCardBorderBusinessSelected = Color(0xB3A78BFA);
}
