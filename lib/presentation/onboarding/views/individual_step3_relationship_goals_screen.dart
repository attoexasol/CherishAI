// lib/presentation/onboarding/views/individual_step3_relationship_goals_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/individual_step3_relationship_goals_controller.dart';

const double _kBackBtnSize = 48;
const double _kTopInset = 20;
const double _kScrollTopPadding = 24;
const double _kTargetCircleSize = 40;
const double _kTargetToTitleGap = 16;
const double _kTitleToDescGap = 10;
const double _kDescToSectionGap = 24;
const double _kSectionToCardsGap = 12;
const double _kCardGap = 12;
const double _kCardRadius = 16;
const double _kCardPadding = 20;
const double _kCardIconSize = 44;
const double _kCardIconToTextGap = 16;
const double _kCardTitleToSubtitleGap = 4;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 12;
const double _kFooterTop = 8;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class IndividualStep3RelationshipGoalsScreen extends StatelessWidget {
  const IndividualStep3RelationshipGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.goalsPageBg,
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
                        _buildTargetIcon(context),
                        SizedBox(height: _kTargetToTitleGap),
                        Text('Your relationship goals', style: AppTextStyles.goalsTitle),
                        SizedBox(height: _kTitleToDescGap),
                        Text(
                          "Every relationship is different. By choosing your goal, you help Cherish AI understand how you want to care — so suggestions, words, and ideas feel truly personal and aligned with what you're trying to nurture",
                          style: AppTextStyles.goalsDescription,
                        ),
                        SizedBox(height: _kDescToSectionGap),
                        Text('Primary Goal (choose 1)', style: AppTextStyles.goalsSectionLabel),
                        SizedBox(height: _kSectionToCardsGap),
                        ...RelationshipGoalsData.options.map((opt) => Padding(
                              padding: EdgeInsets.only(bottom: _kCardGap),
                              child: _buildGoalCard(context, opt),
                            )),
                        SizedBox(height: _kDescToSectionGap),
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
    final c = Get.find<IndividualStep3RelationshipGoalsController>();
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
              color: AppColors.goalsBackBtnBg,
              shape: BoxShape.circle,
              boxShadow: AppShadows.goalsBackButton,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, size: 24, color: AppColors.goalsBackBtnIcon),
          ),
        ),
      ),
    );
  }

  Widget _buildTargetIcon(BuildContext context) {
    return Container(
      width: _kTargetCircleSize,
      height: _kTargetCircleSize,
      decoration: BoxDecoration(
        color: AppColors.goalsTargetCircleBg,
        shape: BoxShape.circle,
        boxShadow: AppShadows.goalsTargetCircle,
      ),
      alignment: Alignment.center,
      child: Icon(Icons.track_changes, size: 22, color: AppColors.goalsTargetIcon),
    );
  }

  Widget _buildGoalCard(BuildContext context, RelationshipGoalOption option) {
    final c = Get.find<IndividualStep3RelationshipGoalsController>();
    return Obx(() {
      final isSelected = c.selectedGoalKey.value == option.key;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => c.onSelectGoal(option.key),
          borderRadius: BorderRadius.circular(_kCardRadius),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(_kCardPadding),
            decoration: BoxDecoration(
              color: AppColors.goalsCardBg,
              borderRadius: BorderRadius.circular(_kCardRadius),
              border: isSelected ? Border.all(color: AppColors.goalsCardIconPink, width: 2) : null,
              boxShadow: isSelected ? AppShadows.goalsCardSelected : AppShadows.goalsCard,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _kCardIconSize,
                  height: _kCardIconSize,
                  decoration: BoxDecoration(
                    color: option.iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(option.icon, size: 24, color: option.iconColor),
                ),
                SizedBox(width: _kCardIconToTextGap),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(option.title, style: AppTextStyles.goalsCardTitle),
                      SizedBox(height: _kCardTitleToSubtitleGap),
                      Text(
                        option.subtitle,
                        style: AppTextStyles.goalsCardSubtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
    final c = Get.find<IndividualStep3RelationshipGoalsController>();
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
                final enabled = c.selectedGoalKey.value.isNotEmpty && !c.isSaving.value;
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: enabled ? c.onSave : null,
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      height: _kCtaHeight,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: enabled ? AppGradients.goalsSaveEnabled : null,
                        color: enabled ? null : AppColors.goalsSaveDisabledBg,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: enabled ? AppShadows.goalsSaveEnabled : null,
                      ),
                      child: Text(
                        'Save',
                        style: enabled ? AppTextStyles.goalsSaveButton : AppTextStyles.goalsSaveDisabled,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: _kFooterTop),
          Text(
            "We'll help you achieve these goals together",
            style: AppTextStyles.goalsFooter,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
