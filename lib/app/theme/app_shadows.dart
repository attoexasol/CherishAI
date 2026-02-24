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
  /// Prefs modal dialogs: container shadow (lifted modal)
  static const List<BoxShadow> prefsDialogShadow = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 20,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];

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

  /// Home: greeting card, message cards, event cards
  static const List<BoxShadow> homeCard = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Home: message card hover / prominent
  static const List<BoxShadow> homeMessageCard = [
    BoxShadow(
      offset: Offset(0, 20),
      blurRadius: 60,
      spreadRadius: 0,
      color: Color(0x66F472B6),
    ),
  ];
  /// Home: Regenerate / Gift Ideas button
  static const List<BoxShadow> homeRegenerateBtn = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x40E11D48),
    ),
  ];
  /// Home: inspiration card
  static const List<BoxShadow> homeInspirationCard = [
    BoxShadow(
      offset: Offset(0, 20),
      blurRadius: 40,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Home: bottom nav bar
  static const List<BoxShadow> homeBottomNav = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 60,
      spreadRadius: 0,
      color: Color(0x26F43F5E),
    ),
    BoxShadow(
      offset: Offset(0, -5),
      blurRadius: 30,
      spreadRadius: 0,
      color: Color(0x1AFFB6C1),
    ),
  ];
  /// Home: bottom nav active tab pill
  static const List<BoxShadow> homeBottomNavActivePill = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 20,
      spreadRadius: 0,
      color: Color(0x40F43F5E),
    ),
  ];

  /// Notifications: Mark All Read + tab active
  static const List<BoxShadow> notifPrimaryBtn = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x4DE91E63),
    ),
  ];
  /// Notifications: header bell icon
  static const List<BoxShadow> notifBellIcon = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x66E91E63),
    ),
  ];
  /// Notifications: card read
  static const List<BoxShadow> notifCardRead = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x1AF6A6C1),
    ),
  ];
  /// Notifications: card unread
  static const List<BoxShadow> notifCardUnread = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x33E91E63),
    ),
  ];
  /// Notifications: card icon square
  static const List<BoxShadow> notifCardIcon = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x4DF6A6C1),
    ),
  ];
  /// Notifications: tab inactive
  static const List<BoxShadow> notifTabInactive = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x1AF6A6C1),
    ),
  ];
  /// Notifications: empty state icon
  static const List<BoxShadow> notifEmptyIcon = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x4DF6A6C1),
    ),
  ];

  /// Profile: edit button (view mode white, edit mode gradient)
  static const List<BoxShadow> profileEditButton = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x33000000),
    ),
  ];
  /// Profile: avatar circle
  static const List<BoxShadow> profileAvatar = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x33FB7185),
    ),
  ];
  /// Profile: stat cards + personal info card (RomanticCard: 0 8px 30px rgba(0,0,0,0.08))
  static const List<BoxShadow> profileCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 30,
      spreadRadius: 0,
      color: Color(0x14000000),
    ),
  ];
  /// Profile: Save Changes button
  static const List<BoxShadow> profileSaveBtn = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x50F472B6),
    ),
  ];
  /// Edit Loved One: section card (shadow-sm)
  static const List<BoxShadow> editLovedOneCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Edit Loved One: photo card (shadow-lg)
  static const List<BoxShadow> editLovedOnePhotoCard = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
      color: Color(0x0D000000),
    ),
  ];

  /// Search: search bar (shadow-lg ≈ 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05)) ≈ 0 10px 15px -3px rgba(0,0,0,0.1), 0 4px 6px -2px rgba(0,0,0,0.05))
  static const List<BoxShadow> searchBar = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
      color: Color(0x0D000000),
    ),
  ];
  /// Search: Quick Access tile (shadow-lg)
  static const List<BoxShadow> searchQuickTile = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
      color: Color(0x0D000000),
    ),
  ];
  /// Search: RomanticCard-style card (0 8px 30px rgba(0,0,0,0.08))
  static const List<BoxShadow> searchCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 30,
      spreadRadius: 0,
      color: Color(0x14000000),
    ),
  ];
  /// Search: Recent chip (shadow-sm)
  static const List<BoxShadow> searchRecentChip = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Loved Ones list: back button
  static const List<BoxShadow> lovedOnesBackBtn = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Loved Ones list: Add + button (shadow-lg)
  static const List<BoxShadow> lovedOnesAddBtn = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
      color: Color(0x0D000000),
    ),
  ];
  /// Loved Ones list: card (shadow-lg)
  static const List<BoxShadow> lovedOnesCard = [
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
      color: Color(0x1A000000),
    ),
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
      color: Color(0x0D000000),
    ),
  ];
  /// Loved Ones list: avatar tile (shadow-md)
  static const List<BoxShadow> lovedOnesAvatar = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Loved Ones list: edit/delete icon buttons (shadow-sm)
  static const List<BoxShadow> lovedOnesIconBtn = [
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Account Settings modal: dialog (shadow-2xl)
  static const List<BoxShadow> accountSettingsDialog = [
    BoxShadow(
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
      color: Color(0x40000000),
    ),
    BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -6,
      color: Color(0x20000000),
    ),
  ];
  /// Manage Subscription: current plan card + plan cards
  static const List<BoxShadow> manageSubCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x1A000000),
    ),
  ];
  /// Before you go: dialog (shadow-2xl)
  static const List<BoxShadow> beforeYouGoDialog = [
    BoxShadow(
      offset: Offset(0, 25),
      blurRadius: 50,
      spreadRadius: -12,
      color: Color(0x40000000),
    ),
    BoxShadow(
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -6,
      color: Color(0x20000000),
    ),
  ];
  /// Help & Feedback: cards + Submit button
  static const List<BoxShadow> helpFeedbackCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  static const List<BoxShadow> helpFeedbackSubmitBtn = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x40EC4899),
    ),
  ];
  /// Gift Ideas / Events / Old Messages: cards
  static const List<BoxShadow> giftIdeasCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  static const List<BoxShadow> giftIdeasBackBtn = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x33A78BFA),
    ),
  ];
  static const List<BoxShadow> giftIdeasViewAllBtn = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x40EC4899),
    ),
  ];
  static const List<BoxShadow> eventsCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  static const List<BoxShadow> oldMessagesCard = [
    BoxShadow(
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
      color: Color(0x0D000000),
    ),
  ];
  /// Loved One Details: content cards (RomanticCard 0 8px 30px rgba(0,0,0,0.08))
  static const List<BoxShadow> lovedOneDetailsCard = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 30,
      spreadRadius: 0,
      color: Color(0x14000000),
    ),
  ];
  /// Loved One Details: edit button (top right)
  static const List<BoxShadow> lovedOneDetailsEditBtn = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x33000000),
    ),
  ];
  /// Loved One Details: View Gift Ideas / View Subscription Plans button
  static const List<BoxShadow> lovedOneDetailsCtaBtn = [
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x50F472B6),
    ),
  ];
}

