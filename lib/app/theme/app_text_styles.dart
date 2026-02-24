// lib/app/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography tokens. line-height as ratio = lineHeightPx / fontSizePx.
abstract class AppTextStyles {
  // Brand name: clamp(42px, 10vw, 56px), font-black, letterSpacing -2, lineHeight 1
  static TextStyle splashBrand(double fontSize) => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        height: 1.0,
        letterSpacing: -2,
        color: Colors.transparent,
        decoration: TextDecoration.none,
      );

  // Badge: font-bold text-sm tracking-widest -> 14px, weight 700, letterSpacing ~0.1em = 1.4px
  static const TextStyle splashBadge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.4,
    color: AppColors.pinkDark,
  );

  // Headline: text-3xl (30px) font-bold, color #4A1942, leading-tight (1.25)
  static const TextStyle splashHeadline = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  // Subheadline: text-lg (18px), color #6B2C4D, leading-relaxed (1.625)
  static const TextStyle splashSubheadline = TextStyle(
    fontSize: 18,
    height: 1.625,
    color: AppColors.textSecondary,
  );

  // Stats value: text-2xl (24px) font-black
  static const TextStyle splashStatValue = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  // Stats label: text-xs (12px) font-semibold
  static const TextStyle splashStatLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // Scroll hint: text-xs font-semibold tracking-wide
  static const TextStyle splashScrollHint = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textMuted,
  );

  // Section title: text-3xl font-black
  static const TextStyle splashSectionTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  // Section subtitle: text-base (16px)
  static const TextStyle splashSectionSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  // Feature card title: text-2xl (24px) font-bold
  static const TextStyle splashFeatureTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Feature card body: text-base leading-relaxed
  static const TextStyle splashFeatureBody = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  // Trust section title: text-xl (20px) font-bold
  static const TextStyle splashTrustTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // Trust item label: text-xs font-bold leading-tight
  static const TextStyle splashTrustLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.textSecondary,
  );

  // CTA button: font-black text-xl (20px)
  static const TextStyle splashCta = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
  );

  // CTA footnote: text-sm font-medium
  static const TextStyle splashCtaFootnote = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );

  // --- Onboarding Intro (HeroBannerDemo) ---
  // Headline: 24px, semibold, #7A3E55, line-height 1.4
  static const TextStyle onboardingHeadline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onboardingHeadline,
  );
  // Bullet label: 17px, medium, #A84968, height 1.5
  static const TextStyle onboardingBullet = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.onboardingBulletText,
  );
  // "Not another relationship coach": 20px, #7A3E55, height 1.3
  static const TextStyle onboardingNotCoach = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.onboardingHeadline,
  );
  // "is your personal love assistant": 22px, #8B4A65, height 1.5
  static const TextStyle onboardingTagline = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.onboardingSubtext,
  );
  // Info pill: 19px, semibold, #7A3E55, height 1.6
  static const TextStyle onboardingInfoPill = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: AppColors.onboardingHeadline,
  );
  // HOW IT WORKS: 42px, bold italic, #7A3E55, height 1.2
  static const TextStyle onboardingHowItWorks = TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    height: 1.2,
    color: AppColors.onboardingHeadline,
  );
  // Step number circle: 18px bold #A84968
  static const TextStyle onboardingStepNum = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.onboardingBulletText,
  );
  // Step text: 16px, medium, #7A3E55, height 1.5
  static const TextStyle onboardingStepText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.onboardingHeadline,
  );
  // "That's all...": 18px medium italic #B05A78
  static const TextStyle onboardingThatsAll = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    color: AppColors.onboardingThatsAll,
  );
  // "CherishAI does the heavy lifting": 22px bold #7A3E55, height 1.3
  static const TextStyle onboardingHeavyLiftTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.onboardingHeadline,
  );
  // Heavy lift subtitle: 15px w600 #8B4A65, height 1.6
  static const TextStyle onboardingHeavyLiftSubtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: AppColors.onboardingSubtext,
  );
  // Heavy lift bullet: 15px w600 #7A3E55, height 1.5
  static const TextStyle onboardingHeavyLiftBullet = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.onboardingHeadline,
  );
  // Value prop "100% personal love...": 22px bold, gradient (use with ShaderMask)
  static const TextStyle onboardingValueProp = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.5,
  );
  // Business title: 28px bold #7A3E55, height 1.4
  static const TextStyle onboardingBusinessTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.onboardingHeadline,
  );
  // Business paragraph: 19px medium #8B4A65, height 1.8
  static const TextStyle onboardingBusinessBody = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    height: 1.8,
    color: AppColors.onboardingSubtext,
  );
  // Business footer: 17px semibold italic #A84968
  static const TextStyle onboardingBusinessFooter = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
    color: AppColors.onboardingBulletText,
  );
  // Continue button: 22px semibold white
  static const TextStyle onboardingContinue = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  // Language menu title: 16px semibold #7A3E55
  static const TextStyle onboardingLangMenuTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onboardingHeadline,
  );
  // Language option: 15px medium
  static const TextStyle onboardingLangOption = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.onboardingHeadline,
  );

  // --- Auth (Sign Up / Login) ---
  static const TextStyle authWelcomeTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.authWelcomeTitle,
  );
  static const TextStyle authSubtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.authSubtitle,
  );
  static const TextStyle authTabActive = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const TextStyle authTabInactive = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.authTabInactiveText,
  );
  static const TextStyle authSocialButton = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.authSocialButtonText,
  );
  static const TextStyle authDivider = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.authDividerText,
  );
  static const TextStyle authInput = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.authSocialButtonText,
  );
  static const TextStyle authCtaButton = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const TextStyle authFooter = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.authFooterText,
  );
  static const TextStyle authError = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.authErrorText,
  );

  // --- User Type ---
  static const TextStyle userTypeTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.userTypeTitle,
  );
  static const TextStyle userTypeTitleAccent = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.userTypeTitleAccent,
  );
  static const TextStyle userTypeSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.userTypeSubtitle,
  );
  static const TextStyle userTypeCardTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.userTypeCardTitle,
  );
  static const TextStyle userTypeCardDesc = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.userTypeCardDesc,
  );

  // --- Individual Profile Step 1 ---
  static const TextStyle profileStep1StepPill = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStep1StepPillText,
  );
  static const TextStyle profileStep1Title = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.profileStep1Title,
  );
  static const TextStyle profileStep1Subtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.profileStep1Subtitle,
  );
  static const TextStyle profileStep1SectionLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStep1Label,
  );
  static const TextStyle profileStep1CardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.profileStep1CardLabel,
  );
  static const TextStyle profileStep1Helper = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.profileStep1Helper,
  );
  static const TextStyle profileStep1Input = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStep1CardLabel,
  );
  static const TextStyle profileStep1InputPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStep1InputPlaceholder,
  );
  static const TextStyle profileStep1Chip = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.profileStep1ChipText,
  );
  static const TextStyle profileStep1ChipSelected = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static const TextStyle profileStep1AddPhoto = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStep1PhotoIcon,
  );
  static const TextStyle profileStep1Cta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const TextStyle profileStep1RequiredHint = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStep1RequiredHint,
  );

  // --- Individual Step 2 (Add a loved one) ---
  static const TextStyle lovedOneTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.lovedOneTitle,
  );
  static const TextStyle lovedOneSubtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.lovedOneSubtitle,
  );
  static const TextStyle lovedOnePhotoLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.lovedOnePhotoLabel,
  );
  static const TextStyle lovedOneCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.lovedOneCardLabel,
  );
  static const TextStyle lovedOneInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.lovedOneCardLabel,
  );
  static const TextStyle lovedOneInputPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.lovedOneInputPlaceholder,
  );
  static const TextStyle lovedOneTileLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: AppColors.lovedOneTileText,
  );
  static const TextStyle lovedOneCta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  // --- Individual Step 3 (Your relationship goals) ---
  static const TextStyle goalsTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.goalsTitle,
  );
  static const TextStyle goalsDescription = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.goalsDescription,
  );
  static const TextStyle goalsSectionLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.goalsSectionLabel,
  );
  static const TextStyle goalsCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.goalsCardTitle,
  );
  static const TextStyle goalsCardSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.goalsCardSubtitle,
  );
  static const TextStyle goalsSaveButton = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.goalsSaveEnabledText,
  );
  static const TextStyle goalsSaveDisabled = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.goalsSaveDisabledText,
  );
  static const TextStyle goalsFooter = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.goalsFooterText,
  );

  // --- Individual Step 4 (Secondary goals) ---
  static const TextStyle secGoalsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.secGoalsTitle,
  );
  static const TextStyle secGoalsTitleOptional = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.secGoalsTitle,
  );
  static const TextStyle secGoalsSubtitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.secGoalsSubtitle,
  );
  static const TextStyle secGoalsDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.secGoalsDescription,
  );
  static const TextStyle secGoalsPill = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.secGoalsPillText,
  );
  static const TextStyle secGoalsSectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: AppColors.secGoalsSectionTitle,
  );
  static const TextStyle secGoalsOptionText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.secGoalsOptionText,
  );
  static const TextStyle secGoalsCta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const TextStyle secGoalsCtaDisabled = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.secGoalsCtaDisabledText,
  );
  static const TextStyle secGoalsSkipLink = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.secGoalsSkipLink,
  );

  // --- Loved One Preferences ---
  static const TextStyle prefsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.prefsTitle,
  );
  static const TextStyle prefsSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.prefsSubtitle,
  );
  static const TextStyle prefsOptionalPill = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.prefsOptionalPillText,
  );
  static const TextStyle prefsSectionTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.prefsSectionTitle,
  );
  static const TextStyle prefsSectionDesc = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.prefsSectionDesc,
  );
  static const TextStyle prefsAddButton = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.prefsAddButtonText,
  );
  /// Prefs modal dialogs: title inside dialog
  static const TextStyle prefsDialogTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.prefsTitle,
  );
  /// Prefs modal dialogs: primary button (Add Occasion / Add Hobby)
  static const TextStyle prefsDialogPrimaryBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  /// Prefs modal dialogs: cancel button
  static const TextStyle prefsDialogCancelBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.prefsDialogCancelText,
  );
  /// Prefs modal dialogs: input text and placeholder
  static const TextStyle prefsDialogInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.prefsTitle,
  );
  static const TextStyle prefsDialogInputPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.prefsDialogPlaceholder,
  );
  static const TextStyle prefsCategoryTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.prefsSectionTitle,
  );
  static const TextStyle prefsChip = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.prefsChipText,
  );
  static const TextStyle prefsChipSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.prefsChipSelectedBorder,
  );
  static const TextStyle prefsCta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  // --- Dislikes screen ---
  static const TextStyle dislikesBack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.dislikesBackText,
  );
  static const TextStyle dislikesFinalPill = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.dislikesFinalPillText,
  );
  static const TextStyle dislikesTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.5,
    color: AppColors.dislikesTitle,
  );
  static const TextStyle dislikesDesc = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.dislikesDesc,
  );
  static const TextStyle dislikesOptional = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.dislikesOptional,
  );
  static const TextStyle dislikesCategoryTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.dislikesCategoryTitle,
  );
  static const TextStyle dislikesChip = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.dislikesChipText,
  );
  static const TextStyle dislikesChipSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.dislikesChipSelectedBorder,
  );
  static const TextStyle dislikesCta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static const TextStyle dislikesHelper = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.dislikesHelperText,
  );
  static const TextStyle dislikesAddButton = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.dislikesAddButtonText,
  );

  // --- Personal Note ---
  static const TextStyle noteBack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.noteBackText,
  );
  static const TextStyle noteLogo = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.noteLogoText,
  );
  static const TextStyle noteSkip = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.noteSkipText,
  );
  static const TextStyle noteStepLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.noteStepLabel,
  );
  static const TextStyle noteTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.noteTitle,
  );
  static const TextStyle noteSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.noteSubtitle,
  );
  static const TextStyle noteLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.noteLabelText,
  );
  static const TextStyle noteInput = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.noteLabelText,
  );
  static const TextStyle noteInputPlaceholder = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.noteInputPlaceholder,
  );
  static const TextStyle noteCounter = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.noteCounter,
  );
  static const TextStyle noteHelper = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.noteHelperText,
  );
  static const TextStyle noteSeeMore = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.noteSeeMoreText,
  );
  static const TextStyle noteCta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.noteCtaText,
  );

  // --- Subscription (Choose your plan) ---
  static const TextStyle subBack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.subBackText,
  );
  static const TextStyle subTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.subTitle,
  );
  static const TextStyle subSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.subSubtitle,
  );
  static const TextStyle subActiveLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.subActiveLabel,
  );
  static const TextStyle subActivePlanName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.subActivePlanName,
  );
  static const TextStyle subActiveRenewal = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subActiveRenewal,
  );
  static const TextStyle subCurrentBadge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.subCurrentBadgeText,
  );
  static const TextStyle subCancelLink = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subCancelLink,
  );
  static const TextStyle subPlanName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.subPlanName,
  );
  static const TextStyle subPlanSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subPlanSubtitle,
  );
  static const TextStyle subPriceMain = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.subPriceMain,
  );
  static const TextStyle subPricePeriod = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subPricePeriod,
  );
  static const TextStyle subSectionLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.subSectionLabel,
  );
  static const TextStyle subIncludeItem = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.subIncludeText,
  );
  static const TextStyle subIncludeDetail = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.subIncludeDetail,
  );
  static const TextStyle subBestFor = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.subBestFor,
  );
  static const TextStyle subCta = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.subCtaText,
  );
  static const TextStyle subRecPill = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.subRecPillText,
  );

  // --- Checkout ---
  static const TextStyle checkoutBack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.checkoutBackText,
  );
  static const TextStyle checkoutSecure = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.checkoutSecureText,
  );
  static const TextStyle checkoutTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.checkoutTitle,
  );
  static const TextStyle checkoutSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutSubtitle,
  );
  static const TextStyle checkoutSectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.checkoutSectionTitle,
  );
  static const TextStyle checkoutInput = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutSectionTitle,
  );
  static const TextStyle checkoutInputPlaceholder = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutInputPlaceholder,
  );
  static const TextStyle checkoutPaymentLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.checkoutPaymentTileUnselectedText,
  );
  static const TextStyle checkoutPaymentLabelSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.checkoutPaymentTileSelectedText,
  );
  static const TextStyle checkoutSecurityTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.checkoutSecurityBoxTitle,
  );
  static const TextStyle checkoutSecurityDesc = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutSecurityBoxDesc,
  );
  static const TextStyle checkoutOrderPlanName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.checkoutOrderPlanName,
  );
  static const TextStyle checkoutOrderPrice = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.subPriceMain,
  );
  static const TextStyle checkoutOrderPricePeriod = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutOrderPricePeriod,
  );
  static const TextStyle checkoutLineItem = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.checkoutOrderPlanName,
  );
  static const TextStyle checkoutDueTodayLabel = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.checkoutDueTodayLabel,
  );
  static const TextStyle checkoutDisclaimer = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutDisclaimerText,
  );
  static const TextStyle checkoutCta = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.checkoutCtaText,
  );
  static const TextStyle checkoutFooter = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.checkoutFooterText,
  );

  // --- Home (Individual Home Dashboard) ---
  static const TextStyle homeGreetingTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.homeGreetingTitle,
  );
  static const TextStyle homeGreetingSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.homeGreetingSubtitle,
  );
  static const TextStyle homePill = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.homePillText,
  );
  static const TextStyle homeSectionTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.homeSectionTitle,
  );
  static const TextStyle homeSectionSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.homeSectionSubtitle,
  );
  static const TextStyle homeSwipeHint = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.homeSwipeHint,
  );
  static const TextStyle homeMessageCardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.homeSectionTitle,
  );
  static const TextStyle homeMessageCardRelation = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.homeSectionSubtitle,
  );
  static const TextStyle homeMessageLink = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.homeSwipeHint,
  );
  static const TextStyle homeMessageBody = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: AppColors.homeSectionTitle,
  );
  static const TextStyle homePrevNext = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.homePrevNextText,
  );
  static const TextStyle homeRegenerateBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle homeLikeDislike = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.homeSectionSubtitle,
  );
  static const TextStyle homeEventTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.homeSectionTitle,
  );
  static const TextStyle homeEventDate = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.homeSectionSubtitle,
  );
  static const TextStyle homeEventDays = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.homeEventDaysText,
  );
  static const TextStyle homeUrgentBadge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static const TextStyle homeGiftIdeasBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle homeInspirationQuote = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    height: 1.5,
    color: AppColors.homeSectionTitle,
  );
  static const TextStyle homeInspirationAuthor = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.homeSectionSubtitle,
  );
  static const TextStyle homeInspirationLikeShare = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.homeInspirationLikeInactive,
  );
  static const TextStyle homeBottomNavLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.homeBottomNavActiveText,
  );
  static const TextStyle homeBottomNavLabelInactive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.homeBottomNavInactiveText,
  );

  // --- Notifications list ---
  static const TextStyle notifBack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.notifBackText,
  );
  static const TextStyle notifMarkAllRead = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle notifTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );
  static const TextStyle notifSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.notifSubtitle,
  );
  static const TextStyle notifTab = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle notifCardTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.notifCardTitle,
  );
  static const TextStyle notifCardTime = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.notifCardTime,
  );
  static const TextStyle notifCardBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.notifCardBody,
  );
  static const TextStyle notifTagPill = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.notifTagPillText,
  );
  static const TextStyle notifMarkReadBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle notifDeleteBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.notifDeleteBtnText,
  );
  static const TextStyle notifEmptyTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.notifEmptyTitle,
  );
  static const TextStyle notifEmptyBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.notifEmptyBody,
  );

  // --- Profile (User Profile view/edit) ---
  static const TextStyle profileTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.profileTitleText,
  );
  static const TextStyle profileUsername = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.profileUsernameText,
  );
  static const TextStyle profileMembership = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    color: AppColors.profileMembershipText,
  );
  static const TextStyle profileStatLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.profileStatLabel,
  );
  static const TextStyle profileStatCount = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.profileStatCount,
  );
  static const TextStyle profileStatDelta = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.profileStatDelta,
  );
  static const TextStyle profileInfoSectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.profileInfoTitle,
  );
  static const TextStyle profileInfoRowLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.profileInfoLabel,
  );
  static const TextStyle profileInfoRowValue = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.profileInfoValue,
  );
  static const TextStyle profileFormLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.profileInfoLabel,
  );
  static const TextStyle profileFormInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.profileInfoValue,
  );
  static const TextStyle profileFormPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.profileInputPlaceholder,
  );
  static const TextStyle profileSaveBtn = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle profileManageSubBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.profileManageSubText,
  );
  static const TextStyle profileLogoutBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.profileLogoutText,
  );

  // --- Search (Individual Search screen) ---
  static const TextStyle searchTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.searchTitleText,
  );
  static const TextStyle searchBarInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.searchBarText,
  );
  static const TextStyle searchBarPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.searchBarPlaceholder,
  );
  static const TextStyle searchSectionTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.searchSectionTitle,
  );
  static const TextStyle searchQuickTileLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.searchQuickTileLabel,
  );
  static const TextStyle searchTrendingTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.searchTrendingTitle,
  );
  static const TextStyle searchTrendingSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.searchTrendingSubtitle,
  );
  static const TextStyle searchRecentChip = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.searchRecentChipText,
  );
  // --- Loved Ones list screen ---
  static const TextStyle lovedOnesTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.lovedOnesTitle,
  );
  static const TextStyle lovedOnesSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.lovedOnesSubtitle,
  );
  static const TextStyle lovedOnesAddLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lovedOnesAddLabel,
  );
  static const TextStyle lovedOnesCardName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.lovedOnesName,
  );
  static const TextStyle lovedOnesCardRelationship = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.lovedOnesRelationship,
  );
  // --- Account Settings modal ---
  static const TextStyle accountSettingsTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: AppColors.accountSettingsTitle,
  );
  static const TextStyle accountSettingsSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.accountSettingsSubtitle,
  );
  static const TextStyle accountSettingsRowTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    color: AppColors.accountSettingsRowTitle,
  );
  static const TextStyle accountSettingsRowSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.accountSettingsRowSubtitle,
  );
  // --- Manage Subscription screen ---
  static const TextStyle manageSubAppBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.manageSubAppBarTitle,
  );
  static const TextStyle manageSubCurrentPlanLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.manageSubCurrentPlanLabel,
  );
  static const TextStyle manageSubPlanName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.manageSubPlanName,
  );
  static const TextStyle manageSubUpgradeBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.manageSubUpgradeBtnText,
  );
  static const TextStyle manageSubUnsubscribeLink = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.manageSubUnsubscribeLink,
  );
  static const TextStyle manageSubChooseTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.manageSubChooseTitle,
  );
  static const TextStyle manageSubChooseSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.manageSubChooseSubtitle,
  );
  static const TextStyle manageSubBadge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.manageSubBadgeCurrentText,
  );
  static const TextStyle manageSubCtaDisabled = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.manageSubCtaDisabledText,
  );
  // --- Before you go dialog ---
  static const TextStyle beforeYouGoTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.beforeYouGoTitle,
  );
  static const TextStyle beforeYouGoSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.beforeYouGoSubtitle,
  );
  static const TextStyle beforeYouGoCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.beforeYouGoTitle,
  );
  static const TextStyle beforeYouGoCardSubtitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.beforeYouGoSubtitle,
  );
  static const TextStyle beforeYouGoCancelBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.beforeYouGoCancelBtnText,
  );
  static const TextStyle beforeYouGoKeepLink = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.beforeYouGoKeepLinkText,
  );
  // --- Help & Feedback ---
  static const TextStyle helpFeedbackTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.helpFeedbackTitle,
  );
  static const TextStyle helpFeedbackSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.helpFeedbackSubtitle,
  );
  static const TextStyle helpFeedbackSectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.helpFeedbackSectionTitle,
  );
  static const TextStyle helpFeedbackOptionText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.helpFeedbackOptionText,
  );
  static const TextStyle helpFeedbackPlaceholder = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.helpFeedbackPlaceholder,
  );
  static const TextStyle helpFeedbackCounter = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.helpFeedbackCounter,
  );
  static const TextStyle helpFeedbackCheckboxLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.helpFeedbackCheckboxLabel,
  );
  static const TextStyle helpFeedbackSubmit = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.manageSubUpgradeBtnText,
  );
  static const TextStyle helpFeedbackFooter = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.helpFeedbackFooterText,
  );
  // --- Gift Ideas screen ---
  static const TextStyle giftIdeasGreeting = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasGreeting,
  );
  static const TextStyle giftIdeasTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.giftIdeasTitle,
  );
  static const TextStyle giftIdeasSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasSubtitle,
  );
  static const TextStyle giftIdeasStatNumber = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasStatNumber,
  );
  static const TextStyle giftIdeasStatLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasStatLabel,
  );
  static const TextStyle giftIdeasViewAllBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasUrgentBadgeText,
  );
  static const TextStyle giftIdeasSectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasEventTitle,
  );
  static const TextStyle giftIdeasEventTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasEventTitle,
  );
  static const TextStyle giftIdeasEventDate = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasEventDate,
  );
  static const TextStyle giftIdeasCountdown = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasCountdownNormal,
  );
  static const TextStyle giftIdeasCountdownUrgent = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasCountdownUrgent,
  );
  static const TextStyle giftIdeasUrgentBadge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasUrgentBadgeText,
  );
  static const TextStyle giftIdeasViewGiftBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasUrgentBadgeText,
  );
  // --- Gift Ideas Detail (event-specific) ---
  static const TextStyle giftIdeasDetailAppBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasDetailTitle,
  );
  static const TextStyle giftIdeasDetailEventTitle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.giftIdeasDetailTitle,
  );
  static const TextStyle giftIdeasDetailCountdown = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailCountdownDays = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasDetailCountdownDays,
  );
  static const TextStyle giftIdeasDetailEventDesc = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailFilterLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailShowing = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailShowingCount = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasDetailShowingCount,
  );
  static const TextStyle giftIdeasDetailSectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasDetailTitle,
  );
  static const TextStyle giftIdeasDetailGiftTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasDetailTitle,
  );
  static const TextStyle giftIdeasDetailGiftDesc = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailPricePill = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailWhyPerfectTitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.giftIdeasDetailWhyPerfectTitle,
  );
  static const TextStyle giftIdeasDetailWhyPerfectBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailFindNearYouBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle giftIdeasDetailSecondaryBtn = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.giftIdeasDetailSecondaryBtnText,
  );
  static const TextStyle giftIdeasDetailTipText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasDetailFilterLabel,
  );
  static const TextStyle giftIdeasDetailTipBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.giftIdeasDetailTitle,
  );
  static const TextStyle giftIdeasDetailRegenerateTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static const TextStyle giftIdeasDetailRegenerateCaption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const TextStyle giftIdeasDetailViewHistoryTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.giftIdeasDetailTitle,
  );
  static const TextStyle giftIdeasDetailViewHistoryCaption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.giftIdeasDetailViewHistoryCaption,
  );
  // --- All Upcoming Events screen ---
  static const TextStyle eventsBackText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.eventsBackText,
  );
  static const TextStyle eventsTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.eventsTitle,
  );
  static const TextStyle eventsSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.eventsSubtitle,
  );
  static const TextStyle eventsSortLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.eventsSortLabel,
  );
  static const TextStyle eventsSortSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.eventsSortSelectedText,
  );
  static const TextStyle eventsSortUnselected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.eventsSortUnselectedText,
  );
  static const TextStyle eventsCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.eventsTitle,
  );
  static const TextStyle eventsCardRelationship = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.eventsRelationship,
  );
  static const TextStyle eventsCardDate = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.eventsSubtitle,
  );
  static const TextStyle eventsBadge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.eventsBadgeText,
  );
  static const TextStyle eventsCountdownPill = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.eventsCountdownPill,
  );
  static const TextStyle eventsViewGiftBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.eventsBadgeText,
  );
  static const TextStyle eventsStayPrepared = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.eventsStayPreparedText,
  );
  // --- Old Messages screen ---
  static const TextStyle oldMessagesBack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.oldMessagesBackIcon,
  );
  static const TextStyle oldMessagesTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.oldMessagesTitle,
  );
  static const TextStyle oldMessagesChipSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.oldMessagesChipSelectedText,
  );
  static const TextStyle oldMessagesChipUnselected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.oldMessagesChipUnselectedText,
  );
  static const TextStyle oldMessagesCardName = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.oldMessagesCardName,
  );
  static const TextStyle oldMessagesCardCount = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.oldMessagesCardCount,
  );

  // --- Edit Loved One / Edit Profile ---
  static const TextStyle editLovedOneTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.editLovedOneTitle,
  );
  static const TextStyle editLovedOneBack = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneBackText,
  );
  static const TextStyle editLovedOneSectionHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.editLovedOneTitle,
  );
  static const TextStyle editLovedOneLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneLabel,
  );
  static const TextStyle editLovedOneInput = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.editLovedOneTitle,
  );
  static const TextStyle editLovedOneInputPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.editLovedOnePlaceholder,
  );
  /// Dropdown selected/item text (e.g. Relationship). React: text-base/sm, single-line with ellipsis.
  static const TextStyle editLovedOneDropdownItem = TextStyle(
    fontSize: 14,
    height: 1.25,
    fontWeight: FontWeight.w400,
    color: AppColors.editLovedOneTitle,
  );
  static const TextStyle editLovedOnePhotoChange = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.editLovedOnePhotoChangeText,
  );
  static const TextStyle editLovedOneDashedBtn = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneDashedBtnText,
  );
  static const TextStyle editLovedOneInfoCardTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.editLovedOneInfoCardTitle,
  );
  static const TextStyle editLovedOneInfoCardBody = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.editLovedOneInfoCardBody,
  );
  static const TextStyle editLovedOneSecondaryPill = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneSecondaryPillText,
  );
  static const TextStyle editLovedOneSecondaryRowTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneTitle,
  );
  static const TextStyle editLovedOneSecondaryRowTitleSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneSecondaryRowText,
  );
  static const TextStyle editLovedOneSecondaryRowCategory = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.editLovedOnePlaceholder,
  );
  static const TextStyle editLovedOneCategoryTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.editLovedOneTitle,
  );
  static const TextStyle editLovedOneChip = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneLabel,
  );
  static const TextStyle editLovedOneChipSelected = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle editLovedOnePersonalNoteHint = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.editLovedOnePlaceholder,
  );
  static const TextStyle editLovedOneCounter = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOnePlaceholder,
  );
  static const TextStyle editLovedOneCounterWarning = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneRequiredAsterisk,
  );
  static const TextStyle editLovedOneCustomDislikeLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.editLovedOneLabel,
  );
  static const TextStyle editLovedOneAddCustomHint = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.editLovedOnePlaceholder,
  );
}
