// lib/presentation/subscription/widgets/unsubscribe_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/manage_subscription_controller.dart';

/// React: rounded-3xl (24), p-8 (32). Option cards: p-4 rounded-2xl (16), border-2, icon w-10 h-10 (40). space-y-3 (12). mb-6 (24).
const double _kDialogRadius = 24;
const double _kDialogPadding = 32;
const double _kIconBubbleSize = 64;
const double _kIconSize = 32;
const double _kIconMb = 16;
const double _kTitleMb = 8;
const double _kOptionsSpacing = 12;
const double _kOptionsMb = 24;
const double _kCardRadius = 16;
const double _kCardPadding = 16;
const double _kCardIconSize = 40;
const double _kCardIconIconSize = 20;
const double _kCardGap = 12;
const double _kCancelBtnRadius = 16;
const double _kCancelBtnPaddingV = 12;
const double _kCancelBtnPaddingH = 24;

class UnsubscribeDialog extends StatelessWidget {
  const UnsubscribeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ManageSubscriptionController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 448),
        decoration: BoxDecoration(
          color: AppColors.beforeYouGoDialogBg,
          borderRadius: BorderRadius.circular(_kDialogRadius),
          boxShadow: AppShadows.beforeYouGoDialog,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(_kDialogPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: _kIconBubbleSize,
                  height: _kIconBubbleSize,
                  decoration: BoxDecoration(
                    color: AppColors.beforeYouGoIconBubbleBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.beforeYouGoIconBubbleIcon.withOpacity(0.4), width: 1),
                  ),
                  child: Icon(Icons.warning_amber_rounded, size: _kIconSize, color: AppColors.beforeYouGoIconBubbleIcon),
                ),
                SizedBox(height: _kIconMb),
                Text(
                  'Before you go...',
                  style: AppTextStyles.beforeYouGoTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: _kTitleMb),
                Text(
                  "We'd love to help! Here are some options that might work better for you:",
                  style: AppTextStyles.beforeYouGoSubtitle,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: _kOptionsMb),
                _buildOptionCard(
                  backgroundColor: AppColors.beforeYouGoCardPauseBg,
                  borderColor: AppColors.beforeYouGoCardPauseBorder,
                  iconBg: AppColors.beforeYouGoCardPauseIconBg,
                  icon: Icons.pause_circle_filled,
                  title: 'Pause my subscription',
                  subtitle: 'Take a break for up to 3 months, keep your data safe',
                  onTap: c.onPauseSubscription,
                ),
                SizedBox(height: _kOptionsSpacing),
                _buildOptionCard(
                  backgroundColor: AppColors.beforeYouGoCardLowerBg,
                  borderColor: AppColors.beforeYouGoCardLowerBorder,
                  iconBg: AppColors.beforeYouGoCardLowerIconBg,
                  icon: Icons.keyboard_arrow_down,
                  title: 'Switch to a lower plan',
                  subtitle: 'Save money while keeping essential features',
                  onTap: c.onSwitchToLowerPlan,
                ),
                SizedBox(height: _kOptionsMb),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.onConfirmCancel,
                    borderRadius: BorderRadius.circular(_kCancelBtnRadius),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: _kCancelBtnPaddingV, horizontal: _kCancelBtnPaddingH),
                      decoration: BoxDecoration(
                        color: AppColors.beforeYouGoCancelBtnBg,
                        borderRadius: BorderRadius.circular(_kCancelBtnRadius),
                      ),
                      alignment: Alignment.center,
                      child: Text('I still want to cancel', style: AppTextStyles.beforeYouGoCancelBtn),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.onKeepSubscription,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: Text('Keep my subscription', style: AppTextStyles.beforeYouGoKeepLink)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required Color backgroundColor,
    required Color borderColor,
    required Color iconBg,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _kCardIconSize,
                height: _kCardIconSize,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, size: _kCardIconIconSize, color: Colors.white),
              ),
              SizedBox(width: _kCardGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: AppTextStyles.beforeYouGoCardTitle),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.beforeYouGoCardSubtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
