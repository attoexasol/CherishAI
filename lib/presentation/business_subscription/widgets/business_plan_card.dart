// lib/presentation/business_subscription/widgets/business_plan_card.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/business_manage_subscription_controller.dart';

const double _kCardRadius = 20;
const double _kCardPadding = 24;
const double _kIconSize = 48;
const double _kIconInnerSize = 24;
const double _kBadgeInset = 16;
const double _kSectionMb = 24;
const double _kGapIconText = 12;
const double _kBtnRadius = 16;
const double _kFeatureIconSize = 20;
const double _kBadgePaddingH = 12;
const double _kBadgePaddingV = 4;
const double _kPriceFontSize = 36;
const double _kFeatureSpacing = 12;
const double _kFeatureGap = 8;

class BusinessPlanCard extends StatelessWidget {
  const BusinessPlanCard({
    super.key,
    required this.plan,
    required this.currentPlanId,
    required this.onUpgradeToPlus,
  });

  final BusinessPlan plan;
  final String currentPlanId;
  final VoidCallback? onUpgradeToPlus;

  @override
  Widget build(BuildContext context) {
    final isCurrent = plan.id == currentPlanId;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 24, left: _kCardPadding, right: _kCardPadding, bottom: _kCardPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: plan.cardBgColors.map((c) => Color(c)).toList(),
            ),
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(color: Color(plan.borderColor), width: 2),
            boxShadow: AppShadows.manageSubCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _kIconSize,
                    height: _kIconSize,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: plan.gradientColors.map((c) => Color(c)).toList(),
                      ),
                      borderRadius: BorderRadius.circular(_kIconSize / 2),
                      boxShadow: AppShadows.manageSubCard,
                    ),
                    child: Icon(Icons.workspace_premium, size: _kIconInnerSize, color: Colors.white),
                  ),
                  SizedBox(width: _kGapIconText),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(plan.name, style: AppTextStyles.manageSubPlanName, maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(plan.description, style: AppTextStyles.manageSubChooseSubtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: _kSectionMb),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(plan.price, style: AppTextStyles.manageSubPlanName.copyWith(fontSize: _kPriceFontSize)),
                  const SizedBox(width: 4),
                  Text(plan.period, style: AppTextStyles.manageSubChooseSubtitle),
                ],
              ),
              SizedBox(height: _kSectionMb),
              ...plan.features.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: _kFeatureSpacing),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, size: _kFeatureIconSize, color: AppColors.success),
                        SizedBox(width: _kFeatureGap),
                        Expanded(child: Text(f, style: AppTextStyles.manageSubChooseSubtitle.copyWith(color: AppColors.manageSubPlanName), maxLines: 2, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  )),
              SizedBox(height: _kSectionMb),
              if (isCurrent)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColors.manageSubCtaDisabledBg,
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text('Your Current Plan', style: AppTextStyles.manageSubCtaDisabled),
                )
              else if (plan.id == 'plus' && onUpgradeToPlus != null)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onUpgradeToPlus,
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: plan.gradientColors.map((c) => Color(c)).toList(),
                        ),
                        borderRadius: BorderRadius.circular(_kBtnRadius),
                        boxShadow: AppShadows.manageSubCard,
                      ),
                      alignment: Alignment.center,
                      child: Text('Upgrade to ${plan.name}', style: AppTextStyles.manageSubUpgradeBtn, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (isCurrent)
          Positioned(
            top: _kBadgeInset,
            left: _kBadgeInset,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
              decoration: BoxDecoration(
                color: AppColors.manageSubBadgeCurrentBg,
                borderRadius: BorderRadius.circular(999),
                boxShadow: AppShadows.manageSubCard,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, size: 12, color: Colors.white),
                  const SizedBox(width: 4),
                  Text('Current Plan', style: AppTextStyles.manageSubBadge),
                ],
              ),
            ),
          ),
        if (plan.popular)
          Positioned(
            top: _kBadgeInset,
            right: _kBadgeInset,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(999),
                boxShadow: AppShadows.manageSubCard,
              ),
              child: Text('Most Popular', style: AppTextStyles.manageSubBadge.copyWith(color: AppColors.manageSubBadgePopularText)),
            ),
          ),
      ],
    );
  }
}
