// lib/presentation/loved_one_preferences/views/loved_one_preferences_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/loved_one_preferences_controller.dart';
import '../models/hobby_category_model.dart';
import '../models/special_occasion_item.dart';

const double _kBackBtnSize = 48;
const double _kTopInset = 20;
const double _kProgressBarWidth = 24;
const double _kProgressBarHeight = 6;
const double _kProgressBarGap = 6;
const double _kProgressBarRadius = 3;
const double _kScrollTopPadding = 24;
const double _kOptionalPillPaddingV = 8;
const double _kOptionalPillPaddingH = 14;
const double _kTitleToSubtitleGap = 10;
const double _kSubtitleGap = 4;
const double _kSectionGap = 28;
const double _kSectionHeaderGap = 8;
const double _kSectionDescToButtonGap = 14;
const double _kAddButtonHeight = 48;
const double _kAddButtonRadius = 12;
const double _kCategoryCardRadius = 14;
const double _kCategoryCardPadding = 16;
const double _kCategoryTitleBottom = 10;
const double _kChipGap = 8;
const double _kChipRunSpacing = 8;
const double _kChipPaddingV = 10;
const double _kChipPaddingH = 14;
const double _kChipRadius = 999;
const double _kCategoryGap = 16;
const double _kSectionBubbleSize = 40;
const double _kOccasionListTop = 12;
const double _kOccasionRowPaddingV = 12;
const double _kOccasionRowPaddingH = 14;
const double _kOccasionRowRadius = 10;
const double _kOccasionRowGap = 8;
const double _kOccasionDeleteIconSize = 20;
const double _kFormCardRadius = 16;
const double _kFormCardPadding = 20;
const double _kFormTitleBottom = 16;
const double _kFormFieldGap = 16;
const double _kFormInputRadius = 12;
const double _kFormButtonHeight = 48;
const double _kFormButtonRadius = 12;
const double _kFormButtonGap = 12;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 16;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class LovedOnePreferencesScreen extends StatelessWidget {
  const LovedOnePreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.prefsPageBg,
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
                        _buildOptionalPill(context),
                        SizedBox(height: _kTitleToSubtitleGap),
                        _buildTitleSubtitle(context),
                        SizedBox(height: _kSectionGap),
                        _buildSpecialOccasionsSection(context),
                        SizedBox(height: _kSectionGap),
                        _buildHobbiesSection(context),
                        SizedBox(height: _kSectionGap),
                        _buildBottomCta(context),
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
              Positioned(
                top: _kTopInset,
                right: _kHorizontalPadding,
                child: _buildProgressIndicator(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    final c = Get.find<LovedOnePreferencesController>();
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
              color: AppColors.prefsBackBtnBg,
              shape: BoxShape.circle,
              boxShadow: AppShadows.prefsBackButton,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, size: 24, color: AppColors.prefsBackBtnIcon),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _progressBar(active: false),
        SizedBox(width: _kProgressBarGap),
        _progressBar(active: false),
        SizedBox(width: _kProgressBarGap),
        _progressBar(active: true),
      ],
    );
  }

  Widget _progressBar({required bool active}) {
    return Container(
      width: _kProgressBarWidth,
      height: _kProgressBarHeight,
      decoration: BoxDecoration(
        color: active ? AppColors.prefsProgressActive : AppColors.prefsProgressInactive,
        borderRadius: BorderRadius.circular(_kProgressBarRadius),
      ),
    );
  }

  Widget _buildOptionalPill(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: _kOptionalPillPaddingV, horizontal: _kOptionalPillPaddingH),
        decoration: BoxDecoration(
          color: AppColors.prefsOptionalPillBg,
          borderRadius: BorderRadius.circular(999),
          boxShadow: AppShadows.prefsOptionalPill,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, size: 14, color: AppColors.prefsOptionalPillText),
            const SizedBox(width: 6),
            Text('Optional', style: AppTextStyles.prefsOptionalPill),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSubtitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Tell CherishAI more about your loved one',
          style: AppTextStyles.prefsTitle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _kSubtitleGap),
        Text(
          'For a more personalized experience, let CherishAI get to know more',
          style: AppTextStyles.prefsSubtitle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _kSubtitleGap),
        Text(
          'All fields are optional — share what you know',
          style: AppTextStyles.prefsSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSpecialOccasionsSection(BuildContext context) {
    final c = Get.find<LovedOnePreferencesController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: _kSectionBubbleSize,
              height: _kSectionBubbleSize,
              decoration: BoxDecoration(
                color: AppColors.prefsSectionBubbleBg,
                borderRadius: BorderRadius.circular(10),
                boxShadow: AppShadows.prefsSectionBubble,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.calendar_today_outlined, size: 22, color: AppColors.prefsSectionTitle),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'SPECIAL OCCASIONS',
                style: AppTextStyles.prefsSectionTitle,
              ),
            ),
          ],
        ),
        SizedBox(height: _kSectionHeaderGap),
        Text(
          'Share important dates to help Cherish AI plan meaningful moments',
          style: AppTextStyles.prefsSectionDesc,
        ),
        SizedBox(height: _kSectionDescToButtonGap),
        _buildDashedAddButton(
          label: 'Add Special Occasion',
          onTap: c.openAddSpecialOccasionDialog,
        ),
        SizedBox(height: _kOccasionListTop),
        Obx(() {
          final length = c.specialOccasions.length;
          if (length == 0) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(length, (index) {
              final item = c.specialOccasions[index];
              return Padding(
                padding: EdgeInsets.only(bottom: index < length - 1 ? _kOccasionRowGap : 0),
                child: _buildOccasionRow(
                  item: item,
                  onRemove: () => c.removeOccasion(index),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  static const List<String> _kMonthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  static String _formatOccasionDate(DateTime d) {
    final month = d.month >= 1 && d.month <= 12 ? _kMonthNames[d.month - 1] : '';
    return '$month ${d.day}, ${d.year}';
  }

  Widget _buildOccasionRow({
    required SpecialOccasionItem item,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _kOccasionRowPaddingV, horizontal: _kOccasionRowPaddingH),
      decoration: BoxDecoration(
        color: AppColors.prefsSectionBubbleBg,
        borderRadius: BorderRadius.circular(_kOccasionRowRadius),
        border: Border.all(color: AppColors.prefsDialogInputBorder),
        boxShadow: AppShadows.prefsCategoryCard,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.name, style: AppTextStyles.prefsCategoryTitle),
                const SizedBox(height: 2),
                Text(
                  _formatOccasionDate(item.date),
                  style: AppTextStyles.prefsSectionDesc,
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(999),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.close, size: _kOccasionDeleteIconSize, color: AppColors.prefsSectionDesc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHobbiesSection(BuildContext context) {
    final c = Get.find<LovedOnePreferencesController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: _kSectionBubbleSize,
              height: _kSectionBubbleSize,
              decoration: BoxDecoration(
                color: AppColors.prefsSectionBubbleBg,
                borderRadius: BorderRadius.circular(10),
                boxShadow: AppShadows.prefsSectionBubble,
              ),
              alignment: Alignment.center,
              child: Icon(Icons.auto_awesome_outlined, size: 22, color: AppColors.prefsSectionTitle),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'HOBBIES & INTERESTS (max 1 per category)',
                style: AppTextStyles.prefsSectionTitle,
              ),
            ),
          ],
        ),
        SizedBox(height: _kSectionHeaderGap),
        Text(
          'Share what your loved one enjoys and feels drawn to, so Cherish AI can personalize care in ways that truly resonate',
          style: AppTextStyles.prefsSectionDesc,
        ),
        SizedBox(height: _kSectionHeaderGap + 4),
        ...HobbyCategoriesData.categories.map((cat) => Padding(
              padding: EdgeInsets.only(bottom: _kCategoryGap),
              child: _buildCategoryCard(context, cat),
            )),
        Obx(() {
          if (c.customHobbies.isEmpty) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: EdgeInsets.only(bottom: _kCategoryGap),
            child: _buildCustomHobbyCategoryCard(context, c),
          );
        }),
        _buildAddCustomHobbySection(context),
      ],
    );
  }

  /// Custom hobbies as selectable chips in a card (same design as category cards / dislikes custom chips).
  Widget _buildCustomHobbyCategoryCard(BuildContext context, LovedOnePreferencesController c) {
    return Obx(() {
      final customList = c.customHobbies.toList();
      if (customList.isEmpty) return const SizedBox.shrink();
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(_kCategoryCardPadding),
        decoration: BoxDecoration(
          color: AppColors.prefsCategoryCardTech,
          borderRadius: BorderRadius.circular(_kCategoryCardRadius),
          boxShadow: AppShadows.prefsCategoryCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Custom', style: AppTextStyles.prefsCategoryTitle),
            SizedBox(height: _kCategoryTitleBottom),
            Wrap(
              spacing: _kChipGap,
              runSpacing: _kChipRunSpacing,
              children: customList.map((label) {
                final selected = c.selectedByCategory[LovedOnePreferencesController.customHobbyCategoryKey] == label;
                return _buildChip(
                  label: label,
                  selected: selected,
                  onTap: () => c.onToggleChip(LovedOnePreferencesController.customHobbyCategoryKey, label),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  /// Inline Add Custom Hobby: form or button (same design as dislikes).
  Widget _buildAddCustomHobbySection(BuildContext context) {
    final c = Get.find<LovedOnePreferencesController>();
    return Obx(() {
      if (c.showCustomHobbyForm.value) {
        return _buildCustomHobbyForm(context, c);
      }
      return _buildAddCustomHobbyButton(context, c);
    });
  }

  Widget _buildAddCustomHobbyButton(BuildContext context, LovedOnePreferencesController c) {
    final disabled = c.customHobbies.length >= 2;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        final label = disabled
            ? (isNarrow ? 'Max 2 reached' : 'Add Custom Hobby (Max 2 reached)')
            : 'Add Custom Hobby';
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: disabled ? null : c.onAddCustomHobby,
            borderRadius: BorderRadius.circular(_kAddButtonRadius),
            child: SizedBox(
              width: double.infinity,
              height: _kAddButtonHeight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: disabled ? AppColors.prefsChipBorder : AppColors.prefsSectionBubbleBg,
                  borderRadius: BorderRadius.circular(_kAddButtonRadius),
                  border: Border.all(color: AppColors.prefsAddButtonBorder, width: 1),
                  boxShadow: AppShadows.prefsCategoryCard,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.add, size: 22, color: disabled ? AppColors.prefsSectionDesc : AppColors.prefsAddButtonText),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.prefsAddButton.copyWith(
                          color: disabled ? AppColors.prefsSectionDesc : AppColors.prefsAddButtonText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCustomHobbyForm(BuildContext context, LovedOnePreferencesController c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kFormCardPadding),
      decoration: BoxDecoration(
        color: AppColors.prefsSectionBubbleBg,
        borderRadius: BorderRadius.circular(_kFormCardRadius),
        border: Border.all(color: AppColors.prefsDialogInputBorder),
        boxShadow: AppShadows.prefsCategoryCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add Custom Hobby', style: AppTextStyles.prefsDialogTitle.copyWith(color: AppColors.prefsSectionTitle)),
          const SizedBox(height: _kFormTitleBottom),
          TextField(
            controller: c.customHobbyController,
            style: AppTextStyles.prefsDialogInput.copyWith(color: AppColors.prefsSectionTitle),
            decoration: InputDecoration(
              hintText: 'e.g., Stargazing, Collecting vinyl, Urban gardening',
              hintStyle: AppTextStyles.prefsDialogInputPlaceholder,
              filled: true,
              fillColor: AppColors.prefsDialogBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kFormInputRadius),
                borderSide: const BorderSide(color: AppColors.prefsDialogInputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kFormInputRadius),
                borderSide: const BorderSide(color: AppColors.prefsDialogInputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kFormInputRadius),
                borderSide: const BorderSide(color: AppColors.prefsChipSelectedBorder, width: 1.5),
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
                    _buildAddHobbyPrimaryButton(c),
                    const SizedBox(height: _kFormButtonGap),
                    _buildCancelHobbyButton(c),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: _buildAddHobbyPrimaryButton(c)),
                  const SizedBox(width: _kFormButtonGap),
                  _buildCancelHobbyButton(c),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddHobbyPrimaryButton(LovedOnePreferencesController c) {
    return Obx(() {
      final text = c.customHobbyInput.value.trim();
      final enabled = text.isNotEmpty && c.customHobbies.length < 2;
      return Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? c.addCustomHobby : null,
            borderRadius: BorderRadius.circular(_kFormButtonRadius),
            child: Container(
              height: _kFormButtonHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppGradients.prefsCta,
                borderRadius: BorderRadius.circular(_kFormButtonRadius),
                boxShadow: AppShadows.prefsCta,
              ),
              alignment: Alignment.center,
              child: Text('Add Hobby', style: AppTextStyles.prefsDialogPrimaryBtn),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCancelHobbyButton(LovedOnePreferencesController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.cancelCustomHobbyForm,
        borderRadius: BorderRadius.circular(_kFormButtonRadius),
        child: Container(
          height: _kFormButtonHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.prefsDialogBg,
            borderRadius: BorderRadius.circular(_kFormButtonRadius),
            border: Border.all(color: AppColors.prefsDialogCancelBorder),
          ),
          alignment: Alignment.center,
          child: Text('Cancel', style: AppTextStyles.prefsDialogCancelBtn),
        ),
      ),
    );
  }

  Widget _buildDashedAddButton({
    required String label,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_kAddButtonRadius),
          child: CustomPaint(
            painter: _DashedBorderPainter(
              color: AppColors.prefsAddButtonBorder,
              strokeWidth: 2,
              radius: _kAddButtonRadius,
            ),
            child: Container(
              height: _kAddButtonHeight,
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 20, color: AppColors.prefsAddButtonText),
                  const SizedBox(width: 8),
                  Text(label, style: AppTextStyles.prefsAddButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, HobbyCategoryModel category) {
    final c = Get.find<LovedOnePreferencesController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCategoryCardPadding),
      decoration: BoxDecoration(
        color: category.backgroundColor,
        borderRadius: BorderRadius.circular(_kCategoryCardRadius),
        boxShadow: AppShadows.prefsCategoryCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category.title, style: AppTextStyles.prefsCategoryTitle),
          SizedBox(height: _kCategoryTitleBottom),
          Obx(() {
            return Wrap(
              spacing: _kChipGap,
              runSpacing: _kChipRunSpacing,
              children: category.chips.map((chip) {
                final selected = c.selectedByCategory[category.key] == chip.id;
                return _buildChip(
                  label: chip.label,
                  selected: selected,
                  onTap: () => c.onToggleChip(category.key, chip.id),
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
            color: selected ? AppColors.prefsChipSelectedBg : AppColors.prefsChipBg,
            borderRadius: BorderRadius.circular(_kChipRadius),
            border: Border.all(
              color: selected ? AppColors.prefsChipSelectedBorder : AppColors.prefsChipBorder,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: selected ? AppTextStyles.prefsChipSelected : AppTextStyles.prefsChip,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    final c = Get.find<LovedOnePreferencesController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: Obx(() => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.isSubmitting.value ? null : c.onContinue,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: _kCtaHeight,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppGradients.prefsCta,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: AppShadows.prefsCta,
                ),
                child: Text('Continue', style: AppTextStyles.prefsCta),
              ),
            ),
          )),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });
  final Color color;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    const dashLength = 6.0;
    const gapLength = 4.0;
    double distance = 0;
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      while (distance < metric.length) {
        final next = distance + dashLength;
        final extractPath = metric.extractPath(distance, next.clamp(0.0, metric.length));
        canvas.drawPath(extractPath, paint);
        distance = next + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
