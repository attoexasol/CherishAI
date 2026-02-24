// lib/presentation/dislikes/views/dislikes_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/dislikes_controller.dart';
import '../models/dislike_category_model.dart';

const double _kTopInset = 20;
const double _kBackIconSize = 22;
const double _kProgressBarWidth = 28;
const double _kProgressBarHeight = 6;
const double _kProgressBarGap = 6;
const double _kProgressBarRadius = 3;
const double _kScrollTopPadding = 20;
const double _kFinalPillPaddingV = 8;
const double _kFinalPillPaddingH = 16;
const double _kFinalPillRadius = 999;
const double _kTitleTop = 16;
const double _kDescTop = 10;
const double _kOptionalTop = 8;
const double _kSectionGap = 24;
const double _kCardRadius = 16;
const double _kCardPadding = 20;
const double _kCategoryTitleBottom = 12;
const double _kChipGap = 8;
const double _kChipRunSpacing = 8;
const double _kChipPaddingV = 10;
const double _kChipPaddingH = 14;
const double _kChipRadius = 999;
const double _kCategoryGap = 16;
const double _kAddButtonHeight = 48;
const double _kAddButtonRadius = 12;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 10;
const double _kHelperTop = 8;
const double _kAddButtonTop = 12;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class DislikesScreen extends StatelessWidget {
  const DislikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.dislikesPageBg,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kHorizontalPadding,
                  right: _kHorizontalPadding,
                  top: _kTopInset + 40 + _kScrollTopPadding,
                  bottom: _kCtaHeight + _kCtaBottomPadding + _kHelperTop + 24 + _kAddButtonHeight + _kAddButtonTop + 24,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       // _buildFinalStepPill(context),
                      //  SizedBox(height: _kTitleTop),
                        Text('DISLIKES', style: AppTextStyles.dislikesTitle, textAlign: TextAlign.center),
                        SizedBox(height: _kDescTop),
                        Text(
                          'Every person is different. Sharing what your loved one dislikes helps Cherish AI care in ways that feel right to them',
                          style: AppTextStyles.dislikesDesc,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: _kOptionalTop),
                        Text('Optional', style: AppTextStyles.dislikesOptional, textAlign: TextAlign.center),
                        SizedBox(height: _kSectionGap),
                        ...DislikeCategoriesData.categories.map((cat) => Padding(
                              padding: EdgeInsets.only(bottom: _kCategoryGap),
                              child: _buildCategoryCard(context, cat),
                            )),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _kTopInset,
                left: _kHorizontalPadding,
                right: _kHorizontalPadding,
                child: _buildTopBar(context),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomSection(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final c = Get.find<DislikesController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  Icon(Icons.arrow_back_rounded, size: _kBackIconSize, color: AppColors.dislikesBackText),
                  const SizedBox(width: 6),
                  Text('Back', style: AppTextStyles.dislikesBack),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _progressBar(active: true),
            SizedBox(width: _kProgressBarGap),
            _progressBar(active: true),
            SizedBox(width: _kProgressBarGap),
            _progressBar(active: false),
          ],
        ),
      ],
    );
  }

  Widget _progressBar({required bool active}) {
    return Container(
      width: _kProgressBarWidth,
      height: _kProgressBarHeight,
      decoration: BoxDecoration(
        color: active ? AppColors.dislikesProgressActive : AppColors.dislikesProgressInactive,
        borderRadius: BorderRadius.circular(_kProgressBarRadius),
      ),
    );
  }

  Widget _buildFinalStepPill(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: _kFinalPillPaddingV, horizontal: _kFinalPillPaddingH),
        decoration: BoxDecoration(
          color: AppColors.dislikesFinalPillBg,
          borderRadius: BorderRadius.circular(_kFinalPillRadius),
          border: Border.all(color: AppColors.dislikesFinalPillBorder, width: 1),
          boxShadow: AppShadows.dislikesFinalPill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flag_outlined, size: 16, color: AppColors.dislikesFinalPillText),
            const SizedBox(width: 8),
            Text('Final Step', style: AppTextStyles.dislikesFinalPill),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, DislikeCategoryModel category) {
    final c = Get.find<DislikesController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.dislikesCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.title, style: AppTextStyles.dislikesCategoryTitle),
          SizedBox(height: _kCategoryTitleBottom),
          Obx(() {
            return Wrap(
              spacing: _kChipGap,
              runSpacing: _kChipRunSpacing,
              children: category.items.map((item) {
                final selected = c.selectedDislikeIds.contains(item.id);
                return _buildChip(
                  label: item.label,
                  selected: selected,
                  onTap: () => c.toggleDislike(item.id),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kChipRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: _kChipPaddingV, horizontal: _kChipPaddingH),
          decoration: BoxDecoration(
            color: selected ? AppColors.dislikesChipSelectedBg : AppColors.dislikesChipBg,
            borderRadius: BorderRadius.circular(_kChipRadius),
            border: Border.all(
              color: selected ? AppColors.dislikesChipSelectedBorder : AppColors.dislikesChipBorder,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: selected ? AppTextStyles.dislikesChipSelected : AppTextStyles.dislikesChip,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final c = Get.find<DislikesController>();
    return Container(
      padding: EdgeInsets.fromLTRB(
        _kHorizontalPadding,
        12,
        _kHorizontalPadding,
        _kCtaBottomPadding + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: c.isSubmitting.value ? null : c.onContinue,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    height: _kCtaHeight,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppGradients.dislikesCta,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: AppShadows.dislikesCta,
                    ),
                    child: Text('Continue', style: AppTextStyles.dislikesCta),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: _kHelperTop),
          Text(
            'You can skip or update these preferences later',
            style: AppTextStyles.dislikesHelper,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _kAddButtonTop),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: c.onAddCustomDislike,
                  borderRadius: BorderRadius.circular(_kAddButtonRadius),
                  child: Container(
                    height: _kAddButtonHeight,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.dislikesAddButtonBg,
                      borderRadius: BorderRadius.circular(_kAddButtonRadius),
                      border: Border.all(color: AppColors.dislikesAddButtonBorder, width: 1),
                      boxShadow: AppShadows.dislikesAddButton,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 22, color: AppColors.dislikesAddButtonText),
                        const SizedBox(width: 8),
                        Text('Add Custom Dislike', style: AppTextStyles.dislikesAddButton),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
