// lib/presentation/business_subscription/widgets/business_cancel_final_step_dialog.dart
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
const double _kBoxRadius = 16;
const double _kBoxPadding = 16;
const double _kBoxMb = 24;
const double _kLoseItemGap = 8;
const double _kFeedbackLabelMb = 8;
const double _kTextAreaRadius = 16;
const double _kTextAreaPadding = 16;
const double _kTextAreaMinLines = 4;
const double _kBtnSpacing = 12;
const double _kBtnRadius = 16;
const double _kBtnPaddingV = 12;
const double _kBtnPaddingH = 24;
const double _kMaxWidth = 448;

const List<String> _kLoseAccessItems = [
  'Smart customer matching',
  'Business profile visibility',
  'Product & service listings',
  'Analytics and insights',
];

class BusinessCancelFinalStepDialog extends StatelessWidget {
  const BusinessCancelFinalStepDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessManageSubscriptionController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: _kMaxWidth),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_kDialogRadius),
          boxShadow: AppShadows.beforeYouGoDialog,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(_kDialogPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: _kIconBubbleSize,
                        height: _kIconBubbleSize,
                        decoration: BoxDecoration(
                          color: AppColors.businessCancelIconBubbleFinal,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.warning_amber_rounded, size: _kIconSize, color: AppColors.businessCancelIconFinal),
                      ),
                      SizedBox(height: _kIconMb),
                      Text('Final Step', style: AppTextStyles.businessCancelDialogTitle, textAlign: TextAlign.center),
                      SizedBox(height: _kTitleMb),
                      Text(
                        'Are you sure you want to cancel? This action will take effect at the end of your billing period.',
                        style: AppTextStyles.businessCancelDialogSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _kBoxMb),
                _buildLoseAccessBox(),
                SizedBox(height: _kBoxMb),
                Text('Any additional feedback? (Optional)', style: AppTextStyles.businessCancelFeedbackLabel),
                SizedBox(height: _kFeedbackLabelMb),
                TextField(
                      controller: c.cancelFeedbackController,
                      maxLines: _kTextAreaMinLines.toInt(),
                      decoration: InputDecoration(
                        hintText: 'Help us understand how we can improve...',
                        hintStyle: AppTextStyles.businessCancelDialogSubtitle.copyWith(color: AppColors.businessCancelFeedbackPlaceholder),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_kTextAreaRadius),
                          borderSide: const BorderSide(color: AppColors.businessCancelFeedbackBorder, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_kTextAreaRadius),
                          borderSide: const BorderSide(color: AppColors.businessCancelFeedbackBorder, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_kTextAreaRadius),
                          borderSide: const BorderSide(color: AppColors.businessCancelReasonTileSelectedBorder, width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(_kTextAreaPadding),
                      ),
                      style: AppTextStyles.businessCancelLoseAccessItem,
                    ),
                SizedBox(height: _kBoxMb),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.onConfirmCancelSubscription,
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: _kBtnPaddingV, horizontal: _kBtnPaddingH),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [AppColors.businessCancelConfirmBtnStart, AppColors.businessCancelConfirmBtnEnd],
                        ),
                        borderRadius: BorderRadius.circular(_kBtnRadius),
                      ),
                      alignment: Alignment.center,
                      child: Text('Cancel Subscription', style: AppTextStyles.businessCancelConfirmBtn),
                    ),
                  ),
                ),
                SizedBox(height: _kBtnSpacing),
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
                          colors: [Color(0xFFF43F5E), Color(0xFFEC4899), Color(0xFFA855F7)],
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

  Widget _buildLoseAccessBox() {
    return Container(
      padding: const EdgeInsets.all(_kBoxPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.businessCancelLoseAccessBoxStart, AppColors.businessCancelLoseAccessBoxEnd],
        ),
        borderRadius: BorderRadius.circular(_kBoxRadius),
        border: Border.all(color: AppColors.businessCancelLoseAccessBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("You'll lose access to:", style: AppTextStyles.businessCancelLoseAccessTitle),
          const SizedBox(height: 8),
          ..._kLoseAccessItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: _kLoseItemGap),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.close, size: 16, color: AppColors.businessCancelLoseAccessX),
                    const SizedBox(width: 8),
                    Expanded(child: Text(item, style: AppTextStyles.businessCancelLoseAccessItem)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
