// lib/presentation/subscription_manage/views/before_you_go_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/manage_subscription_controller.dart';

const double _kDialogRadius = 24;
const double _kDialogPadding = 24;
const double _kIconBubbleSize = 56;
const double _kIconSize = 28;
const double _kTitleSubtitleGap = 8;
const double _kCardRadius = 16;
const double _kCardPadding = 16;
const double _kCardBubbleSize = 44;
const double _kCardBubbleIconSize = 22;
const double _kCancelBtnHeight = 48;
const double _kCancelBtnRadius = 12;
const double _kKeepLinkPadding = 16;
const double _kMaxDialogWidth = 400;

class BeforeYouGoDialog extends StatelessWidget {
  const BeforeYouGoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ManageSubscriptionController>();
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxDialogWidth),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: AppColors.beforeYouGoDialogBg,
              borderRadius: BorderRadius.circular(_kDialogRadius),
              boxShadow: AppShadows.beforeYouGoDialog,
            ),
            clipBehavior: Clip.antiAlias,
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
                      ),
                      child: Icon(Icons.info_outline, size: _kIconSize, color: AppColors.beforeYouGoIconBubbleIcon),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Before you go...',
                      style: AppTextStyles.beforeYouGoTitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: _kTitleSubtitleGap),
                    Text(
                      "We'd love to help! Here are some options that might work better for you:",
                      style: AppTextStyles.beforeYouGoSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _buildOptionCard(
                      context: context,
                      backgroundColor: AppColors.beforeYouGoCardPauseBg,
                      borderColor: AppColors.beforeYouGoCardPauseBorder,
                      iconBg: AppColors.beforeYouGoCardPauseIconBg,
                      icon: Icons.pause_circle_filled,
                      title: 'Pause my subscription',
                      subtitle: 'Take a break for up to 3 months, keep your data safe',
                      onTap: c.onPauseSubscription,
                    ),
                    const SizedBox(height: 12),
                    _buildOptionCard(
                      context: context,
                      backgroundColor: AppColors.beforeYouGoCardLowerBg,
                      borderColor: AppColors.beforeYouGoCardLowerBorder,
                      iconBg: AppColors.beforeYouGoCardLowerIconBg,
                      icon: Icons.keyboard_arrow_down,
                      title: 'Switch to a lower plan',
                      subtitle: 'Save money while keeping essential features',
                      onTap: c.onSwitchToLowerPlan,
                    ),
                    const SizedBox(height: 24),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: c.onConfirmCancel,
                        borderRadius: BorderRadius.circular(_kCancelBtnRadius),
                        child: Container(
                          height: _kCancelBtnHeight,
                          width: double.infinity,
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
                          padding: const EdgeInsets.symmetric(vertical: _kKeepLinkPadding),
                          child: Center(
                            child: Text('Keep my subscription', style: AppTextStyles.beforeYouGoKeepLink),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
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
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            children: [
              Container(
                width: _kCardBubbleSize,
                height: _kCardBubbleSize,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: _kCardBubbleIconSize, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.beforeYouGoCardTitle),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTextStyles.beforeYouGoCardSubtitle),
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
