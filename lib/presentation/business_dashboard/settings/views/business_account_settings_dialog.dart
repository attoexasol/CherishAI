// lib/presentation/business_dashboard/settings/views/business_account_settings_dialog.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_gradients.dart';
import '../../../../../app/theme/app_shadows.dart';
import '../controllers/business_account_settings_controller.dart';

const double _kDialogRadius = 24;
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 24;
const double _kCloseBtnSize = 40;
const double _kCloseIconSize = 20;
const double _kBodyPadding = 24;
const double _kRowSpacing = 12;
const double _kRowPadding = 16;
const double _kRowRadius = 16;
const double _kBubbleSize = 48;
const double _kRowGap = 16;
const double _kTitleSubtitleGap = 4;
const double _kChevronSize = 20;
const double _kMaxDialogWidth = 448;
const double _kBarrierOpacity = 0.5;
const double _kBlurSigma = 2;

class BusinessAccountSettingsDialog extends StatelessWidget {
  const BusinessAccountSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessAccountSettingsController>();
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: c.closeDialog,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _kBlurSigma, sigmaY: _kBlurSigma),
              child: Container(
                color: Color(0xFF000000).withValues(alpha: _kBarrierOpacity),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > _kMaxDialogWidth + 48 ? 24 : 24),
            child: Material(
              color: Colors.transparent,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: _kMaxDialogWidth),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.accountSettingsDialogBg,
                    borderRadius: BorderRadius.circular(_kDialogRadius),
                    boxShadow: AppShadows.accountSettingsDialog,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(context, c),
                      _buildBody(context, c),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, BusinessAccountSettingsController c) {
    return Container(
      padding: EdgeInsets.fromLTRB(_kHeaderPaddingH, _kHeaderPaddingV, _kHeaderPaddingH, _kHeaderPaddingV),
      decoration: const BoxDecoration(
        gradient: AppGradients.accountSettingsHeader,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings', style: AppTextStyles.accountSettingsTitle),
                SizedBox(height: _kTitleSubtitleGap),
                Text('Manage your account preferences', style: AppTextStyles.accountSettingsSubtitle),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.closeDialog,
              borderRadius: BorderRadius.circular(_kCloseBtnSize / 2),
              child: Container(
                width: _kCloseBtnSize,
                height: _kCloseBtnSize,
                decoration: BoxDecoration(
                  color: AppColors.accountSettingsCloseBtnBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.close, size: _kCloseIconSize, color: AppColors.accountSettingsTitle),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, BusinessAccountSettingsController c) {
    return Padding(
      padding: const EdgeInsets.all(_kBodyPadding),
      child: Column(
        children: [
          _buildRow(
            context,
            c,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)],
            ),
            borderColor: const Color(0xFFE9D5FF),
            bubbleGradient: AppGradients.accountSettingsRow1Bubble,
            icon: Icons.credit_card_outlined,
            title: 'Manage Subscription',
            subtitle: 'Change plan',
            chevronColor: AppColors.accountSettingsChevronPurple,
            onTap: c.onTapManageSubscription,
          ),
          SizedBox(height: _kRowSpacing),
          _buildRow(
            context,
            c,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEFF6FF), Color(0xFFECFEFF)],
            ),
            borderColor: const Color(0xFFBFDBFE),
            bubbleGradient: AppGradients.accountSettingsRow2Bubble,
            icon: Icons.person_outline_rounded,
            title: 'User Profile',
            subtitle: 'Edit info or delete account',
            chevronColor: AppColors.accountSettingsChevronBlue,
            onTap: c.onTapUserProfile,
          ),
          SizedBox(height: _kRowSpacing),
          _buildRow(
            context,
            c,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFECFDF5), Color(0xFFD1FAE5)],
            ),
            borderColor: const Color(0xFFA7F3D0),
            bubbleGradient: AppGradients.accountSettingsRow3Bubble,
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Help & Feedback',
            subtitle: 'Share your thoughts with us',
            chevronColor: AppColors.accountSettingsChevronGreen,
            onTap: c.onTapHelpFeedback,
          ),
          SizedBox(height: _kRowSpacing),
          _buildRow(
            context,
            c,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF9FAFB), Color(0xFFF1F5F9)],
            ),
            borderColor: const Color(0xFFE5E7EB),
            bubbleGradient: AppGradients.accountSettingsRow4Bubble,
            icon: Icons.logout_rounded,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            chevronColor: AppColors.accountSettingsChevronGray,
            onTap: c.onTapLogout,
          ),
        ],
      ),
    );
  }

  Widget _buildRow(
    BuildContext context,
    BusinessAccountSettingsController c, {
    required LinearGradient gradient,
    required Color borderColor,
    required LinearGradient bubbleGradient,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color chevronColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kRowRadius),
        child: Container(
          padding: const EdgeInsets.all(_kRowPadding),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(_kRowRadius),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: _kBubbleSize,
                height: _kBubbleSize,
                decoration: BoxDecoration(
                  gradient: bubbleGradient,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 24, color: Colors.white),
              ),
              SizedBox(width: _kRowGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.accountSettingsRowTitle),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.accountSettingsRowSubtitle),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, size: _kChevronSize, color: chevronColor),
            ],
          ),
        ),
      ),
    );
  }
}
