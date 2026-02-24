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
const double _kFormCardRadius = 16;
const double _kFormCardPadding = 20;
const double _kFormTitleBottom = 16;
const double _kFormFieldGap = 16;
const double _kFormInputRadius = 12;
const double _kFormInputHeight = 48;
const double _kFormButtonHeight = 48;
const double _kFormButtonRadius = 12;
const double _kFormButtonGap = 12;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 10;
const double _kHelperTop = 8;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class DislikesScreen extends StatelessWidget {
  const DislikesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
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
                  bottom: 24 + bottomPadding,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                        SizedBox(height: _kSectionGap),
                        _buildAddCustomDislikeSection(context),
                        SizedBox(height: _kSectionGap),
                        _buildBottomSection(context),
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

  Widget _buildAddCustomDislikeSection(BuildContext context) {
    final c = Get.find<DislikesController>();
    return Obx(() {
      if (c.showCustomDislikeForm.value) {
        return _buildCustomDislikeForm(context, c);
      }
      return _buildAddCustomDislikeButton(context, c);
    });
  }

  Widget _buildAddCustomDislikeButton(BuildContext context, DislikesController c) {
    final disabled = !c.canAddMoreCustomDislikes;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : c.onAddCustomDislike,
        borderRadius: BorderRadius.circular(_kAddButtonRadius),
        child: Container(
          height: _kAddButtonHeight,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: disabled ? AppColors.dislikesChipBorder : AppColors.dislikesAddButtonBg,
            borderRadius: BorderRadius.circular(_kAddButtonRadius),
            border: Border.all(color: AppColors.dislikesAddButtonBorder, width: 1),
            boxShadow: AppShadows.dislikesAddButton,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 22, color: disabled ? AppColors.dislikesHelperText : AppColors.dislikesAddButtonText),
              const SizedBox(width: 8),
              Text(
                c.canAddMoreCustomDislikes ? 'Add Custom Dislike' : 'Add Custom Dislike (Max 2 reached)',
                style: AppTextStyles.dislikesAddButton.copyWith(color: disabled ? AppColors.dislikesHelperText : AppColors.dislikesAddButtonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDislikeForm(BuildContext context, DislikesController c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kFormCardPadding),
      decoration: BoxDecoration(
        color: AppColors.dislikesAddButtonBg,
        borderRadius: BorderRadius.circular(_kFormCardRadius),
        border: Border.all(color: AppColors.dislikesFinalPillBorder),
        boxShadow: AppShadows.dislikesCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add Custom Dislike', style: AppTextStyles.prefsDialogTitle.copyWith(color: AppColors.dislikesCategoryTitle)),
          const SizedBox(height: _kFormTitleBottom),
          TextField(
            controller: c.customDislikeTextController,
            style: AppTextStyles.prefsDialogInput.copyWith(color: AppColors.dislikesCategoryTitle),
            decoration: InputDecoration(
              hintText: 'e.g., Strong perfumes, Horror movies, Late-night plans',
              hintStyle: AppTextStyles.prefsDialogInputPlaceholder,
              filled: true,
              fillColor: AppColors.dislikesAddButtonBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kFormInputRadius),
                borderSide: const BorderSide(color: AppColors.dislikesAddButtonBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kFormInputRadius),
                borderSide: const BorderSide(color: AppColors.dislikesAddButtonBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kFormInputRadius),
                borderSide: const BorderSide(color: AppColors.dislikesChipSelectedBorder, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: _kFormFieldGap),
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              if (width < 280) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildAddDislikePrimaryButton(c),
                    const SizedBox(height: _kFormButtonGap),
                    _buildCancelButton(c),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: _buildAddDislikePrimaryButton(c)),
                  const SizedBox(width: _kFormButtonGap),
                  _buildCancelButton(c),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddDislikePrimaryButton(DislikesController c) {
    return Obx(() {
      final text = c.customDislikeInput.value.trim();
      final enabled = text.isNotEmpty && c.canAddMoreCustomDislikes;
      return Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? c.submitCustomDislike : null,
            borderRadius: BorderRadius.circular(_kFormButtonRadius),
            child: Container(
              height: _kFormButtonHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppGradients.dislikesCta,
                borderRadius: BorderRadius.circular(_kFormButtonRadius),
                boxShadow: AppShadows.dislikesCta,
              ),
              alignment: Alignment.center,
              child: Text('Add Dislike', style: AppTextStyles.prefsDialogPrimaryBtn),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCancelButton(DislikesController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.cancelCustomDislikeForm,
        borderRadius: BorderRadius.circular(_kFormButtonRadius),
        child: Container(
          height: _kFormButtonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.dislikesAddButtonBg,
            borderRadius: BorderRadius.circular(_kFormButtonRadius),
            border: Border.all(color: AppColors.prefsDialogCancelBorder),
          ),
          alignment: Alignment.center,
          child: Text('Cancel', style: AppTextStyles.prefsDialogCancelBtn),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final c = Get.find<DislikesController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
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
        ],
      ),
    );
  }
}
