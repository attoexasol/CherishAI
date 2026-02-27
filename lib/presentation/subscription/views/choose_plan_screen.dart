// lib/presentation/subscription/views/choose_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/choose_plan_controller.dart';
import '../models/plan_model.dart';

const double _kTopInset = 20;
const double _kBackIconSize = 20;
const double _kLogoSize = 44;
const double _kLogoIconSize = 24;
const double _kCardRadius = 16;
const double _kCardPadding = 20;
const double _kIconSquareSize = 36;
const double _kGreenDotSize = 8;
const double _kRecPillOverlap = 10;
const double _kCtaHeight = 48;
const double _kCtaRadius = 999;
const double _kCtaBottomPadding = 16;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.subPageBg,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kHorizontalPadding,
                    right: _kHorizontalPadding,
                    top: 16,
                    bottom: 24 + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Obx(() {
                        final c = Get.find<ChoosePlanController>();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeader(context),
                            if (c.hasActiveSubscription.value) ...[
                              const SizedBox(height: 24),
                              _buildActiveCard(context),
                            ],
                            const SizedBox(height: 24),
                            ...c.plans.map((plan) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: _buildPlanCard(context, plan),
                                )),
                            if (!c.hasActiveSubscription.value) ...[
                              const SizedBox(height: 24),
                              _buildTrialSection(context),
                              const SizedBox(height: 32),
                            ],
                            if (c.hasActiveSubscription.value) const SizedBox(height: 24),
                            _buildBottomCta(context),
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
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final c = Get.find<ChoosePlanController>();
    return Padding(
      padding: EdgeInsets.only(
        left: _kHorizontalPadding,
        right: _kHorizontalPadding,
        top: _kTopInset,
        bottom: 12,
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.subBackText),
                    const SizedBox(width: 4),
                    Text('Back', style: AppTextStyles.subBack),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: _kLogoSize,
            height: _kLogoSize,
            decoration: BoxDecoration(
              gradient: AppGradients.subAccent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppShadows.prefsSectionBubble,
            ),
            child: Icon(Icons.favorite, size: _kLogoIconSize, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Choose your plan',
          style: AppTextStyles.subTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Let Cherish AI handle the effort, so your care feels personal, natural, and thoughtful.',
            style: AppTextStyles.subSubtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveCard(BuildContext context) {
    final c = Get.find<ChoosePlanController>();
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.subActiveCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.subActiveCardBorder, width: 1),
        boxShadow: AppShadows.subCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _kGreenDotSize,
                height: _kGreenDotSize,
                decoration: const BoxDecoration(
                  color: AppColors.subActiveGreenDot,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text('ACTIVE SUBSCRIPTION', style: AppTextStyles.subActiveLabel),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.subCurrentBadgeBg,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.subActiveCardBorder),
                    ),
                    child: Text(
                      'Current plan',
                      style: AppTextStyles.subCurrentBadge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => Text(c.activePlanName.value, style: AppTextStyles.subActivePlanName)),
          const SizedBox(height: 4),
          Obx(() => Text(c.activePlanPriceLine.value, style: AppTextStyles.subActiveRenewal)),
          const SizedBox(height: 14),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onCancelSubscription,
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Text('Cancel subscription', style: AppTextStyles.subCancelLink),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 4-Day Free Trial info section for new users (no active subscription).
  /// Placed at bottom of page content, below plan cards and above the CTA.
  /// Tappable: when selected, bottom button shows "Start your 4-Days Free Trial".
  Widget _buildTrialSection(BuildContext context) {
    final c = Get.find<ChoosePlanController>();
    return Obx(() {
      final isSelected = c.isTrialSelected.value;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onSelectTrial,
          borderRadius: BorderRadius.circular(_kCardRadius),
          child: Container(
            padding: const EdgeInsets.all(_kCardPadding),
            decoration: BoxDecoration(
              color: AppColors.subCardBg,
              borderRadius: BorderRadius.circular(_kCardRadius),
              border: Border.all(
                color: isSelected ? AppColors.subPlanName : AppColors.subCardBorder,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: AppShadows.subCard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start your 4-Day Free Trial',
                  style: AppTextStyles.subPlanName,
                ),
                const SizedBox(height: 12),
                Text(
                  'Experience how thoughtful care can feel when the effort is handled for you. '
                  'Try Cherish AI with one loved one - cancel any time before the trial ends, '
                  'and you won\'t be charged',
                  style: AppTextStyles.subSubtitle,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildPlanCard(BuildContext context, PlanModel plan) {
    final c = Get.find<ChoosePlanController>();
    final isSelected = c.selectedPlanId.value == plan.id;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (plan.isRecommended)
          Positioned(
            top: -_kRecPillOverlap,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppGradients.subAccent,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: AppShadows.subCard,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 14, color: AppColors.subRecPillText),
                    const SizedBox(width: 6),
                    Text('Recommended', style: AppTextStyles.subRecPill),
                  ],
                ),
              ),
            ),
          ),
        if (isSelected)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.subPlanName,
                shape: BoxShape.circle,
                boxShadow: AppShadows.subCard,
              ),
              child: const Icon(Icons.check, size: 18, color: Colors.white),
            ),
          ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => c.onSelectPlan(plan.id),
            borderRadius: BorderRadius.circular(_kCardRadius),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: plan.isRecommended ? _kRecPillOverlap + 4 : 0),
              padding: const EdgeInsets.all(_kCardPadding),
              decoration: BoxDecoration(
                color: AppColors.subCardBg,
                borderRadius: BorderRadius.circular(_kCardRadius),
                border: Border.all(
                  color: isSelected ? AppColors.subPlanName : AppColors.subCardBorder,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: AppShadows.subCard,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: _kIconSquareSize,
                        height: _kIconSquareSize,
                        decoration: BoxDecoration(
                          gradient: AppGradients.subAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.favorite, size: 18, color: Colors.white),
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
                  const SizedBox(height: 16),
                  Text('INCLUDES:', style: AppTextStyles.subSectionLabel),
                  const SizedBox(height: 8),
                  ...plan.includes.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.subSectionLabel,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(item.text, style: AppTextStyles.subIncludeItem),
                              ),
                            ],
                          ),
                          if (item.detail != null) ...[
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(item.detail!, style: AppTextStyles.subIncludeDetail),
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                  Text('BEST FOR:', style: AppTextStyles.subSectionLabel),
                  const SizedBox(height: 6),
                  Text(plan.bestFor, style: AppTextStyles.subBestFor),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    final c = Get.find<ChoosePlanController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: Obx(() {
        final loading = c.isLoadingPurchase.value;
        final label = c.dynamicButtonText;
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: loading ? null : c.onStartSelectedPlan,
            borderRadius: BorderRadius.circular(_kCtaRadius),
            child: Container(
              height: _kCtaHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppGradients.subCta,
                borderRadius: BorderRadius.circular(_kCtaRadius),
                boxShadow: AppShadows.subCta,
              ),
              alignment: Alignment.center,
              child: loading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : Text(
                      label,
                      style: AppTextStyles.subCta,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
            ),
          ),
        );
      }),
    );
  }
}
