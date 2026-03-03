// lib/presentation/onboarding/views/individual_step2_add_loved_one_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/individual_step2_add_loved_one_controller.dart';

const double _kBackBtnSize = 48;
const double _kHeartCircleSize = 48;
const double _kTopInset = 20;
const double _kBackHeartGap = 12;
const double _kHeaderTitleTop = 12;
const double _kTitleSubtitleGap = 6;
const double _kScrollTopPadding = 24;
const double _kPhotoLabelBottom = 10;
const double _kPhotoToNameGap = 24;
const double _kNameLabelBottom = 8;
const double _kNameToRelationshipGap = 24;
const double _kSectionVerticalGap = 24;
const double _kRelationshipLabelBottom = 12;
const double _kCardGap = 16;
const double _kPhotoCircleSize = 100;
const double _kInputHeight = 48;
const double _kInputRadius = 999;
const double _kCardRadius = 20;
const double _kCardPaddingV = 20;
const double _kCardPaddingH = 24;
const double _kSectionTitleEmojiSize = 28;
const double _kSectionTitleBottom = 14;
const double _kTileRadius = 12;
const double _kTilePaddingV = 14;
const double _kTilePaddingH = 16;
const double _kTileGap = 10;
const double _kTileRunSpacing = 10;
const double _kTileEmojiSize = 24;
const double _kTileEmojiLabelGap = 8;
const double _kRelationshipGridBreakpoint = 420;
const double _kRelationshipTileExtentNarrow = 140;
const double _kRelationshipTileExtentWide = 124;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 16;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class IndividualStep2AddLovedOneScreen extends StatelessWidget {
  const IndividualStep2AddLovedOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.lovedOnePageBg,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kHorizontalPadding,
                  right: _kHorizontalPadding,
                  top: _kTopBarHeight + _kScrollTopPadding,
                  bottom: 24 + MediaQuery.paddingOf(context).bottom,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeartTitleSubtitle(context),
                        SizedBox(height: _kScrollTopPadding),
                        _buildPhotoSection(context),
                        SizedBox(height: _kPhotoToNameGap),
                        _buildNameSection(context),
                        SizedBox(height: _kSectionVerticalGap),
                        _buildAgeRangeSection(context),
                        SizedBox(height: _kSectionVerticalGap),
                        _buildGenderSection(context),
                        SizedBox(height: _kSectionVerticalGap),
                        _buildRelationshipTypeLabel(context),
                        SizedBox(height: _kRelationshipLabelBottom),
                        ...LovedOneRelationshipData.categories.map((cat) => Padding(
                              padding: EdgeInsets.only(bottom: _kCardGap),
                              child: _buildSectionCard(context, cat),
                            )),
                        SizedBox(height: _kPhotoToNameGap),
                        _buildBottomCta(context),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: _kTopInset,
                left: _kHorizontalPadding,
                right: _kHorizontalPadding,
                child: _buildHeader(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static double get _kTopBarHeight => _kTopInset + _kBackBtnSize;

  Widget _buildHeader(BuildContext context) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
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
              color: AppColors.lovedOneBackBtnBg,
              shape: BoxShape.circle,
              boxShadow: AppShadows.lovedOneBackButton,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, size: 24, color: AppColors.lovedOneBackBtnIcon),
          ),
        ),
      ),
    );
  }

  Widget _buildHeartTitleSubtitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _kHeartCircleSize,
          height: _kHeartCircleSize,
          decoration: BoxDecoration(
            color: AppColors.lovedOneHeartCircleBg,
            shape: BoxShape.circle,
            boxShadow: AppShadows.lovedOneHeartCircle,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.favorite, color: AppColors.white, size: 26),
        ),
        SizedBox(width: _kBackHeartGap),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add a loved one', style: AppTextStyles.lovedOneTitle),
                SizedBox(height: _kTitleSubtitleGap),
                Text(
                  "Let's begin with one person you want to show heartfelt love",
                  style: AppTextStyles.lovedOneSubtitle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoSection(BuildContext context) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
    return Column(
      children: [
        Text(
          'Photo (Optional)',
          style: AppTextStyles.lovedOnePhotoLabel,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: _kPhotoLabelBottom),
        SizedBox(
          width: _kPhotoCircleSize,
          height: _kPhotoCircleSize,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: c.openPhotoSheet,
                child: Container(
                  width: _kPhotoCircleSize,
                  height: _kPhotoCircleSize,
                  decoration: BoxDecoration(
                    color: AppColors.lovedOnePhotoCircleBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.lovedOnePhotoCircleBorder, width: 1.5),
                    boxShadow: AppShadows.lovedOnePhotoCircle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  child: Obx(() {
                    final path = c.lovedOnePhotoPath.value;
                    if (path.isNotEmpty) {
                      return ClipOval(
                        child: Image.file(
                          File(path),
                          fit: BoxFit.cover,
                          width: _kPhotoCircleSize,
                          height: _kPhotoCircleSize,
                        ),
                      );
                    }
                    return Icon(Icons.camera_alt_outlined, size: 36, color: AppColors.lovedOnePhotoIcon);
                  }),
                ),
              ),
              Positioned(
                right: 6,
                bottom: 6,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.openPhotoSheet,
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.lovedOnePhotoCircleBg,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.lovedOnePhotoCircleBorder, width: 1),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Color(0x1A000000),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.edit_rounded, size: 16, color: AppColors.lovedOnePhotoLabel),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameSection(BuildContext context) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.lovedOneCardTitle.copyWith(color: AppColors.lovedOneCardLabel),
            children: [
              const TextSpan(text: "What's their name? "),
              TextSpan(
                text: '*',
                style: TextStyle(color: AppColors.lovedOneRequiredAsterisk, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(height: _kNameLabelBottom),
        SizedBox(
          height: _kInputHeight,
          child: TextField(
            controller: c.nameController,
            style: AppTextStyles.lovedOneInput,
            decoration: InputDecoration(
              hintText: 'Name or nickname',
              hintStyle: AppTextStyles.lovedOneInputPlaceholder,
              filled: true,
              fillColor: AppColors.lovedOneInputBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.lovedOneInputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.lovedOneInputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.lovedOnePhotoLabel, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  static const List<String> _kAgeRangeOptions = [
    '0–5',
    '6–12',
    '13–18',
    '19–30',
    '31–50',
    '51+',
  ];

  static const List<String> _kGenderOptions = ['Male', 'Female'];

  Widget _buildAgeRangeSection(BuildContext context) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.lovedOneCardTitle.copyWith(color: AppColors.lovedOneCardLabel),
            children: [
              const TextSpan(text: 'Age range of loved one '),
              TextSpan(
                text: '*',
                style: TextStyle(color: AppColors.lovedOneRequiredAsterisk, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(height: _kRelationshipLabelBottom),
        Obx(() => Wrap(
              spacing: _kTileGap,
              runSpacing: _kTileRunSpacing,
              children: _kAgeRangeOptions.map((value) {
                final selected = c.selectedAgeRange.value == value;
                return _buildChoiceChip(
                  context: context,
                  label: value,
                  selected: selected,
                  onTap: () => c.selectAgeRange(value),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildGenderSection(BuildContext context) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.lovedOneCardTitle.copyWith(color: AppColors.lovedOneCardLabel),
            children: [
              const TextSpan(text: 'Gender of loved one '),
              TextSpan(
                text: '*',
                style: TextStyle(color: AppColors.lovedOneRequiredAsterisk, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        SizedBox(height: _kRelationshipLabelBottom),
        Obx(() => Wrap(
              spacing: _kTileGap,
              runSpacing: _kTileRunSpacing,
              children: _kGenderOptions.map((value) {
                final selected = c.selectedGender.value == value;
                return _buildChoiceChip(
                  context: context,
                  label: value,
                  selected: selected,
                  onTap: () => c.selectGender(value),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildChoiceChip({
    required BuildContext context,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kTileRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: _kTilePaddingV, horizontal: _kTilePaddingH),
          decoration: BoxDecoration(
            color: selected ? AppColors.lovedOneTileSelectedBg : AppColors.lovedOneTileBg,
            borderRadius: BorderRadius.circular(_kTileRadius),
            border: Border.all(
              color: selected ? AppColors.lovedOneTileSelectedBorder : AppColors.lovedOneTileBorder,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected ? AppShadows.lovedOneTileSelected : AppShadows.lovedOneTile,
          ),
          child: Text(
            label,
            style: AppTextStyles.lovedOneTileLabel,
          ),
        ),
      ),
    );
  }

  Widget _buildRelationshipTypeLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.lovedOneCardTitle.copyWith(color: AppColors.lovedOneCardLabel),
        children: [
          const TextSpan(text: 'Relationship Type (Choose 1) '),
          TextSpan(
            text: '*',
            style: TextStyle(color: AppColors.lovedOneRequiredAsterisk, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, LovedOneRelationshipCategory category) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: _kCardPaddingV, horizontal: _kCardPaddingH),
      decoration: BoxDecoration(
        color: AppColors.lovedOneSectionCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.lovedOneSectionCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(category.titleEmoji, style: const TextStyle(fontSize: _kSectionTitleEmojiSize)),
          const SizedBox(height: 6),
          Text(
            category.title,
            style: AppTextStyles.lovedOneCardTitle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _kSectionTitleBottom),
          LayoutBuilder(
            builder: (context, constraints) {
              return Obx(() => _buildOptionsGrid(
                    context: context,
                    constraints: constraints,
                    options: category.options,
                    selectedKey: c.selectedRelationshipKey.value,
                    onSelect: c.onSelectRelationship,
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsGrid({
    required BuildContext context,
    required BoxConstraints constraints,
    required List<LovedOneRelationshipOption> options,
    required String? selectedKey,
    required void Function(String) onSelect,
  }) {
    final crossAxisCount = constraints.maxWidth < _kRelationshipGridBreakpoint ? 2 : 3;
    final baseExtent = constraints.maxWidth < _kRelationshipGridBreakpoint
        ? _kRelationshipTileExtentNarrow
        : _kRelationshipTileExtentWide;
    final t = MediaQuery.textScaleFactorOf(context).clamp(1.0, 1.25);
    final extent = (baseExtent * t).ceilToDouble();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: _kTileGap,
        mainAxisSpacing: _kTileRunSpacing,
        mainAxisExtent: extent,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final opt = options[index];
        final selected = selectedKey == opt.key;
        return _RelationshipOptionTile(
          context: context,
          option: opt,
          selected: selected,
          onTap: () => onSelect(opt.key),
        );
      },
    );
  }

  Widget _RelationshipOptionTile({
    required BuildContext context,
    required LovedOneRelationshipOption option,
    required bool selected,
    required VoidCallback onTap,
  }) {
    final fontSize = valueByBreakpoint<double>(
      context,
      [12, 14, 14, 14, 14],
    );
    final labelStyle = AppTextStyles.lovedOneTileLabel.copyWith(fontSize: fontSize);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kTileRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.lovedOneTileSelectedBg : AppColors.lovedOneTileBg,
            borderRadius: BorderRadius.circular(_kTileRadius),
            border: Border.all(
              color: selected ? AppColors.lovedOneTileSelectedBorder : AppColors.lovedOneTileBorder,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected ? AppShadows.lovedOneTileSelected : AppShadows.lovedOneTile,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                option.emoji,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: _kTileEmojiSize),
              ),
              const SizedBox(height: 6),
              Expanded(
                child: Center(
                  child: Text(
                    option.label,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.visible,
                    style: labelStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    final c = Get.find<IndividualStep2AddLovedOneController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: Obx(() => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.isSubmitting.value ? null : c.onSaveAndContinue,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: _kCtaHeight,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: c.isSubmitting.value ? null : AppGradients.lovedOneCta,
                  color: c.isSubmitting.value ? AppColors.lovedOneTileBorder : null,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: AppShadows.lovedOneCta,
                ),
                child: Text('Save & Continue', style: AppTextStyles.lovedOneCta),
              ),
            ),
          )),
    );
  }
}
