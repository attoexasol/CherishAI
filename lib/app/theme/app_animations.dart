// lib/app/theme/app_animations.dart
import 'package:flutter/material.dart';

/// Animation durations and curves from React SplashScreen (motion/react).
abstract class AppAnimations {
  /// Logo entrance: duration 1.2, ease [0.34, 1.56, 0.64, 1] (spring-like)
  static const Duration logoEntrance = Duration(milliseconds: 1200);
  static const Curve logoEntranceCurve = Curves.elasticOut;

  /// Hero scale/opacity on scroll: duration 4s repeat
  static const Duration heroFloat = Duration(milliseconds: 4000);

  /// Feature carousel interval: 4500ms
  static const Duration featureCarouselInterval = Duration(milliseconds: 4500);

  /// Stagger delays (ms)
  static const int delayBrand = 400;
  static const int delayBadge = 600;
  static const int delayHeadline = 800;
  static const int delaySubheadline = 1000;
  static const int delayStats = 1200;
  static const int delayStatItem = 100;
  static const int delayScrollHint = 1500;
  static const int durationFadeIn = 800;
  static const int durationFadeInShort = 600;

  /// Scroll indicator bounce: 1.5s repeat
  static const Duration scrollIndicatorBounce = Duration(milliseconds: 1500);
  static const Curve scrollIndicatorCurve = Curves.easeInOut;

  /// CTA shimmer: 2s repeat
  static const Duration ctaShimmer = Duration(milliseconds: 2000);
  static const Duration ctaPulse = Duration(milliseconds: 2000);

  /// Viewport reveal: 0.6s
  static const Duration viewportReveal = Duration(milliseconds: 600);

  // --- Onboarding intro hero (HeroBannerDemo) ---
  /// Logo float: y [0, -8, 0], duration 4s, repeat, easeInOut
  static const Duration onboardingHeroLogoFloat = Duration(milliseconds: 4000);
  static const double onboardingHeroLogoFloatOffset = 8.0;
  static const Curve onboardingHeroFloatCurve = Curves.easeInOut;
  /// Sparkles (top-right): rotate/scale, 3s repeat
  static const Duration onboardingHeroSparkle = Duration(milliseconds: 3000);
  /// Star (bottom-left): rotate/scale, 3.5s repeat, delay 0.5s
  static const Duration onboardingHeroStar = Duration(milliseconds: 3500);
  static const Duration onboardingHeroStarDelay = Duration(milliseconds: 500);
}
