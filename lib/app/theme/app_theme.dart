// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryPink,
        secondary: AppColors.primaryPurple,
        surface: AppColors.splashBgStart,
        error: const Color(0xFFB00020),
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.splashBgStart,
      fontFamily: 'system-ui', // platform default; can replace with actual font
      textTheme: const TextTheme(
        bodyLarge: AppTextStyles.splashSubheadline,
        bodyMedium: AppTextStyles.splashFeatureBody,
        titleLarge: AppTextStyles.splashHeadline,
        titleMedium: AppTextStyles.splashFeatureTitle,
        titleSmall: AppTextStyles.splashTrustTitle,
        labelLarge: AppTextStyles.splashCta,
      ),
    );
  }
}
