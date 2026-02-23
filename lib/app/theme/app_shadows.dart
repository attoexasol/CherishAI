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

  /// Individual Profile Step 1: back button
  static const List<BoxShadow> profileStep1BackButton = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x26FB7185),
    ),
  ];
  /// Profile Step 1: avatar circle
  static const List<BoxShadow> profileStep1Avatar = [
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x33FB7185),
    ),
  ];
  /// Profile Step 1: form card
  static const List<BoxShadow> profileStep1Card = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Profile Step 1: camera badge
  static const List<BoxShadow> profileStep1CameraBadge = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x33FB7185),
    ),
  ];
  /// Profile Step 1: CTA button (reuse onboarding continue)
  static const List<BoxShadow> profileStep1Cta = onboardingContinueBtn;

  /// Individual Step 2: back button
  static const List<BoxShadow> lovedOneBackButton = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x26FB7185),
    ),
  ];
  /// Step 2: heart circle
  static const List<BoxShadow> lovedOneHeartCircle = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x40FB7185),
    ),
  ];
  /// Step 2: photo circle
  static const List<BoxShadow> lovedOnePhotoCircle = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x1AFB7185),
    ),
  ];
  /// Step 2: section card
  static const List<BoxShadow> lovedOneSectionCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Step 2: tile (unselected)
  static const List<BoxShadow> lovedOneTile = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Step 2: tile selected
  static const List<BoxShadow> lovedOneTileSelected = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x33FB7185),
    ),
  ];
  /// Step 2: CTA button
  static const List<BoxShadow> lovedOneCta = onboardingContinueBtn;

  /// Individual Step 3: back button (white circle)
  static const List<BoxShadow> goalsBackButton = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Step 3: target icon circle
  static const List<BoxShadow> goalsTargetCircle = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x33BE185D),
    ),
  ];
  /// Step 3: goal card
  static const List<BoxShadow> goalsCard = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Step 3: goal card selected
  static const List<BoxShadow> goalsCardSelected = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x26FB7185),
    ),
  ];
  /// Step 3: Save button enabled
  static const List<BoxShadow> goalsSaveEnabled = onboardingContinueBtn;

  /// Individual Step 4: back button
  static const List<BoxShadow> secGoalsBackButton = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Step 4: selected pill
  static const List<BoxShadow> secGoalsPill = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Step 4: section icon bubble
  static const List<BoxShadow> secGoalsSectionBubble = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Step 4: option card
  static const List<BoxShadow> secGoalsOptionCard = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Step 4: CTA enabled
  static const List<BoxShadow> secGoalsCtaEnabled = onboardingContinueBtn;

  /// Loved One Preferences: back button
  static const List<BoxShadow> prefsBackButton = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x1AA855F7),
    ),
  ];
  /// Loved One Preferences: optional pill
  static const List<BoxShadow> prefsOptionalPill = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Loved One Preferences: section icon bubble
  static const List<BoxShadow> prefsSectionBubble = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Loved One Preferences: category card
  static const List<BoxShadow> prefsCategoryCard = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Loved One Preferences: Continue CTA
  static const List<BoxShadow> prefsCta = onboardingContinueBtn;

  /// Dislikes: Final Step pill
  static const List<BoxShadow> dislikesFinalPill = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Dislikes: category card
  static const List<BoxShadow> dislikesCard = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Dislikes: Continue CTA
  static const List<BoxShadow> dislikesCta = onboardingContinueBtn;
  /// Dislikes: Add Custom Dislike button
  static const List<BoxShadow> dislikesAddButton = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];

  /// Personal Note: icon bubble
  static const List<BoxShadow> noteBubble = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x1AA855F7),
    ),
  ];
  /// Personal Note: main card
  static const List<BoxShadow> noteCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Personal Note: Continue CTA enabled
  static const List<BoxShadow> noteCtaEnabled = onboardingContinueBtn;

  /// Subscription: active card + plan cards
  static const List<BoxShadow> subCard = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Subscription: CTA button
  static const List<BoxShadow> subCta = onboardingContinueBtn;

  /// Checkout: cards
  static const List<BoxShadow> checkoutCard = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Checkout: CTA button
  static const List<BoxShadow> checkoutCta = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x26FB7185),
    ),
  ];
}
