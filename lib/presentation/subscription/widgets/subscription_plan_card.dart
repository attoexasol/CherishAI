// lib/presentation/subscription/widgets/subscription_plan_card.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/manage_subscription_controller.dart';

/// RomanticCard: rounded-[20px] p-6, shadow 0 8px 30px rgb(0,0,0,0.08). React: border-2 border-rose-300/purple-300/indigo-300, ring-4 ring-purple-300 ring-offset-2 when current. Badges top-4 (16px), px-3 py-1, text-xs font-bold. Crown w-12 h-12 (48), icon w-6 (24). Price text-4xl (36). space-y-3 (12) features, gap-2 (8) check-text. rounded-2xl (16) buttons.
const double _kCardRadius = 20;
const double _kCardPadding = 24;
const double _kIconSize = 48;
const double _kIconInnerSize = 24;
const double _kBadgeInset = 16;
const double _kContentPt = 24;
const double _kSectionMb = 24;
const double _kGapIconText = 12;
const double _kBtnRadius = 16;
const double _kFeatureIconSize = 20;
const double _kBadgePaddingH = 12;
const double _kBadgePaddingV = 4;
const double _kPriceFontSize = 36;
const double _kFeatureSpacing = 12;
const double _kFeatureGap = 8;
const double _kRingWidth = 4;
const double _kRingOffset = 2;
const Color _kRingPurple = Color(0xFFD8B4FE);
const Color _kBorderRose300 = Color(0xFFFDA4AF);
const Color _kBorderPurple300 = Color(0xFFD8B4FE);
const Color _kBorderIndigo300 = Color(0xFFA5B4FC);
const LinearGradient _kBadgeMostPopularGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
);

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.currentPlanId,
    required this.onDowngradeToEssential,
    required this.onUpgradeToUnlimited,
  });

  final ManageSubPlan plan;
  final String currentPlanId;
  final VoidCallback? onDowngradeToEssential;
  final VoidCallback? onUpgradeToUnlimited;

  @override
  Widget build(BuildContext context) {
    final isCurrent = plan.id == currentPlanId;
    final isEssential = plan.id == 'essential';
    final isUnlimited = plan.id == 'unlimited';

    Color borderColor = _kBorderRose300;
    if (plan.borderColorKey == 'plus') borderColor = _kBorderPurple300;
    if (plan.borderColorKey == 'unlimited') borderColor = _kBorderIndigo300;

    final card = Container(
      padding: const EdgeInsets.only(top: _kContentPt, left: _kCardPadding, right: _kCardPadding, bottom: _kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.manageSubCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 8), blurRadius: 30, spreadRadius: 0, color: Color(0x14000000)),
        ],
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
                  gradient: AppGradients.manageSubUpgradeBtn,
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
                    Text(plan.description, style: AppTextStyles.subPlanSubtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
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
              Text(plan.price, style: AppTextStyles.subPriceMain.copyWith(fontSize: _kPriceFontSize)),
              const SizedBox(width: 4),
              Text(plan.period, style: AppTextStyles.subPricePeriod),
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
                    Expanded(child: Text(f, style: AppTextStyles.subIncludeItem, maxLines: 2, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              )),
          SizedBox(height: _kSectionMb),
          if (isEssential && onDowngradeToEssential != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onDowngradeToEssential,
                borderRadius: BorderRadius.circular(_kBtnRadius),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: AppGradients.manageSubDowngradeBtn,
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text('Downgrade to ${plan.name}', style: AppTextStyles.manageSubUpgradeBtn, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ),
            )
          else if (isCurrent)
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
          else if (isUnlimited && onUpgradeToUnlimited != null)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onUpgradeToUnlimited,
                borderRadius: BorderRadius.circular(_kBtnRadius),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: AppGradients.manageSubUpgradeUnlimited,
                    borderRadius: BorderRadius.circular(_kBtnRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text('Upgrade to ${plan.name}', style: AppTextStyles.manageSubUpgradeBtn, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
        ],
      ),
    );

    Widget wrapped = card;
    if (isCurrent) {
      wrapped = Container(
        margin: const EdgeInsets.all(_kRingOffset),
        padding: const EdgeInsets.all(_kRingOffset),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_kCardRadius + _kRingOffset + _kRingWidth),
          border: Border.all(color: _kRingPurple, width: _kRingWidth),
        ),
        child: card,
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        wrapped,
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
                gradient: _kBadgeMostPopularGradient,
                borderRadius: BorderRadius.circular(999),
                boxShadow: AppShadows.manageSubCard,
              ),
              child: Text('Most Popular', style: AppTextStyles.manageSubBadge),
            ),
          ),
      ],
    );
  }
}
