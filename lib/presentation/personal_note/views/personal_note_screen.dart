// lib/presentation/personal_note/views/personal_note_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/personal_note_controller.dart';

const double _kTopInset = 20;
const double _kBackIconSize = 22;
const double _kLogoCircleSize = 40;
const double _kLogoHeartSize = 22;
const double _kUnderlineHeight = 2;
const double _kProgressBarHeight = 6;
const double _kProgressBarRadius = 3;
const double _kBubbleSize = 56;
const double _kBubbleIconSize = 28;
const double _kCardRadius = 20;
const double _kInputRadius = 12;
const double _kInputMinHeight = 120;
const double _kHelperBoxRadius = 12;
const double _kCtaHeight = 56;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;

class PersonalNoteScreen extends StatelessWidget {
  const PersonalNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.notePageBg,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              _buildProgressRow(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kHorizontalPadding,
                    right: _kHorizontalPadding,
                    top: 24,
                    bottom: 24 + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBubble(context),
                          const SizedBox(height: 20),
                          Text(
                            'Add a Personal Note',
                            style: AppTextStyles.noteTitle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Help Cherish AI understand your relationship better for more personalized messages',
                            style: AppTextStyles.noteSubtitle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          _buildCard(context),
                          const SizedBox(height: 24),
                          _buildBottomCta(context),
                        ],
                      ),
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
    final c = Get.find<PersonalNoteController>();
    return Padding(
      padding: EdgeInsets.only(
        left: _kHorizontalPadding,
        right: _kHorizontalPadding,
        top: _kTopInset,
        bottom: 16,
      ),
      child: Row(
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
                    Icon(Icons.arrow_back_ios_new, size: _kBackIconSize * 0.7, color: AppColors.noteBackText),
                    const SizedBox(width: 4),
                    Text('Back', style: AppTextStyles.noteBack),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: _kLogoCircleSize,
                    height: _kLogoCircleSize,
                    decoration: BoxDecoration(
                      color: AppColors.noteLogoHeartBg,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.prefsSectionBubble,
                    ),
                    child: Icon(Icons.favorite, size: _kLogoHeartSize, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Text('Cherish AI', style: AppTextStyles.noteLogo),
                ],
              ),
              const SizedBox(height: 4),
              _buildUnderline(),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onSkip,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Text('Skip', style: AppTextStyles.noteSkip),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnderline() {
    return Container(
      height: _kUnderlineHeight,
      width: 140,
      decoration: BoxDecoration(
        color: AppColors.noteUnderline,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  Widget _buildProgressRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _kHorizontalPadding, right: _kHorizontalPadding, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_kProgressBarRadius),
              child: SizedBox(
                height: _kProgressBarHeight,
                child: LinearProgressIndicator(
                  value: 6 / 7,
                  backgroundColor: AppColors.noteProgressBg,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.noteProgressFill),
                  minHeight: _kProgressBarHeight,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text('Step 6 of 7', style: AppTextStyles.noteStepLabel),
        ],
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return Center(
      child: Container(
        width: _kBubbleSize,
        height: _kBubbleSize,
        decoration: BoxDecoration(
          color: AppColors.noteBubbleBg,
          shape: BoxShape.circle,
          boxShadow: AppShadows.noteBubble,
        ),
        child: Icon(Icons.auto_awesome, size: _kBubbleIconSize, color: AppColors.noteSeeMoreIcon),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final c = Get.find<PersonalNoteController>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.noteCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.noteCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined, size: 18, color: AppColors.noteThumbsUpIcon),
              const SizedBox(width: 8),
              Text('Personal note ', style: AppTextStyles.noteLabel),
              Text('*', style: AppTextStyles.noteLabel.copyWith(color: AppColors.noteRequiredAsterisk)),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: c.noteController,
            maxLength: PersonalNoteController.maxLength,
            maxLines: 5,
            minLines: 4,
            style: AppTextStyles.noteInput,
            decoration: InputDecoration(
              hintText:
                  "Susan is someone I often see at the bus station. I'm developing feelings and want to be kind, subtle, and respectful.",
              hintStyle: AppTextStyles.noteInputPlaceholder,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.noteInputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.noteInputBorder, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.noteLogoHeartBg, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              counterText: '',
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(() => Text(
                  '${c.charCount.value}/${PersonalNoteController.maxLength}',
                  style: AppTextStyles.noteCounter,
                )),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.noteHelperBoxBg,
              borderRadius: BorderRadius.circular(_kHelperBoxRadius),
            ),
            child: Text(
              'Share anything that helps Cherish AI understand this relationship better. A few sentences are enough.',
              style: AppTextStyles.noteHelper,
            ),
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onSeeMoreExamples,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 16, color: AppColors.noteSeeMoreIcon),
                    const SizedBox(width: 8),
                    Text('See more examples', style: AppTextStyles.noteSeeMore),
                    const SizedBox(width: 6),
                    Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.noteSeeMoreText),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    final c = Get.find<PersonalNoteController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      child: Obx(() {
        final enabled = c.canContinue.value && !c.isSubmitting.value;
        return Material(
          color: enabled ? null : AppColors.noteCtaDisabledBg,
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            onTap: enabled ? c.onContinue : null,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: _kCtaHeight,
              decoration: enabled
                  ? BoxDecoration(
                      gradient: AppGradients.noteCtaEnabled,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: AppShadows.noteCtaEnabled,
                    )
                  : null,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Continue', style: AppTextStyles.noteCta),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20, color: AppColors.noteCtaText),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
