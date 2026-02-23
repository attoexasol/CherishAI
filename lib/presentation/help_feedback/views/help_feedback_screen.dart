// lib/presentation/help_feedback/views/help_feedback_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/help_feedback_controller.dart';

const double _kBackBtnSize = 44;
const double _kBackIconSize = 22;
const double _kHorizontalPadding = 24;
const double _kTitleSubtitleGap = 8;
const double _kCardRadius = 20;
const double _kCardPadding = 20;
const double _kOptionRadius = 12;
const double _kOptionPadding = 14;
const double _kSubmitBtnHeight = 52;
const double _kSubmitBtnRadius = 14;
const double _kMaxContentWidth = 480;

class HelpFeedbackScreen extends StatelessWidget {
  const HelpFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.helpFeedbackPageBgTop,
              AppColors.helpFeedbackPageBgEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kHorizontalPadding,
                    right: _kHorizontalPadding,
                    top: 16,
                    bottom: 32,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Obx(() {
                        final c = Get.find<HelpFeedbackController>();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Help & Feedback',
                              style: AppTextStyles.helpFeedbackTitle,
                            ),
                            const SizedBox(height: _kTitleSubtitleGap),
                            Text(
                              "We're here to listen. Your message helps Cherish AI grow with care.",
                              style: AppTextStyles.helpFeedbackSubtitle,
                            ),
                            const SizedBox(height: 24),
                            _buildTopicCard(context, c),
                            const SizedBox(height: 16),
                            _buildTellUsMoreCard(context, c),
                            const SizedBox(height: 16),
                            _buildCheckboxRow(context, c),
                            const SizedBox(height: 24),
                            _buildSubmitButton(context, c),
                            const SizedBox(height: 24),
                            _buildFooter(context),
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

  Widget _buildAppBar(BuildContext context) {
    final c = Get.find<HelpFeedbackController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(_kBackBtnSize / 2),
              child: Container(
                width: _kBackBtnSize,
                height: _kBackBtnSize,
                decoration: BoxDecoration(
                  color: AppColors.helpFeedbackBackBtnBg,
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.helpFeedbackCard,
                ),
                child: Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.helpFeedbackBackIcon),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, HelpFeedbackController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.helpFeedbackCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.helpFeedbackCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What would you like to share?', style: AppTextStyles.helpFeedbackSectionTitle),
          const SizedBox(height: 14),
          ...HelpFeedbackController.topics.map((topic) {
            final isSelected = c.selectedTopicId.value == topic.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => c.selectTopic(topic.id),
                  borderRadius: BorderRadius.circular(_kOptionRadius),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: _kOptionPadding, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.helpFeedbackOptionBorder.withValues(alpha: 0.2) : null,
                      borderRadius: BorderRadius.circular(_kOptionRadius),
                      border: Border.all(
                        color: isSelected ? AppColors.helpFeedbackSectionTitle : AppColors.helpFeedbackOptionBorder,
                      ),
                    ),
                    child: Text(topic.label, style: AppTextStyles.helpFeedbackOptionText),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTellUsMoreCard(BuildContext context, HelpFeedbackController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.helpFeedbackCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.helpFeedbackCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Tell us more ', style: AppTextStyles.helpFeedbackSectionTitle),
              Text('*', style: AppTextStyles.helpFeedbackSectionTitle.copyWith(color: AppColors.helpFeedbackRequiredAsterisk)),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 5,
            maxLength: HelpFeedbackController.maxMessageLength,
            onChanged: c.setMessage,
            decoration: InputDecoration(
              hintText: "Share your thoughts, questions, or experience. You don't need to be technical — we'll figure it out.",
              hintStyle: AppTextStyles.helpFeedbackPlaceholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kOptionRadius),
                borderSide: const BorderSide(color: AppColors.helpFeedbackOptionBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kOptionRadius),
                borderSide: const BorderSide(color: AppColors.helpFeedbackOptionBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kOptionRadius),
                borderSide: const BorderSide(color: AppColors.helpFeedbackSectionTitle, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
            style: AppTextStyles.helpFeedbackOptionText,
          ),
          const SizedBox(height: 6),
          Obx(() => Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${c.message.value.length}/${HelpFeedbackController.maxMessageLength} characters',
                  style: AppTextStyles.helpFeedbackCounter,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow(BuildContext context, HelpFeedbackController c) {
    return Obx(() => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => c.setAllowContact(!c.allowContact.value),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: c.allowContact.value,
                      onChanged: (v) => c.setAllowContact(v ?? false),
                      activeColor: AppColors.helpFeedbackSectionTitle,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You can contact me if you need more details',
                      style: AppTextStyles.helpFeedbackCheckboxLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildSubmitButton(BuildContext context, HelpFeedbackController c) {
    return Obx(() => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: c.canSubmit ? c.onSubmit : null,
            borderRadius: BorderRadius.circular(_kSubmitBtnRadius),
            child: Container(
              height: _kSubmitBtnHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: c.canSubmit ? AppGradients.helpFeedbackSubmitBtn : null,
                color: c.canSubmit ? null : AppColors.manageSubCtaDisabledBg,
                borderRadius: BorderRadius.circular(_kSubmitBtnRadius),
                boxShadow: c.canSubmit ? AppShadows.helpFeedbackSubmitBtn : null,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (c.canSubmit) Icon(Icons.send, size: 20, color: AppColors.manageSubUpgradeBtnText),
                  if (c.canSubmit) const SizedBox(width: 8),
                  Text(
                    'Submit',
                    style: AppTextStyles.helpFeedbackSubmit.copyWith(
                      color: c.canSubmit ? AppColors.manageSubUpgradeBtnText : AppColors.manageSubCtaDisabledText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Text(
        'Visit our website to learn more about Cherish AI, your love assistant.',
        style: AppTextStyles.helpFeedbackFooter,
        textAlign: TextAlign.center,
      ),
    );
  }
}
