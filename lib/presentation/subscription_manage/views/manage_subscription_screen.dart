// lib/presentation/subscription_manage/views/manage_subscription_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../subscription/models/plan_model.dart';
import '../controllers/manage_subscription_controller.dart';

const double _kAppBarPaddingH = 16;
const double _kAppBarPaddingV = 12;
const double _kBackIconSize = 24;
const double _kHelpBtnSize = 40;
const double _kCardRadius = 24;
const double _kCardPadding = 24;
const double _kCrownBubbleSize = 48;
const double _kCrownIconSize = 24;
const double _kUpgradeBtnHeight = 48;
const double _kUpgradeBtnRadius = 999;
const double _kMaxContentWidth = 480;
const double _kHorizontalPadding = 24;
const double _kPlanCardRadius = 20;
const double _kPlanCardPadding = 20;
const double _kPlanIconSize = 36;
const double _kBadgeRadius = 999;
const double _kFeatureIconSize = 18;

class ManageSubscriptionScreen extends StatelessWidget {
  const ManageSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ManageSubscriptionController>();
    return Scaffold(
      backgroundColor: AppColors.manageSubPageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAppBar(context, c),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kHorizontalPadding,
                  right: _kHorizontalPadding,
                  top: 16,
                  bottom: 32,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                    child: Obx(() {
                      final showPlans = c.showPlans.value;
                      final currentPlanId = c.currentPlanId.value;
                      final currentPlan = c.plans.firstWhere(
                        (p) => p.id == currentPlanId,
                        orElse: () => PlansData.plus,
                      );
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildCurrentPlanCard(context, c, showPlans, currentPlan),
                          if (showPlans) ...[
                            const SizedBox(height: 28),
                            _buildChooseHeader(context),
                            const SizedBox(height: 20),
                            ...c.plans.map((plan) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildPlanCard(context, c, plan, currentPlanId),
                                )),
                          ],
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ManageSubscriptionController c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_kAppBarPaddingH, _kAppBarPaddingV, _kAppBarPaddingH, 12),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.manageSubBackIcon),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Manage Subscription',
              style: AppTextStyles.manageSubAppBarTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onHelp,
              borderRadius: BorderRadius.circular(_kHelpBtnSize / 2),
              child: Container(
                width: _kHelpBtnSize,
                height: _kHelpBtnSize,
                decoration: BoxDecoration(
                  color: AppColors.manageSubHelpBtnBg,
                  border: Border.all(color: AppColors.manageSubHelpBtnBorder),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.help_outline, size: 22, color: AppColors.manageSubHelpIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPlanCard(
    BuildContext context,
    ManageSubscriptionController c,
    bool showPlans,
    PlanModel currentPlan,
  ) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.manageSubCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.manageSubCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _kCrownBubbleSize,
                height: _kCrownBubbleSize,
                decoration: BoxDecoration(
                  color: AppColors.manageSubCrownBubbleBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.workspace_premium, size: _kCrownIconSize, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Plan', style: AppTextStyles.manageSubCurrentPlanLabel),
                  const SizedBox(height: 2),
                  Text(currentPlan.name, style: AppTextStyles.manageSubPlanName),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: showPlans ? c.onHidePlans : c.onUpgrade,
              borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
              child: Container(
                height: _kUpgradeBtnHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppGradients.manageSubUpgradeBtn,
                  borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
                  boxShadow: AppShadows.manageSubCard,
                ),
                alignment: Alignment.center,
                child: Text(
                  showPlans ? 'Hide Plans' : 'Upgrade',
                  style: AppTextStyles.manageSubUpgradeBtn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onUnsubscribe,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Text('Unsubscribe', style: AppTextStyles.manageSubUnsubscribeLink),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChooseHeader(BuildContext context) {
    return Column(
      children: [
        Text('Choose Your Plan', style: AppTextStyles.manageSubChooseTitle, textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(
          'Select the perfect plan for your relationship journey',
          style: AppTextStyles.manageSubChooseSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    ManageSubscriptionController c,
    PlanModel plan,
    String currentPlanId,
  ) {
    final isCurrent = plan.id == currentPlanId;
    final isEssential = plan.id == 'essential';
    final isUnlimited = plan.id == 'unlimited';
    final isPlus = plan.id == 'plus';

    Color borderColor = AppColors.manageSubPlanCardBorderEssential;
    if (isPlus) borderColor = AppColors.manageSubPlanCardBorderPlus;
    if (isUnlimited) borderColor = AppColors.manageSubPlanCardBorderUnlimited;

    return Container(
      padding: const EdgeInsets.all(_kPlanCardPadding),
      decoration: BoxDecoration(
        color: AppColors.manageSubCardBg,
        borderRadius: BorderRadius.circular(_kPlanCardRadius),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: AppShadows.manageSubCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCurrent || isPlus) ...[
            Row(
              children: [
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.manageSubBadgeCurrentBg,
                      borderRadius: BorderRadius.circular(_kBadgeRadius),
                    ),
                    child: Text('Current Plan', style: AppTextStyles.manageSubBadge),
                  ),
                const Spacer(),
                if (isPlus)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.manageSubBadgePopularBg,
                      borderRadius: BorderRadius.circular(_kBadgeRadius),
                    ),
                    child: Text('Most Popular', style: AppTextStyles.manageSubBadge),
                  ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Container(
                width: _kPlanIconSize,
                height: _kPlanIconSize,
                decoration: BoxDecoration(
                  color: AppColors.manageSubCrownBubbleBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.workspace_premium, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plan.name, style: AppTextStyles.subPlanName),
                    if (plan.subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(plan.subtitle!, style: AppTextStyles.subPlanSubtitle),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(plan.price, style: AppTextStyles.subPriceMain),
              const SizedBox(width: 2),
              Text(plan.period, style: AppTextStyles.subPricePeriod),
            ],
          ),
          const SizedBox(height: 14),
          ...plan.includes.take(4).map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: _kFeatureIconSize, color: AppColors.success),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item.text, style: AppTextStyles.subIncludeItem)),
                ],
              ),
            );
          }),
          const SizedBox(height: 14),
          if (isEssential)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onDowngradeToEssential,
                borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppGradients.manageSubDowngradeBtn,
                    borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text('Downgrade to Cherish Essential', style: AppTextStyles.manageSubUpgradeBtn),
                ),
              ),
            )
          else if (isCurrent)
            Container(
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.manageSubCtaDisabledBg,
                borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
              ),
              alignment: Alignment.center,
              child: Text('Your Current Plan', style: AppTextStyles.manageSubCtaDisabled),
            )
          else if (isUnlimited)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onUpgradeToUnlimited,
                borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppGradients.manageSubUpgradeUnlimited,
                    borderRadius: BorderRadius.circular(_kUpgradeBtnRadius),
                  ),
                  alignment: Alignment.center,
                  child: Text('Upgrade to Cherish Unlimited', style: AppTextStyles.manageSubUpgradeBtn),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
