// lib/presentation/subscription/views/manage_subscription_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../controllers/manage_subscription_controller.dart';
import '../widgets/subscription_plan_card.dart';

/// Spacing from React: px-6=24, py-4=16, pt-8=32, p-8=32, gap-4=16, mb-6=24, mb-3=12, mt-8=32, space-y-6=24, mb-2=8.
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 16;
const double _kContentPaddingH = 24;
const double _kContentPaddingTop = 32;
const double _kCurrentCardRadius = 24;
const double _kCurrentCardPadding = 32;
const double _kCrownSize = 56;
const double _kCrownIconSize = 28;
const double _kCardRowGap = 16;
const double _kCardRowMarginBottom = 24;
const double _kButtonPaddingV = 16;
const double _kButtonPaddingH = 24;
const double _kButtonMarginBottom = 12;
const double _kExpandMarginTop = 32;
const int _kExpandDurationMs = 300;
const double _kSectionSpacing = 24;
const double _kTitleMarginBottom = 8;
const double _kChooseTitleFontSize = 24; // React: text-2xl font-bold
const double _kBackHelpSize = 40;
const double _kBackHelpIconSize = 20;

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: _kContentPaddingH,
                      right: _kContentPaddingH,
                      top: _kContentPaddingTop,
                      bottom: 96,
                    ),
                    child: Obx(() {
                      final showPlans = c.showPlans.value;
                      final currentPlan = c.currentPlan;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildCurrentPlanCard(context, c, showPlans, currentPlan),
                          SizedBox(height: _kExpandMarginTop),
                          AnimatedSize(
                            duration: const Duration(milliseconds: _kExpandDurationMs),
                            curve: Curves.easeInOut,
                            alignment: Alignment.topCenter,
                            child: showPlans ? _buildPlanSection(context, c) : const SizedBox.shrink(),
                          ),
                        ],
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ManageSubscriptionController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _kHeaderPaddingH, vertical: _kHeaderPaddingV),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(_kBackHelpSize / 2),
              child: SizedBox(
                width: _kBackHelpSize,
                height: _kBackHelpSize,
                child: Icon(Icons.arrow_back_ios_new, size: _kBackHelpIconSize, color: AppColors.manageSubBackIcon),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Manage Subscription',
              style: AppTextStyles.manageSubAppBarTitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onHelp,
              borderRadius: BorderRadius.circular(_kBackHelpSize / 2),
              child: Container(
                width: _kBackHelpSize,
                height: _kBackHelpSize,
                decoration: BoxDecoration(
                  color: AppColors.manageSubHelpBtnBg,
                  border: Border.all(color: AppColors.manageSubHelpBtnBorder),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.help_outline, size: _kBackHelpIconSize, color: AppColors.manageSubHelpIcon),
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
    ManageSubPlan currentPlan,
  ) {
    return Container(
      padding: const EdgeInsets.all(_kCurrentCardPadding),
      decoration: BoxDecoration(
        color: AppColors.manageSubCardBg,
        borderRadius: BorderRadius.circular(_kCurrentCardRadius),
        border: Border.all(color: AppColors.subCardBorder),
        boxShadow: const [
          BoxShadow(offset: Offset(0, 10), blurRadius: 15, spreadRadius: -3, color: Color(0x1A000000)),
          BoxShadow(offset: Offset(0, 4), blurRadius: 6, spreadRadius: -2, color: Color(0x0D000000)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _kCrownSize,
                height: _kCrownSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.manageSubUpgradeBtn,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(offset: Offset(0, 4), blurRadius: 6, spreadRadius: 0, color: Color(0x33000000)),
                  ],
                ),
                child: Icon(Icons.workspace_premium, size: _kCrownIconSize, color: Colors.white),
              ),
              SizedBox(width: _kCardRowGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Plan', style: AppTextStyles.manageSubCurrentPlanLabel),
                    const SizedBox(height: 4),
                    Text(currentPlan.name, style: AppTextStyles.manageSubPlanName, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: _kCardRowMarginBottom),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onUpgradePressed,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: _kButtonPaddingV, horizontal: _kButtonPaddingH),
                decoration: BoxDecoration(
                  gradient: AppGradients.manageSubUpgradeBtn,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(offset: Offset(0, 4), blurRadius: 6, spreadRadius: 0, color: Color(0x33000000)),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(showPlans ? 'Hide Plans' : 'Upgrade', style: AppTextStyles.manageSubUpgradeBtn, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
          SizedBox(height: _kButtonMarginBottom),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onUnsubscribePressed,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'Unsubscribe',
                    style: AppTextStyles.manageSubUnsubscribeLink.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanSection(BuildContext context, ManageSubscriptionController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: _kSectionSpacing),
        Text(
          'Choose Your Plan',
          style: AppTextStyles.manageSubChooseTitle.copyWith(fontSize: _kChooseTitleFontSize),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: _kTitleMarginBottom),
        Text(
          'Select the perfect plan for your relationship journey',
          style: AppTextStyles.manageSubChooseSubtitle,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: _kSectionSpacing),
        ...ManageSubscriptionController.manageSubscriptionPlans.map((plan) => Padding(
              padding: const EdgeInsets.only(bottom: _kSectionSpacing),
              child: SubscriptionPlanCard(
                plan: plan,
                currentPlanId: c.currentPlanId.value,
                onDowngradeToEssential: c.onDowngradeToEssential,
                onUpgradeToUnlimited: c.onUpgradeToUnlimited,
              ),
            )),
        SizedBox(height: MediaQuery.paddingOf(context).bottom + _kSectionSpacing),
      ],
    );
  }
}
