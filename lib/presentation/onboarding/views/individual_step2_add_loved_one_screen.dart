// lib/presentation/onboarding/views/individual_step2_add_loved_one_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
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
                  bottom: _kCtaHeight + _kCtaBottomPadding + 24,
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
                        SizedBox(height: _kNameToRelationshipGap),
                        _buildRelationshipTypeLabel(context),
                        SizedBox(height: _kRelationshipLabelBottom),
                        ...LovedOneRelationshipData.categories.map((cat) => Padding(
                              padding: EdgeInsets.only(bottom: _kCardGap),
                              child: _buildSectionCard(context, cat),
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
                child: _buildHeader(context),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomCta(context),
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
        GestureDetector(
          onTap: c.onTapAddPhoto,
          child: Container(
            width: _kPhotoCircleSize,
            height: _kPhotoCircleSize,
            decoration: BoxDecoration(
              color: AppColors.lovedOnePhotoCircleBg,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lovedOnePhotoCircleBorder, width: 1.5),
              boxShadow: AppShadows.lovedOnePhotoCircle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.camera_alt_outlined, size: 36, color: AppColors.lovedOnePhotoIcon),
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
              final cardInner = constraints.maxWidth;
              final twoColWidth = (cardInner - _kTileGap) / 2;
              return Obx(() => Wrap(
                    spacing: _kTileGap,
                    runSpacing: _kTileRunSpacing,
                    children: category.options.map((opt) {
                      final selected = c.selectedRelationshipKey.value == opt.key;
                      return SizedBox(
                        width: twoColWidth,
                        child: _buildTile(
                          context: context,
                          option: opt,
                          selected: selected,
                          onTap: () => c.onSelectRelationship(opt.key),
                        ),
                      );
                    }).toList(),
                  ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required BuildContext context,
    required LovedOneRelationshipOption option,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option.emoji, style: const TextStyle(fontSize: _kTileEmojiSize)),
              SizedBox(width: _kTileEmojiLabelGap),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    option.label,
                    style: AppTextStyles.lovedOneTileLabel,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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
    return Container(
      padding: EdgeInsets.fromLTRB(
        _kHorizontalPadding,
        12,
        _kHorizontalPadding,
        _kCtaBottomPadding + MediaQuery.paddingOf(context).bottom,
      ),
      child: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
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
        ),
      ),
    );
  }
}
