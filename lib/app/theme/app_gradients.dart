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

  /// Individual Profile Step 1: page background (light purple-pink -> rosy)
  static const LinearGradient profileStep1PageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFBEFFF),
      Color(0xFFFDF5F8),
      Color(0xFFFCEEF3),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Profile Step 1: avatar circle (90deg pink -> purple-pink)
  static const LinearGradient profileStep1Avatar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFFB7185),
      Color(0xFFF472B6),
    ],
  );
  /// Profile Step 1: CTA button (same as onboarding continue)
  static const LinearGradient profileStep1Cta = onboardingContinueBtn;

  /// Individual Step 2 (Add loved one): page background
  static const LinearGradient lovedOnePageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF2F8),
      Color(0xFFFCE7F3),
    ],
  );
  /// Step 2: Save & Continue CTA (same as onboarding continue)
  static const LinearGradient lovedOneCta = onboardingContinueBtn;

  /// Individual Step 3: page background (light pink -> near white)
  static const LinearGradient goalsPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF5F8),
      Color(0xFFFAFAFA),
    ],
  );
  /// Step 3: Save button enabled (same as onboarding continue)
  static const LinearGradient goalsSaveEnabled = onboardingContinueBtn;

  /// Individual Step 4: page background (white -> light pink)
  static const LinearGradient secGoalsPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFFDF2F8),
    ],
  );
  /// Step 4: CTA enabled (same as onboarding continue)
  static const LinearGradient secGoalsCtaEnabled = onboardingContinueBtn;

  /// Loved One Preferences: page background
  static const LinearGradient prefsPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF5F8),
      Color(0xFFF5F3FF),
    ],
  );
  /// Loved One Preferences: Continue CTA
  static const LinearGradient prefsCta = onboardingContinueBtn;

  /// Dislikes: page background
  static const LinearGradient dislikesPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF8F9),
      Color(0xFFFAFAF9),
    ],
  );
  /// Dislikes: Continue CTA
  static const LinearGradient dislikesCta = onboardingContinueBtn;

  /// Personal Note: page background
  static const LinearGradient notePageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF5F8),
      Color(0xFFFFFFFF),
    ],
  );
  /// Personal Note: Continue CTA enabled
  static const LinearGradient noteCtaEnabled = onboardingContinueBtn;

  /// Subscription: page background
  static const LinearGradient subPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF5F8),
      Color(0xFFFFFFFF),
    ],
  );
  /// Subscription: header heart icon + plan card icon + Recommended pill + CTA buttons
  static const LinearGradient subAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFB7185),
      Color(0xFFF472B6),
    ],
  );
  /// Subscription: CTA button (pink–purple)
  static const LinearGradient subCta = onboardingContinueBtn;

  /// Checkout: page background
  static const LinearGradient checkoutPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFDF5F8),
      Color(0xFFFFFFFF),
    ],
  );
  /// Checkout: header check icon + order summary sparkle + Due Today amount
  static const LinearGradient checkoutAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFB7185),
      Color(0xFFA855F7),
    ],
  );
  /// Checkout: Complete Purchase CTA
  static const LinearGradient checkoutCta = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFF43F5E),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );

  /// Home: page background (rose-50 -> pink-50 -> purple-50)
  static const LinearGradient homePageBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF1F2),
      Color(0xFFFDF2F8),
      Color(0xFFFAF5FF),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Home: top bar heart icon
  static const LinearGradient homeHeartIcon = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFA855F7),
    ],
  );
  /// Home: Regenerate Message / Gift Ideas button (rose -> pink -> purple)
  static const LinearGradient homeRegenerateBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Home: URGENT badge
  static const LinearGradient homeUrgentBadge = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFEC4899),
    ],
  );
  /// Home: event card icon square (rose -> purple)
  static const LinearGradient homeEventIconSquare = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFA855F7),
    ],
  );
  /// Home: inspiration icon square (purple -> pink)
  static const LinearGradient homeInspirationIcon = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA855F7),
      Color(0xFFEC4899),
    ],
  );
  /// Home: inspiration card background
  static const LinearGradient homeInspirationCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFAF5FF),
      Color(0xFFFDF2F8),
      Color(0xFFFFF1F2),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Home: inspiration Like button when active
  static const LinearGradient homeInspirationLikeActive = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFEC4899),
    ],
  );
  /// Home: bottom nav active pill
  static const LinearGradient homeBottomNavActivePill = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFECDD3),
      Color(0xFFFBCFE8),
      Color(0xFFFFF1F2),
    ],
    stops: [0.0, 0.5, 1.0],
  );

  /// Notifications: page background (same as home)
  static const LinearGradient notifPageBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF1F2),
      Color(0xFFFDF2F8),
      Color(0xFFFAF5FF),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Notifications: header bell icon + Mark All Read + tab active + Mark as Read button
  static const LinearGradient notifPrimaryBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE91E63),
      Color(0xFFF06292),
    ],
  );
  /// Notifications: title gradient text
  static const LinearGradient notifTitleGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Notifications: tag pill background
  static const LinearGradient notifTagPillBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF5F8),
      Color(0xFFFFE4EC),
    ],
  );
  /// Notifications: unread left bar
  static const LinearGradient notifUnreadBar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE91E63),
      Color(0xFFF06292),
    ],
  );
  /// Notifications: empty state icon
  static const LinearGradient notifEmptyIconBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF6A6C1),
      Color(0xFFFAD0DC),
    ],
  );
  /// Notifications: card icon by type (rose-pink)
  static const LinearGradient notifIconReminder = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFB7185), Color(0xFFF472B6)],
  );
  static const LinearGradient notifIconInspiration = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA78BFA), Color(0xFFF472B6)],
  );
  static const LinearGradient notifIconSuggestionPink = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF472B6), Color(0xFFFB7185)],
  );
  static const LinearGradient notifIconAchievement = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFBBF24), Color(0xFFFB923C)],
  );
  static const LinearGradient notifIconEvent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF87171), Color(0xFFF472B6)],
  );
  static const LinearGradient notifIconSuggestionBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)],
  );
  static const LinearGradient notifIconTip = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
  );

  /// Profile (User Profile): header gradient (rose-400 -> pink-400 -> purple-400)
  static const LinearGradient profileHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.profileHeaderStart,
      AppColors.profileHeaderMid,
      AppColors.profileHeaderEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Profile: edit button when active (edit mode)
  static const LinearGradient profileEditBtnActive = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.profileEditBtnActiveStart,
      AppColors.profileEditBtnActiveEnd,
    ],
  );
  /// Profile: Save Changes button (rose -> pink -> purple)
  static const LinearGradient profileSaveBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.profileSaveBtnStart,
      AppColors.profileSaveBtnMid,
      AppColors.profileSaveBtnEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Profile: stat card decorative gradient (rose-100/50 -> pink-100/50)
  static const LinearGradient profileCardDeco = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.profileCardBgGradientStart,
      AppColors.profileCardBgGradientEnd,
    ],
  );
  /// Profile: Manage Subscription button background
  static const LinearGradient profileManageSubBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.profileManageSubBgStart,
      AppColors.profileManageSubBgEnd,
    ],
  );
  /// Profile: Log Out button background
  static const LinearGradient profileLogoutBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.profileLogoutBgStart,
      AppColors.profileLogoutBgEnd,
    ],
  );

  /// Edit Loved One: page background (rose-50 -> pink-50 -> purple-50)
  static const LinearGradient editLovedOnePageBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.editLovedOnePageBgStart,
      AppColors.editLovedOnePageBgMid,
      AppColors.editLovedOnePageBgEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Edit Loved One: camera badge on avatar
  static const LinearGradient editLovedOneCameraBadge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.editLovedOneCameraBadgeStart,
      AppColors.editLovedOneCameraBadgeEnd,
    ],
  );
  /// Edit Loved One: secondary goal row selected (rose-50 -> pink-50)
  static const LinearGradient editLovedOneSecondaryRowSelected = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.editLovedOneSecondaryRowSelectedBgStart,
      AppColors.editLovedOneSecondaryRowSelectedBgEnd,
    ],
  );

  /// Search: header (purple-400 -> purple-500 -> indigo-500)
  static const LinearGradient searchHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.searchHeaderStart,
      AppColors.searchHeaderMid,
      AppColors.searchHeaderEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Search: Quick Access Loved Ones (rose-400 -> pink-400)
  static const LinearGradient searchQuickLovedOnes = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.searchQuickTileLovedOnesStart, AppColors.searchQuickTileLovedOnesEnd],
  );
  /// Search: Quick Access Gift Ideas (purple-400 -> indigo-400)
  static const LinearGradient searchQuickGift = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.searchQuickTileGiftStart, AppColors.searchQuickTileGiftEnd],
  );
  /// Search: Quick Access Events (blue-400 -> cyan-400)
  static const LinearGradient searchQuickEvents = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.searchQuickTileEventsStart, AppColors.searchQuickTileEventsEnd],
  );
  /// Search: Quick Access Old Messages (pink-400 -> rose-400)
  static const LinearGradient searchQuickMessages = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.searchQuickTileMessagesStart, AppColors.searchQuickTileMessagesEnd],
  );
  /// Search: Trending card icon bubble (purple-100 -> pink-100)
  static const LinearGradient searchTrendingBubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.searchTrendingBubbleStart, AppColors.searchTrendingBubbleEnd],
  );
  /// Loved Ones list: page background (rose-50 -> pink-50 -> purple-50)
  static const LinearGradient lovedOnesPageBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.lovedOnesPageBgStart,
      AppColors.lovedOnesPageBgMid,
      AppColors.lovedOnesPageBgEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Loved Ones list: Add button (rose-500 -> pink-500 -> purple-500)
  static const LinearGradient lovedOnesAddBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFF43F5E),  // rose-500
      Color(0xFFEC4899),  // pink-500
      Color(0xFFA855F7),  // purple-500
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Loved Ones list: avatar tile (rose-100 -> pink-100)
  static const LinearGradient lovedOnesAvatarBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.lovedOnesAvatarBgStart, AppColors.lovedOnesAvatarBgEnd],
  );
  /// Account Settings modal: header (rose-400 -> pink-500 -> purple-500)
  static const LinearGradient accountSettingsHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFB7185),  // rose-400
      Color(0xFFEC4899),  // pink-500
      Color(0xFFA855F7),  // purple-500
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Account Settings: row 1 icon bubble (purple-400 -> indigo-400)
  static const LinearGradient accountSettingsRow1Bubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA78BFA), Color(0xFF818CF8)],
  );
  /// Account Settings: row 2 icon bubble (blue-400 -> cyan-400)
  static const LinearGradient accountSettingsRow2Bubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF60A5FA), Color(0xFF22D3EE)],
  );
  /// Account Settings: row 3 icon bubble (green-400 -> emerald-400)
  static const LinearGradient accountSettingsRow3Bubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF34D399), Color(0xFF10B981)],
  );
  /// Account Settings: row 4 icon bubble (gray-400 -> slate-400)
  static const LinearGradient accountSettingsRow4Bubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF9CA3AF), Color(0xFF94A3B8)],
  );
  /// Manage Subscription: Upgrade button (collapsed) + Hide Plans (expanded) - pink
  static const LinearGradient manageSubUpgradeBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFF06292),
      Color(0xFFFF69B4),
    ],
  );
  /// Manage Subscription: Upgrade to Unlimited CTA (blue-purple)
  static const LinearGradient manageSubUpgradeUnlimited = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF6366F1),
      Color(0xFFA855F7),
    ],
  );
  /// Manage Subscription: Downgrade CTA (dark gray)
  static const LinearGradient manageSubDowngradeBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF374151),
      Color(0xFF111827),
    ],
  );
  /// Before you go: (cards use solid colors; no gradient)
  /// Help & Feedback: Submit button (pink -> purple)
  static const LinearGradient helpFeedbackSubmitBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
  );
  /// Gift Ideas: back button (purple -> pink)
  static const LinearGradient giftIdeasBackBtn = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA78BFA), Color(0xFFEC4899)],
  );
  /// Gift Ideas: stat card icons + View All + View Gift Ideas buttons (pink -> purple)
  static const LinearGradient giftIdeasStatIcon1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF472B6), Color(0xFFA855F7)],
  );
  static const LinearGradient giftIdeasStatIcon2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD8B4FE), Color(0xFFF472B6)],
  );
  static const LinearGradient giftIdeasViewAllBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
  );
  /// Gift Ideas: event card icon gradients (birthday, mother's day, friendship, father's day)
  static const LinearGradient giftIdeasEventIconBirthday = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF472B6), Color(0xFFA855F7)],
  );
  static const LinearGradient giftIdeasEventIconFlower = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFB923C), Color(0xFFF472B6)],
  );
  static const LinearGradient giftIdeasEventIconHandshake = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFBBF24), Color(0xFFFB923C)],
  );
  static const LinearGradient giftIdeasEventIconGift = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF60A5FA), Color(0xFFA855F7)],
  );
  /// Gift Ideas Detail: event header icon + gift card icon (rose-400 -> purple-400)
  static const LinearGradient giftIdeasDetailEventIcon = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF43F5E), Color(0xFFA855F7)],
  );
  /// Gift Ideas Detail: Find Near You button (rose-500 -> pink-500 -> purple-500)
  static const LinearGradient giftIdeasDetailFindNearYou = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE11D48), Color(0xFFEC4899), Color(0xFFA855F7)],
    stops: [0.0, 0.5, 1.0],
  );
  /// Gift Ideas Detail: Regenerate All button (purple-500 -> pink-500 -> rose-500)
  static const LinearGradient giftIdeasDetailRegenerateAll = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFFE11D48)],
    stops: [0.0, 0.5, 1.0],
  );
  /// All Upcoming Events: sort selected + View Gift Ideas button
  static const LinearGradient eventsSortSelected = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
  );
  static const LinearGradient eventsViewGiftBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFEC4899), Color(0xFFA855F7)],
  );
  /// Old Messages: selected chip (pink -> purple)
  static const LinearGradient oldMessagesChipSelected = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFF43F5E), Color(0xFFA855F7)],
  );
  /// Loved One Details: header (rose-400 -> pink-400, React bg-gradient-to-br)
  static const LinearGradient lovedOneDetailsHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.lovedOneDetailsHeaderStart,
      AppColors.lovedOneDetailsHeaderEnd,
    ],
  );
  /// Loved One Details: View Gift Ideas + View Subscription Plans (rose-500 -> pink-500 -> purple-500)
  static const LinearGradient lovedOneDetailsCtaBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFE11D48),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Loved One Details: premium card crown bubble (purple-400 -> pink-500)
  static const LinearGradient lovedOneDetailsPremiumCrown = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.lovedOneDetailsPremiumCrownBgStart,
      AppColors.lovedOneDetailsPremiumCrownBgEnd,
    ],
  );
  /// Loved One Details: premium card background (purple-50 -> pink-50 -> rose-50)
  static const LinearGradient lovedOneDetailsPremiumCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.lovedOneDetailsPremiumCardBgStart,
      AppColors.lovedOneDetailsPremiumCardBgMid,
      AppColors.lovedOneDetailsPremiumCardBgEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Loved One Details: secondary goal row selected (rose-50 -> pink-50)
  static const LinearGradient lovedOneDetailsSecondaryRowSelected = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.lovedOneDetailsSecondaryRowSelectedBgStart,
      AppColors.lovedOneDetailsSecondaryRowSelectedBgEnd,
    ],
  );
  /// Business Information: page background
  static const LinearGradient businessInfoPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.businessInfoPageBgStart,
      AppColors.businessInfoPageBgEnd,
    ],
  );
  /// Business Information: header badge, View Plans button
  static const LinearGradient businessInfoBadge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessInfoBadgeStart,
      AppColors.businessInfoBadgeEnd,
    ],
  );
  /// Business Information: Continue CTA (rose -> pink -> purple)
  static const LinearGradient businessInfoCta = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFF43F5E),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Business Information: delivery card selected
  static const LinearGradient businessInfoDeliveryCardSelected = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessInfoDeliveryCardSelectedBgStart,
      AppColors.businessInfoDeliveryCardSelectedBgEnd,
    ],
  );
  /// Business Information: price badge
  static const LinearGradient businessInfoPriceBadge = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessInfoPriceBadgeBgStart,
      AppColors.businessInfoPriceBadgeBgEnd,
    ],
  );
  /// Business Information: upload icon circle
  static const LinearGradient businessInfoUploadIconBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessInfoUploadIconBgStart,
      AppColors.businessInfoUploadIconBgEnd,
    ],
  );
  /// Business Information: upgrade card
  static const LinearGradient businessInfoUpgradeCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessInfoUpgradeCardBgStart,
      AppColors.businessInfoUpgradeCardBgEnd,
    ],
  );
  /// Business Information: View Plans button
  static const LinearGradient businessInfoViewPlansBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.businessInfoViewPlansBtnStart,
      AppColors.businessInfoViewPlansBtnEnd,
    ],
  );
  /// Business Information: slider thumb
  static const LinearGradient businessInfoSliderThumb = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessInfoSliderThumbStart,
      AppColors.businessInfoSliderThumbEnd,
    ],
  );

  /// Business Dashboard: header (purple-400 -> purple-500 -> indigo-500, bg-gradient-to-br)
  static const LinearGradient businessDashboardHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.searchHeaderStart,
      AppColors.searchHeaderMid,
      AppColors.searchHeaderEnd,
    ],
    stops: [0.0, 0.5, 1.0],
  );
  /// Business Dashboard: page background (from-purple-50/30 to white)
  static const LinearGradient businessDashboardPageBg = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.businessDashboardPageBgStart,
      AppColors.businessDashboardPageBgEnd,
    ],
  );
  /// Business Dashboard: Add Product button (from-purple-400 to-indigo-400)
  static const LinearGradient businessDashboardAddProductBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFA78BFA), Color(0xFF6366F1)],
  );
  /// Business Dashboard: Upgrade card background (rose-100/50 to pink-100/50)
  static const LinearGradient businessDashboardUpgradeCardBg = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessDashboardUpgradeCardBgStart,
      AppColors.businessDashboardUpgradeCardBgEnd,
    ],
  );
  /// Business Dashboard: crown icon bubble (amber-400 to orange-400)
  static const LinearGradient businessDashboardCrownBubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.businessDashboardCrownBgStart,
      AppColors.businessDashboardCrownBgEnd,
    ],
  );
  /// Business Dashboard: View Plans button (rose-500 -> pink-500 -> purple-500)
  static const LinearGradient businessDashboardViewPlansBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFFF43F5E),
      Color(0xFFEC4899),
      Color(0xFFA855F7),
    ],
    stops: [0.0, 0.5, 1.0],
  );
}
