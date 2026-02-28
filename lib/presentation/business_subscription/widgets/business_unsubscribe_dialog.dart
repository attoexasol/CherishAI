// lib/presentation/business_subscription/widgets/business_unsubscribe_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/business_manage_subscription_controller.dart';

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
const double _kBtnRadius = 16;
const double _kBtnPaddingV = 12;
const double _kBtnPaddingH = 24;

class BusinessUnsubscribeDialog extends StatelessWidget {
  const BusinessUnsubscribeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessManageSubscriptionController>();
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
                    border: Border.all(color: AppColors.beforeYouGoIconBubbleIcon.withValues(alpha: 0.4), width: 1),
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
                  "We'd love to keep you as a partner. Consider these options:",
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
                  title: 'Pause Subscription',
                  subtitle: 'Take a break for up to 3 months. Your data stays safe.',
                  onTap: c.onPauseSubscription,
                ),
                SizedBox(height: _kOptionsSpacing),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => c.onConfirmCancel(),
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: _kBtnPaddingV, horizontal: _kBtnPaddingH),
                      decoration: BoxDecoration(
                        color: AppColors.beforeYouGoCancelBtnBg,
                        borderRadius: BorderRadius.circular(_kBtnRadius),
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
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: _kBtnPaddingV, horizontal: _kBtnPaddingH),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFF43F5E),
                            Color(0xFFEC4899),
                            Color(0xFFA855F7),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(_kBtnRadius),
                        boxShadow: AppShadows.manageSubCard,
                      ),
                      alignment: Alignment.center,
                      child: Text('Keep My Subscription', style: AppTextStyles.manageSubUpgradeBtn),
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
