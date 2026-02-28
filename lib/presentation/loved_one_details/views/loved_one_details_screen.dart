// lib/presentation/loved_one_details/views/loved_one_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/loved_one_details_controller.dart';

const double _kMaxContentWidth = 480;
const double _kPaddingH = 24;
const double _kHeaderPaddingTop = 48;
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingBottom = 32;
const double _kBackIconSize = 24;
const double _kAvatarSize = 80;
const double _kEditBtnSize = 40;
const double _kContentPaddingTop = 24;
const double _kCardRadius = 20;
const double _kCardPadding = 24;
const double _kCardGap = 16;
const double _kSectionIconSize = 20;
const double _kPrimaryGoalDropdownRadius = 12;
const double _kSecondaryRowRadius = 12;
const double _kSecondaryRowPadding = 10;
const double _kCheckboxSize = 16;
const double _kChipPaddingH = 12;
const double _kChipPaddingV = 6;
const double _kChipRadius = 999;
const double _kChipGap = 8;
const double _kCtaBtnHeight = 52;
const double _kCtaBtnRadius = 16;
const double _kPremiumCrownSize = 48;
const double _kBottomNavHeight = 72;
const double _kBottomNavRadius = 28;
const double _kBottomNavPaddingH = 16;
const double _kBottomNavPaddingV = 12;
const double _kBottomNavHideLabelWidth = 280;
const double _kScrollBottomPadding = 24;

class LovedOneDetailsScreen extends StatelessWidget {
  const LovedOneDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LovedOneDetailsController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.homePageBg,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final showBottomNavLabels = screenWidth >= _kBottomNavHideLabelWidth;
            final paddingH = screenWidth < Breakpoints.sm ? 16.0 : _kPaddingH;
            final topSafe = MediaQuery.paddingOf(context).top;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context, c, paddingH, topSafe),
                Container(width: double.infinity, height: 1, color: Colors.white),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: paddingH,
                      right: paddingH,
                      top: _kContentPaddingTop,
                      bottom: _kBottomNavHeight + _kScrollBottomPadding + bottomPadding,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: _kMaxContentWidth.clamp(0, screenWidth - paddingH * 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildImportantDatesCard(context, c),
                            SizedBox(height: _kCardGap),
                            _buildContactCard(context, c),
                            SizedBox(height: _kCardGap),
                            _buildRelationshipGoalsCard(context, c),
                            SizedBox(height: _kCardGap),
                            _buildWhatTheyLoveCard(context, c),
                            SizedBox(height: _kCardGap),
                            _buildViewGiftIdeasButton(context, c),
                            SizedBox(height: _kCardGap),
                            _buildPremiumCard(context, c),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildBottomNav(context, c, showBottomNavLabels),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LovedOneDetailsController c, double paddingH, double topSafe) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppGradients.lovedOneDetailsHeader,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          paddingH,
          topSafe + _kHeaderPaddingTop,
          paddingH,
          _kHeaderPaddingBottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onBack,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.lovedOneDetailsBackIcon),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _kAvatarSize,
                  height: _kAvatarSize,
                  decoration: BoxDecoration(
                    color: AppColors.lovedOneDetailsAvatarBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Obx(() => Text(c.emoji.value, style: const TextStyle(fontSize: 40))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(c.name.value, style: AppTextStyles.lovedOneDetailsName)),
                      const SizedBox(height: 4),
                      Obx(() => Text(c.relationship.value, style: AppTextStyles.lovedOneDetailsRelationship)),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.onEditLovedOne,
                    borderRadius: BorderRadius.circular(_kEditBtnSize / 2),
                    child: Container(
                      width: _kEditBtnSize,
                      height: _kEditBtnSize,
                      decoration: BoxDecoration(
                        color: AppColors.lovedOneDetailsEditBtnBg,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.lovedOneDetailsEditBtn,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.edit_outlined, size: 20, color: AppColors.lovedOneDetailsEditIcon),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImportantDatesCard(BuildContext context, LovedOneDetailsController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.lovedOneDetailsCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.lovedOneDetailsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: _kSectionIconSize, color: AppColors.lovedOneDetailsSectionIcon),
              const SizedBox(width: 8),
              Text('Important Dates', style: AppTextStyles.lovedOneDetailsCardTitle),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Birthday', style: AppTextStyles.lovedOneDetailsRowLabel),
              Text(c.birthday.value, style: AppTextStyles.lovedOneDetailsRowValue),
            ],
          )),
          const SizedBox(height: 8),
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Anniversary', style: AppTextStyles.lovedOneDetailsRowLabel),
              Text(c.anniversary.value, style: AppTextStyles.lovedOneDetailsRowValue),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, LovedOneDetailsController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.lovedOneDetailsCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.lovedOneDetailsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phone_outlined, size: _kSectionIconSize, color: AppColors.lovedOneDetailsSectionIcon),
              const SizedBox(width: 8),
              Text('Contact Information', style: AppTextStyles.lovedOneDetailsCardTitle),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (c.phone.value.isEmpty) return const SizedBox.shrink();
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.lovedOneDetailsContactBubbleBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.phone_outlined, size: 16, color: AppColors.lovedOneDetailsContactBubbleIcon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone', style: AppTextStyles.lovedOneDetailsContactLabel),
                      const SizedBox(height: 2),
                      Text(c.phone.value, style: AppTextStyles.lovedOneDetailsContactValue),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRelationshipGoalsCard(BuildContext context, LovedOneDetailsController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.lovedOneDetailsCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.lovedOneDetailsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag_outlined, size: _kSectionIconSize, color: AppColors.lovedOneDetailsSectionIcon),
              const SizedBox(width: 8),
              Text('Relationship Goals', style: AppTextStyles.lovedOneDetailsCardTitle),
            ],
          ),
          const SizedBox(height: 16),
          Text('💕 Primary Goal', style: AppTextStyles.lovedOneDetailsPrimaryGoalLabel),
          const SizedBox(height: 8),
          Obx(() => DropdownButtonFormField<String>(
            value: c.primaryGoalKey.value.isEmpty ? null : c.primaryGoalKey.value,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kPrimaryGoalDropdownRadius)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kPrimaryGoalDropdownRadius),
                borderSide: const BorderSide(color: AppColors.lovedOneDetailsPrimaryGoalBorder, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: AppTextStyles.lovedOneDetailsRowValue,
            items: [
              DropdownMenuItem(value: null, child: Text('Select your primary goal', style: AppTextStyles.editLovedOneInputPlaceholder)),
              ...c.primaryGoalOptions.map((g) => DropdownMenuItem(value: g.key, child: Text(g.title))),
            ],
            onChanged: (v) => c.onSelectPrimaryGoal(v),
          )),
          Obx(() {
            final goal = c.selectedPrimaryGoal;
            if (goal == null) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(goal.subtitle, style: AppTextStyles.lovedOneDetailsPrimaryGoalDesc),
            );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('✨ Secondary Goals', style: AppTextStyles.lovedOneDetailsPrimaryGoalLabel),
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lovedOneDetailsSecondaryPillBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('${c.secondaryGoalIds.length}/3', style: AppTextStyles.lovedOneDetailsSecondaryPill),
              )),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() => Column(
            children: c.secondaryGoalsWithCategory.map((goal) {
              final isSelected = c.secondaryGoalIds.contains(goal.id);
              final isDisabled = !isSelected && !c.canAddSecondaryGoal;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isDisabled ? null : () => c.onToggleSecondaryGoal(goal.id),
                    borderRadius: BorderRadius.circular(_kSecondaryRowRadius),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: _kSecondaryRowPadding),
                      decoration: BoxDecoration(
                        gradient: isSelected ? AppGradients.lovedOneDetailsSecondaryRowSelected : null,
                        color: isSelected ? null : (isDisabled ? AppColors.lovedOneDetailsSecondaryRowDisabledBg : Colors.white),
                        borderRadius: BorderRadius.circular(_kSecondaryRowRadius),
                        border: Border.all(
                          color: isSelected ? AppColors.lovedOneDetailsSecondaryRowSelectedBorder : AppColors.lovedOneDetailsSecondaryRowUnselectedBorder,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: _kCheckboxSize,
                            height: _kCheckboxSize,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.editLovedOneSectionIcon : Colors.white,
                              border: Border.all(
                                color: isSelected ? AppColors.editLovedOneSectionIcon : AppColors.editLovedOneInputFocusBorder,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goal.label,
                                  style: isSelected ? AppTextStyles.lovedOneDetailsSecondaryRowTitleSelected : AppTextStyles.lovedOneDetailsSecondaryRowTitle,
                                ),
                                Text(goal.categoryTitle, style: AppTextStyles.lovedOneDetailsSecondaryRowCategory),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildWhatTheyLoveCard(BuildContext context, LovedOneDetailsController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.lovedOneDetailsCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.lovedOneDetailsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, size: _kSectionIconSize, color: AppColors.lovedOneDetailsSectionIcon),
              const SizedBox(width: 8),
              Text('What They Love', style: AppTextStyles.lovedOneDetailsCardTitle),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() => Wrap(
            spacing: _kChipGap,
            runSpacing: _kChipGap,
            children: c.hobbyLabels.map((label) => Container(
              padding: EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
              decoration: BoxDecoration(
                color: AppColors.lovedOneDetailsChipBg,
                borderRadius: BorderRadius.circular(_kChipRadius),
                border: Border.all(color: AppColors.lovedOneDetailsChipBorderSelected),
              ),
              child: Text(label, style: AppTextStyles.lovedOneDetailsChip),
            )).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildViewGiftIdeasButton(BuildContext context, LovedOneDetailsController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onViewGiftIdeas,
        borderRadius: BorderRadius.circular(_kCtaBtnRadius),
        child: Container(
          height: _kCtaBtnHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: AppGradients.lovedOneDetailsCtaBtn,
            borderRadius: BorderRadius.circular(_kCtaBtnRadius),
            boxShadow: AppShadows.lovedOneDetailsCtaBtn,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.card_giftcard_outlined, size: 20, color: AppColors.white),
              const SizedBox(width: 8),
              Text('View Gift Ideas', style: AppTextStyles.lovedOneDetailsCtaBtn),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCard(BuildContext context, LovedOneDetailsController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        gradient: AppGradients.lovedOneDetailsPremiumCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.lovedOneDetailsPremiumCardBorder, width: 2),
        boxShadow: AppShadows.lovedOneDetailsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _kPremiumCrownSize,
                height: _kPremiumCrownSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.lovedOneDetailsPremiumCrown,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.lovedOneDetailsEditBtn,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.workspace_premium, size: 24, color: AppColors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Unlock Premium Features', style: AppTextStyles.lovedOneDetailsPremiumTitle),
                    const SizedBox(height: 4),
                    Text(
                      'Access personalized AI insights, unlimited loved ones, advanced gift recommendations, and more.',
                      style: AppTextStyles.lovedOneDetailsPremiumSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.lovedOneDetailsPremiumHintBg,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('Choose a higher tier', style: AppTextStyles.lovedOneDetailsPremiumHint),
            ),
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onViewSubscriptionPlans,
              borderRadius: BorderRadius.circular(_kCtaBtnRadius),
              child: Container(
                height: _kCtaBtnHeight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: AppGradients.lovedOneDetailsCtaBtn,
                  borderRadius: BorderRadius.circular(_kCtaBtnRadius),
                  boxShadow: AppShadows.lovedOneDetailsCtaBtn,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('View Subscription Plans', style: AppTextStyles.lovedOneDetailsCtaBtn),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20, color: AppColors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    LovedOneDetailsController c,
    bool showLabels,
  ) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.only(
        left: _kBottomNavPaddingH,
        right: _kBottomNavPaddingH,
        top: _kBottomNavPaddingV,
        bottom: _kBottomNavPaddingV + bottomPadding,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.homeBottomNavBg,
            borderRadius: BorderRadius.circular(_kBottomNavRadius),
            border: Border.all(color: AppColors.homeBottomNavBorder),
            boxShadow: AppShadows.homeBottomNav,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildNavItem(context, c, 'home', Icons.home_rounded, 'Home', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'search', Icons.search, 'Search', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'loved_ones', Icons.favorite_border, 'Loved Ones', isActive: true, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'alerts', Icons.notifications_outlined, 'Alerts', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'profile', Icons.person_outline, 'Profile', isActive: false, showLabel: showLabels),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    LovedOneDetailsController c,
    String tab,
    IconData icon,
    String label, {
    required bool isActive,
    bool showLabel = true,
  }) {
    return GestureDetector(
      onTap: () => c.onTapBottomNav(tab),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: showLabel ? 12 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isActive ? AppGradients.homeBottomNavActivePill : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive ? AppShadows.homeBottomNavActivePill : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? AppColors.homeBottomNavActiveIcon : AppColors.homeBottomNavInactiveIcon,
              ),
              if (showLabel) ...[
                const SizedBox(height: 4),
                Text(
                  label,
                  style: isActive ? AppTextStyles.homeBottomNavLabel : AppTextStyles.homeBottomNavLabelInactive,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
