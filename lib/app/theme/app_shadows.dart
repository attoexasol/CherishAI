// lib/app/theme/app_shadows.dart
import 'package:flutter/material.dart';

/// Box shadow tokens from React SplashScreen (exact offset, blur, spread, color).
abstract class AppShadows {
  /// Logo: 0 25px 70px rgba(233, 30, 99, 0.45), inset 0 1px 20px rgba(255, 255, 255, 0.4)
  static const List<BoxShadow> logo = [
    BoxShadow(
      offset: Offset(0, 25),
      blurRadius: 70,
      spreadRadius: 0,
      color: Color(0x73E91E63),
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 20,
      spreadRadius: 0,
      color: Color(0x66FFFFFF),
    ),
  ];

  /// Badge: 0 8px 32px rgba(233, 30, 99, 0.2)
  static const List<BoxShadow> badge = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x33E91E63),
    ),
  ];

  /// Stat card: 0 8px 32px rgba(233, 30, 99, 0.12)
  static const List<BoxShadow> statCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x1FE91E63),
    ),
  ];

  /// Stat card hover: 0 12px 40px rgba(233, 30, 99, 0.2)
  static const List<BoxShadow> statCardHover = [
    BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 40,
      spreadRadius: 0,
      color: Color(0x33E91E63),
    ),
  ];

  /// Feature card: 0 20px 60px rgba(233, 30, 99, 0.15)
  static const List<BoxShadow> featureCard = [
    BoxShadow(
      offset: Offset(0, 20),
      blurRadius: 60,
      spreadRadius: 0,
      color: Color(0x26E91E63),
    ),
  ];

  /// Feature card hover: 0 25px 70px rgba(233, 30, 99, 0.25)
  static const List<BoxShadow> featureCardHover = [
    BoxShadow(
      offset: Offset(0, 25),
      blurRadius: 70,
      spreadRadius: 0,
      color: Color(0x40E91E63),
    ),
  ];

  /// Trust section card: same as feature card
  static const List<BoxShadow> trustCard = featureCard;

  /// CTA button: 0 20px 60px rgba(233, 30, 99, 0.45)
  static const List<BoxShadow> ctaButton = [
    BoxShadow(
      offset: Offset(0, 20),
      blurRadius: 60,
      spreadRadius: 0,
      color: Color(0x73E91E63),
    ),
  ];

  /// CTA button hover: 0 25px 70px rgba(233, 30, 99, 0.55)
  static const List<BoxShadow> ctaButtonHover = [
    BoxShadow(
      offset: Offset(0, 25),
      blurRadius: 70,
      spreadRadius: 0,
      color: Color(0x8CE91E63),
    ),
  ];

  /// Feature icon: 0 12px 32px color40
  static BoxShadow featureIconShadow(Color color) => BoxShadow(
        offset: const Offset(0, 12),
        blurRadius: 32,
        spreadRadius: 0,
        color: color.withValues(alpha: 0.25),
      );

  /// Onboarding Intro: card 0 8px 32px rgba(236, 72, 153, 0.12)
  static const List<BoxShadow> onboardingCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x1FEC4899),
    ),
  ];
  /// How it works card: 0 8px 32px rgba(236, 72, 153, 0.1)
  static const List<BoxShadow> onboardingHowCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x1AEC4899),
    ),
  ];
  /// Globe button: 0 8px 24px rgba(236, 72, 153, 0.25)
  static const List<BoxShadow> onboardingGlobe = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x40EC4899),
    ),
  ];
  /// Continue button: 0 8px 24px rgba(251, 113, 133, 0.4)
  static const List<BoxShadow> onboardingContinueBtn = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x66FB7185),
    ),
  ];
  /// Business card: 0 8px 32px rgba(168, 85, 247, 0.15)
  static const List<BoxShadow> onboardingBusinessCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x26A855F7),
    ),
  ];

  /// Auth: back button 0 8px 24px rgba(236, 72, 153, 0.25)
  static const List<BoxShadow> authBackButton = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x40EC4899),
    ),
  ];
  /// Auth: segmented container / social buttons subtle
  static const List<BoxShadow> authCardSubtle = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Auth: active tab / CTA button prominent
  static const List<BoxShadow> authCtaShadow = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x66EC4899),
    ),
  ];
  /// Auth: input default
  static const List<BoxShadow> authInputShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x33F6A6C1),
    ),
  ];
  /// Auth: input focus
  static const List<BoxShadow> authInputFocusShadow = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x66E91E63),
    ),
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 20,
      spreadRadius: 0,
      color: Color(0x33E91E63),
    ),
  ];

  /// User Type: back button
  static const List<BoxShadow> userTypeBackButton = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x40EC4899),
    ),
  ];
  /// User Type: card default (Individual rose tint)
  static const List<BoxShadow> userTypeCardDefault = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x26F43F5E),
    ),
  ];
  /// User Type: card selected
  static const List<BoxShadow> userTypeCardSelected = [
    BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 40,
      spreadRadius: 0,
      color: Color(0x40F43F5E),
    ),
    BoxShadow(
      offset: Offset(0, 24),
      blurRadius: 72,
      spreadRadius: 0,
      color: Color(0x26EC4899),
    ),
  ];
  /// User Type: card default Business (purple tint)
  static const List<BoxShadow> userTypeCardBusinessDefault = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: 0,
      color: Color(0x269333EA),
    ),
  ];
  /// User Type: illustration container
  static const List<BoxShadow> userTypeIllustrationShadow = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x26000000),
    ),
  ];
}
