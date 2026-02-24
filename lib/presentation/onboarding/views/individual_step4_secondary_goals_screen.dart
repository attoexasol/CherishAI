// lib/presentation/onboarding/views/individual_step4_secondary_goals_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/individual_step4_secondary_goals_controller.dart';

const double _kBackBtnSize = 48;
const double _kTopInset = 20;
const double _kScrollTopPadding = 24;
const double _kTitleToSubtitleGap = 8;
const double _kSubtitleToDescGap = 8;
const double _kDescToPillGap = 20;
const double _kPillToSectionsGap = 24;
const double _kSectionHeaderGap = 12;
const double _kOptionGap = 10;
const double _kCategoryGap = 20;
const double _kCardRadius = 14;
const double _kCardPadding = 16;
const double _kSelectorSize = 24;
const double _kSelectorToTextGap = 14;
const double _kSectionBubbleSize = 36;
const double _kSectionBubbleToTitleGap = 10;
const double _kPillHeight = 44;
const double _kPillPaddingH = 20;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 12;
const double _kSkipTop = 10;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class IndividualStep4SecondaryGoalsScreen extends StatelessWidget {
  const IndividualStep4SecondaryGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.secGoalsPageBg,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kHorizontalPadding,
                  right: _kHorizontalPadding,
                  top: _kTopInset + _kBackBtnSize + _kScrollTopPadding,
                  bottom: 24 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTitleBlock(context),
                        SizedBox(height: _kDescToPillGap),
                        _buildSelectedPill(context),
                        SizedBox(height: _kPillToSectionsGap),
                        ...SecondaryGoalsData.categories.map((cat) => Padding(
                              padding: EdgeInsets.only(bottom: _kCategoryGap),
                              child: _buildCategory(context, cat),
                            )),
                        SizedBox(height: _kPillToSectionsGap),
                        _buildBottomSection(context),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _kTopInset,
                left: _kHorizontalPadding,
                child: _buildBackButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    final c = Get.find<IndividualStep4SecondaryGoalsController>();
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onBack,
          borderRadius: BorderRadius.circular(_kBackBtnSize / 2),
          child: Container(
            width: _kBackBtnSize,
            height: _kBackBtnSize,
            decoration: BoxDecoration(
              color: AppColors.secGoalsBackBtnBg,
              shape: BoxShape.circle,
              boxShadow: AppShadows.secGoalsBackButton,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, size: 24, color: AppColors.secGoalsBackBtnIcon),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Secondary Relationship Goals',
          style: AppTextStyles.secGoalsTitle,
          textAlign: TextAlign.center,
        ),
        Text(
          '(Optional)',
          style: AppTextStyles.secGoalsTitleOptional,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _kTitleToSubtitleGap),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Choose up to 3 goals to deepen your connection',
              style: AppTextStyles.secGoalsSubtitle,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            const SizedBox(width: 4),
            Icon(Icons.favorite, size: 16, color: AppColors.secGoalsSubtitle),
          ],
        ),
        SizedBox(height: _kSubtitleToDescGap),
        Text(
          "What context or intention should shape how your PRIMARY relationship goal is expressed?",
          style: AppTextStyles.secGoalsDescription,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSelectedPill(BuildContext context) {
    final c = Get.find<IndividualStep4SecondaryGoalsController>();
    return Obx(() {
      final count = c.selectedGoalIds.length;
      return Center(
        child: Container(
          height: _kPillHeight,
          padding: const EdgeInsets.symmetric(horizontal: _kPillPaddingH),
          decoration: BoxDecoration(
            color: AppColors.secGoalsPillBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.secGoalsPillBorder, width: 1.5),
            boxShadow: AppShadows.secGoalsPill,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite, size: 16, color: AppColors.secGoalsSubtitle),
              const SizedBox(width: 6),
              Text(
                'Selected: $count/${IndividualStep4SecondaryGoalsController.maxSelection}',
                style: AppTextStyles.secGoalsPill,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildCategory(BuildContext context, SecondaryGoalCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: _kSectionBubbleSize,
              height: _kSectionBubbleSize,
              decoration: BoxDecoration(
                color: category.bubbleColor,
                shape: BoxShape.circle,
                boxShadow: AppShadows.secGoalsSectionBubble,
              ),
              alignment: Alignment.center,
              child: Icon(category.icon, size: 20, color: AppColors.secGoalsSectionTitle),
            ),
            SizedBox(width: _kSectionBubbleToTitleGap),
            Text(category.title, style: AppTextStyles.secGoalsSectionTitle),
          ],
        ),
        SizedBox(height: _kSectionHeaderGap),
        ...category.options.map((opt) => Padding(
              padding: EdgeInsets.only(bottom: _kOptionGap),
              child: _buildOptionRow(context, opt),
            )),
      ],
    );
  }

  Widget _buildOptionRow(BuildContext context, SecondaryGoalOption option) {
    final c = Get.find<IndividualStep4SecondaryGoalsController>();
    return Obx(() {
      final selected = c.selectedGoalIds.contains(option.id);
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => c.toggleGoal(option.id),
          borderRadius: BorderRadius.circular(_kCardRadius),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(_kCardPadding),
            decoration: BoxDecoration(
              color: AppColors.secGoalsOptionCardBg,
              borderRadius: BorderRadius.circular(_kCardRadius),
              border: Border.all(color: AppColors.secGoalsOptionCardBorder, width: 1),
              boxShadow: AppShadows.secGoalsOptionCard,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _kSelectorSize,
                  height: _kSelectorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? AppColors.secGoalsSelectorSelected : Colors.transparent,
                    border: Border.all(
                      color: selected ? AppColors.secGoalsSelectorSelected : AppColors.secGoalsSelectorBorder,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: selected
                      ? Icon(Icons.check, size: 16, color: AppColors.white)
                      : null,
                ),
                SizedBox(width: _kSelectorToTextGap),
                Expanded(
                  child: Text(
                    option.label,
                    style: AppTextStyles.secGoalsOptionText,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomSection(BuildContext context) {
    final c = Get.find<IndividualStep4SecondaryGoalsController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
              child: Obx(() {
                final enabled = c.selectedGoalIds.isNotEmpty && !c.isSubmitting.value;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: enabled ? c.onSubmit : null,
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      height: _kCtaHeight,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: enabled ? AppGradients.secGoalsCtaEnabled : null,
                        color: enabled ? null : AppColors.secGoalsCtaDisabledBg,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: enabled ? AppShadows.secGoalsCtaEnabled : null,
                      ),
                      child: Text(
                        enabled ? 'Select at least 1 goal' : 'Select at least 1 goal',
                        style: enabled ? AppTextStyles.secGoalsCta : AppTextStyles.secGoalsCtaDisabled,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: _kSkipTop),
          Center(
            child: GestureDetector(
              onTap: c.onSkip,
              child: Text(
                'Skip for now',
                style: AppTextStyles.secGoalsSkipLink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
