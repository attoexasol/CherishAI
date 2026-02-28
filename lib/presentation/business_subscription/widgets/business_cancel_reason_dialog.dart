// lib/presentation/business_subscription/widgets/business_cancel_reason_dialog.dart
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
const double _kReasonTilePadding = 16;
const double _kReasonTileRadius = 16;
const double _kReasonTileSpacing = 12;
const double _kReasonIconSize = 28;
const double _kReasonCheckSize = 20;
const double _kBtnSpacing = 12;
const double _kBtnRadius = 16;
const double _kBtnPaddingV = 12;
const double _kBtnPaddingH = 24;
const double _kMaxWidth = 448;

const List<Map<String, String>> _kReasons = [
  {'id': 'too-expensive', 'label': 'Too expensive', 'icon': '💰'},
  {'id': 'not-using', 'label': 'Not using it enough', 'icon': '⏰'},
  {'id': 'technical-issues', 'label': 'Technical issues', 'icon': '⚙️'},
  {'id': 'missing-features', 'label': 'Missing features I need', 'icon': '✨'},
  {'id': 'found-alternative', 'label': 'Found a better alternative', 'icon': '🔄'},
  {'id': 'other', 'label': 'Other reason', 'icon': '💭'},
];

const List<String> _kLoseAccessItems = [
  'Smart customer matching',
  'Business profile visibility',
  'Product & service listings',
  'Analytics and insights',
];

class BusinessCancelReasonDialog extends StatelessWidget {
  const BusinessCancelReasonDialog({super.key});

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
                          color: AppColors.businessCancelIconBubbleWhy,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.warning_amber_rounded, size: _kIconSize, color: AppColors.businessCancelIconWhy),
                      ),
                      SizedBox(height: _kIconMb),
                      Text('Why are you leaving?', style: AppTextStyles.businessCancelDialogTitle, textAlign: TextAlign.center),
                      SizedBox(height: _kTitleMb),
                      Text(
                        'Your feedback helps us improve our service',
                        style: AppTextStyles.businessCancelDialogSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _kBoxMb),
                _buildLoseAccessBox(),
                SizedBox(height: _kBoxMb),
                Obx(() {
                  final selected = c.cancelReason.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ..._kReasons.map((r) => Padding(
                            padding: const EdgeInsets.only(bottom: _kReasonTileSpacing),
                            child: _buildReasonTile(
                              id: r['id']!,
                              label: r['label']!,
                              icon: r['icon']!,
                              isSelected: selected == r['id'],
                              onTap: () => c.onSelectCancelReason(r['id']!),
                            ),
                          )),
                    ],
                  );
                }),
                SizedBox(height: _kBoxMb),
                Obx(() {
                  final hasSelection = c.cancelReason.value.isNotEmpty;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: hasSelection
                              ? () {
                                  Get.back();
                                  c.openFinalStepDialog();
                                }
                              : null,
                          borderRadius: BorderRadius.circular(_kBtnRadius),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: _kBtnPaddingV, horizontal: _kBtnPaddingH),
                            decoration: BoxDecoration(
                              color: hasSelection ? null : AppColors.businessCancelContinueDisabledBg,
                              gradient: hasSelection
                                  ? const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Color(0xFFF43F5E), Color(0xFFEC4899), Color(0xFFA855F7)],
                                      stops: [0.0, 0.5, 1.0],
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(_kBtnRadius),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Continue',
                              style: hasSelection ? AppTextStyles.businessCancelContinueBtn : AppTextStyles.businessCancelContinueDisabled,
                            ),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(_kBtnRadius),
                              border: Border.all(color: AppColors.businessCancelKeepOutlinedBorder, width: 2),
                            ),
                            alignment: Alignment.center,
                            child: Text('Keep My Subscription', style: AppTextStyles.businessCancelKeepOutlined),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
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

  Widget _buildReasonTile({
    required String id,
    required String label,
    required String icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kReasonTileRadius),
        child: Container(
          padding: const EdgeInsets.all(_kReasonTilePadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isSelected
                  ? [AppColors.businessCancelReasonTileSelectedBg, AppColors.businessCancelReasonTileSelectedBg]
                  : [AppColors.businessCancelReasonTileBg, AppColors.businessCancelReasonTileBg],
            ),
            borderRadius: BorderRadius.circular(_kReasonTileRadius),
            border: Border.all(
              color: isSelected ? AppColors.businessCancelReasonTileSelectedBorder : AppColors.businessCancelReasonTileBorder,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: _kReasonIconSize)),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: AppTextStyles.businessCancelReasonTile)),
              Icon(
                Icons.check,
                size: _kReasonCheckSize,
                color: isSelected ? AppColors.businessCancelReasonCheckSelected : AppColors.businessCancelReasonCheckUnselected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
