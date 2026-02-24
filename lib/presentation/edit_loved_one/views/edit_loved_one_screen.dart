// lib/presentation/edit_loved_one/views/edit_loved_one_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/edit_loved_one_controller.dart';
import '../models/edit_loved_one_models.dart';
import '../../onboarding/controllers/individual_step3_relationship_goals_controller.dart';

const double _kMaxContentWidth = 672;
const double _kPaddingH = 24;
const double _kPaddingTop = 32;
const double _kSectionGap = 32;
const double _kCardRadius = 24;
const double _kCardRadiusSmall = 16;
const double _kCardPadding = 24;
const double _kInputRadius = 12;
const double _kHeaderPaddingV = 16;
const double _kBackIconSize = 20;
const double _kSectionIconSize = 20;
const double _kAvatarSize = 128;
const double _kCameraBadgeSize = 40;
const double _kSaveBtnPaddingH = 16;
const double _kSaveBtnPaddingV = 12;
const double _kSaveBtnRadius = 999;
const double _kDashedBtnPaddingV = 16;
const double _kDashedBtnPaddingH = 24;
const double _kDashedBtnRadius = 16;
const double _kInfoCardPadding = 24;
const double _kInfoCardRadius = 16;
const double _kSecondaryRowPadding = 12;
const double _kSecondaryRowRadius = 12;
const double _kCheckboxSize = 20;
const double _kCategoryCardPadding = 16;
const double _kCategoryCardRadius = 12;
const double _kChipPaddingH = 12;
const double _kChipPaddingV = 6;
const double _kChipRadius = 999;
const double _kChipGap = 8;
const double _kBottomSavePadding = 24;

class EditLovedOneScreen extends StatelessWidget {
  const EditLovedOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditLovedOneController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final paddingH = MediaQuery.sizeOf(context).width < Breakpoints.sm ? 16.0 : _kPaddingH;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.editLovedOnePageBg,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, c, paddingH),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: paddingH,
                    right: paddingH,
                    top: _kPaddingTop,
                    bottom: _kBottomSavePadding + bottomPadding,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildPhotoCard(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildBasicInfo(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildImportantDates(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildContact(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildRelationshipGoals(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildHobbies(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildDislikes(context, c),
                          const SizedBox(height: _kSectionGap),
                          _buildBottomSave(context, c, bottomPadding),
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

  Widget _buildHeader(BuildContext context, EditLovedOneController c, double paddingH) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: _kHeaderPaddingV),
      decoration: BoxDecoration(
        color: AppColors.editLovedOneHeaderBg,
        border: Border(bottom: BorderSide(color: AppColors.editLovedOneHeaderBorder, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.editLovedOneBackText),
                    const SizedBox(width: 4),
                    Text('Back', style: AppTextStyles.editLovedOneBack),
                  ],
                ),
              ),
            ),
          ),
          Text('Edit Profile', style: AppTextStyles.editLovedOneTitle),
          Obx(() => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.isSaving.value ? null : () => c.onSaveTopBar(),
              borderRadius: BorderRadius.circular(_kSaveBtnRadius),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: _kSaveBtnPaddingH, vertical: _kSaveBtnPaddingV),
                decoration: BoxDecoration(
                  gradient: c.isSaving.value ? null : AppGradients.profileSaveBtn,
                  color: c.isSaving.value ? AppColors.editLovedOnePlaceholder.withValues(alpha: 0.5) : null,
                  borderRadius: BorderRadius.circular(_kSaveBtnRadius),
                  boxShadow: c.isSaving.value ? null : AppShadows.profileSaveBtn,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (c.isSaving.value)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    else
                      Icon(Icons.save_outlined, size: 16, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      c.isSaving.value ? 'Saving...' : 'Save',
                      style: AppTextStyles.profileSaveBtn.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPhotoCard(BuildContext context, EditLovedOneController c) {
    return GestureDetector(
      onTap: c.onChangePhoto,
      child: Container(
        padding: const EdgeInsets.all(_kCardPadding * 1.33),
        decoration: BoxDecoration(
          color: AppColors.editLovedOneCardBg,
          borderRadius: BorderRadius.circular(_kCardRadius),
          border: Border.all(color: AppColors.editLovedOneCardBorder),
          boxShadow: AppShadows.editLovedOnePhotoCard,
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: _kAvatarSize,
                  height: _kAvatarSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.lovedOnesAvatarBg,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.lovedOnesAvatarRing, width: 4),
                    boxShadow: AppShadows.editLovedOnePhotoCard,
                  ),
                  alignment: Alignment.center,
                  child: Text('💑', style: TextStyle(fontSize: 48)),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: _kCameraBadgeSize,
                    height: _kCameraBadgeSize,
                    decoration: BoxDecoration(
                      gradient: AppGradients.editLovedOneCameraBadge,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.editLovedOneCard,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.camera_alt, size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Click to change photo', style: AppTextStyles.editLovedOnePhotoChange),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo(BuildContext context, EditLovedOneController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, size: _kSectionIconSize, color: AppColors.editLovedOneSectionIcon),
            const SizedBox(width: 8),
            Text('Basic Information', style: AppTextStyles.editLovedOneSectionHeader),
          ],
        ),
        const SizedBox(height: 16),
        _buildInputCard(
          label: 'Name',
          required: true,
          controller: c.nameCtrl,
          placeholder: 'Enter name',
        ),
        const SizedBox(height: 16),
        _buildDropdownCard(
          label: 'Relationship',
          required: true,
          value: c.relationship.value,
          items: [
            DropdownMenuItem(value: null, child: Text('Select relationship', style: AppTextStyles.editLovedOneInputPlaceholder)),
            ...c.relationshipOptions.map((o) => DropdownMenuItem(
              value: o.value,
              child: Text(
                o.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.editLovedOneDropdownItem,
              ),
            )),
          ],
          onChanged: (v) => c.relationship.value = v ?? '',
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.editLovedOneInfoCardBgStart,
                AppColors.editLovedOneInfoCardBgEnd,
              ],
            ),
            borderRadius: BorderRadius.circular(_kCardRadiusSmall),
            border: Border.all(color: AppColors.editLovedOneInfoCardBorder),
            boxShadow: AppShadows.editLovedOneCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.auto_awesome, size: _kSectionIconSize, color: AppColors.editLovedOneInfoCardIcon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('👉 Personal note (optional)', style: AppTextStyles.editLovedOneLabel),
                        const SizedBox(height: 4),
                        Text(
                          'Share anything that helps Cherish AI understand this relationship better. A few sentences are enough.',
                          style: AppTextStyles.editLovedOneInfoCardBody.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: c.personalNoteCtrl,
                maxLines: 4,
                minLines: 4,
                maxLength: EditLovedOneController.personalNoteMaxLength,
                style: AppTextStyles.editLovedOneInput,
                decoration: InputDecoration(
                  hintText: 'e.g., Susan is someone I often see at the bus station...',
                  hintStyle: AppTextStyles.editLovedOneInputPlaceholder,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kInputRadius),
                    borderSide: BorderSide(color: AppColors.editLovedOneInfoCardBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kInputRadius),
                    borderSide: BorderSide(color: AppColors.editLovedOneInfoCardBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kInputRadius),
                    borderSide: BorderSide(color: AppColors.editLovedOneInputFocusBorder, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Used by AI to personalize messages and suggestions',
                      style: AppTextStyles.editLovedOnePersonalNoteHint,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: c.personalNoteCtrl,
                      builder: (context, value, _) {
                        final len = value.text.length;
                        return Text(
                          '$len/${EditLovedOneController.personalNoteMaxLength}',
                          style: len > 280
                              ? AppTextStyles.editLovedOneCounterWarning
                              : AppTextStyles.editLovedOneCounter,
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputCard({
    required String label,
    required bool required,
    required TextEditingController controller,
    required String placeholder,
  }) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.editLovedOneCardBg,
        borderRadius: BorderRadius.circular(_kCardRadiusSmall),
        border: Border.all(color: AppColors.editLovedOneCardBorder),
        boxShadow: AppShadows.editLovedOneCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '$label ',
              style: AppTextStyles.editLovedOneLabel,
              children: required ? [TextSpan(text: '*', style: TextStyle(color: AppColors.editLovedOneRequiredAsterisk))] : null,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: AppTextStyles.editLovedOneInput,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: AppTextStyles.editLovedOneInputPlaceholder,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kInputRadius)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: BorderSide(color: AppColors.editLovedOneInputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: BorderSide(color: AppColors.editLovedOneInputFocusBorder, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownCard({
    required String label,
    required bool required,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.editLovedOneCardBg,
        borderRadius: BorderRadius.circular(_kCardRadiusSmall),
        border: Border.all(color: AppColors.editLovedOneCardBorder),
        boxShadow: AppShadows.editLovedOneCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              text: '$label ',
              style: AppTextStyles.editLovedOneLabel,
              children: required ? [TextSpan(text: '*', style: TextStyle(color: AppColors.editLovedOneRequiredAsterisk))] : null,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value.isEmpty ? null : value,
            isExpanded: true,
            menuMaxHeight: 320,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kInputRadius)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: BorderSide(color: AppColors.editLovedOneInputBorder),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: AppTextStyles.editLovedOneDropdownItem,
            items: [DropdownMenuItem(value: null, child: Text('Select relationship', style: AppTextStyles.editLovedOneInputPlaceholder)), ...items],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildImportantDates(BuildContext context, EditLovedOneController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, size: _kSectionIconSize, color: AppColors.editLovedOneSectionIcon),
            const SizedBox(width: 8),
            Text('Important Dates', style: AppTextStyles.editLovedOneSectionHeader),
          ],
        ),
        const SizedBox(height: 16),
        _buildDateCard(label: '🎂 Birthday', controller: c.birthdayCtrl, onTap: c.onPickBirthday),
        const SizedBox(height: 16),
        _buildDateCard(label: '💕 Anniversary', controller: c.anniversaryCtrl, onTap: c.onPickAnniversary),
        Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: c.customDates.length,
          itemBuilder: (context, i) {
            final e = c.customDates[i];
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _buildCustomDateRow(c, e, i + 1),
            );
          },
        )),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: c.onAddImportantDate,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: _kDashedBtnPaddingV, horizontal: _kDashedBtnPaddingH),
            decoration: BoxDecoration(
              color: AppColors.editLovedOneDashedBtnBg,
              borderRadius: BorderRadius.circular(_kDashedBtnRadius),
              border: Border.all(color: AppColors.editLovedOneDashedBtnBorder, width: 2, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 20, color: AppColors.editLovedOneDashedBtnText),
                const SizedBox(width: 8),
                Text('Add Important Date', style: AppTextStyles.editLovedOneDashedBtn),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.calendar_today,
          title: 'Date Reminders',
          body: 'Cherish AI will remind you about these special dates in advance, helping you prepare thoughtful celebrations and gifts.',
        ),
      ],
    );
  }

  Widget _buildDateCard({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(_kCardPadding),
        decoration: BoxDecoration(
          color: AppColors.editLovedOneCardBg,
          borderRadius: BorderRadius.circular(_kCardRadiusSmall),
          border: Border.all(color: AppColors.editLovedOneCardBorder),
          boxShadow: AppShadows.editLovedOneCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.editLovedOneLabel),
            const SizedBox(height: 8),
            AbsorbPointer(
              child: TextField(
                controller: controller,
                style: AppTextStyles.editLovedOneInput,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today, size: 20, color: AppColors.editLovedOneSectionIcon),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kInputRadius)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kInputRadius),
                    borderSide: BorderSide(color: AppColors.editLovedOneInputBorder),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDateRow(EditLovedOneController c, CustomDateEntry e, int index) {
    final id = e.id;
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.editLovedOneCardBg,
        borderRadius: BorderRadius.circular(_kCardRadiusSmall),
        border: Border.all(color: AppColors.editLovedOneCardBorder),
        boxShadow: AppShadows.editLovedOneCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('✨ Custom Date $index', style: AppTextStyles.editLovedOneLabel),
              IconButton(
                onPressed: () => c.onRemoveCustomDate(id),
                icon: Icon(Icons.close, size: 20, color: AppColors.editLovedOneSectionIcon),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Occasion Name', style: AppTextStyles.editLovedOneCustomDislikeLabel),
          const SizedBox(height: 4),
          TextFormField(
            key: ValueKey('$id-occasion'),
            initialValue: e.occasion,
            onChanged: (v) => c.onUpdateCustomDate(id, 'occasion', v),
            decoration: InputDecoration(
              hintText: 'e.g., First Date, Graduation, etc.',
              hintStyle: AppTextStyles.editLovedOneInputPlaceholder,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kInputRadius)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: BorderSide(color: AppColors.editLovedOneInputBorder),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          Text('Date', style: AppTextStyles.editLovedOneCustomDislikeLabel),
          const SizedBox(height: 4),
          TextFormField(
            key: ValueKey('$id-date'),
            initialValue: e.date,
            onChanged: (v) => c.onUpdateCustomDate(id, 'date', v),
            decoration: InputDecoration(
              hintText: 'YYYY-MM-DD',
              hintStyle: AppTextStyles.editLovedOneInputPlaceholder,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kInputRadius)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: BorderSide(color: AppColors.editLovedOneInputBorder),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String body}) {
    return Container(
      padding: const EdgeInsets.all(_kInfoCardPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.editLovedOneInfoCardBgStart,
            AppColors.editLovedOneInfoCardBgEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(_kInfoCardRadius),
        border: Border.all(color: AppColors.editLovedOneInfoCardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: _kSectionIconSize, color: AppColors.editLovedOneInfoCardIcon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.editLovedOneInfoCardTitle),
                const SizedBox(height: 4),
                Text(body, style: AppTextStyles.editLovedOneInfoCardBody),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContact(BuildContext context, EditLovedOneController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.phone, size: _kSectionIconSize, color: AppColors.editLovedOneSectionIcon),
            const SizedBox(width: 8),
            Text('Contact Information', style: AppTextStyles.editLovedOneSectionHeader),
          ],
        ),
        const SizedBox(height: 16),
        _buildInputCard(label: '📱 Phone Number', required: false, controller: c.phoneCtrl, placeholder: '+1 234 567 8900'),
        const SizedBox(height: 16),
        _buildInputCard(label: 'Email', required: false, controller: c.emailCtrl, placeholder: 'jane.doe@example.com'),
      ],
    );
  }

  Widget _buildRelationshipGoals(BuildContext context, EditLovedOneController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.flag_outlined, size: _kSectionIconSize, color: AppColors.editLovedOneSectionIcon),
            const SizedBox(width: 8),
            Text('Relationship Goals', style: AppTextStyles.editLovedOneSectionHeader),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.editLovedOneCardBg,
            borderRadius: BorderRadius.circular(_kCardRadiusSmall),
            border: Border.all(color: AppColors.editLovedOneCardBorder),
            boxShadow: AppShadows.editLovedOneCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '💕 Primary Goal ',
                      style: AppTextStyles.editLovedOneLabel,
                      children: [TextSpan(text: '(Choose 1)', style: AppTextStyles.editLovedOneSecondaryRowCategory)],
                    ),
                    softWrap: true,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Obx(() => DropdownButtonFormField<String>(
                value: c.primaryGoalKey.value.isEmpty ? null : c.primaryGoalKey.value,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(_kInputRadius)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kInputRadius),
                    borderSide: BorderSide(color: AppColors.editLovedOneInputBorder),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                items: [
                  DropdownMenuItem(value: null, child: Text('Select your primary goal', style: AppTextStyles.editLovedOneInputPlaceholder, overflow: TextOverflow.ellipsis)),
                  ...c.primaryGoalOptions.map((g) => DropdownMenuItem(value: g.key, child: Text(g.title, overflow: TextOverflow.ellipsis))),
                ],
                onChanged: (v) => c.onSelectPrimaryGoal(v ?? ''),
              )),
              Obx(() {
                if (c.primaryGoalKey.value.isEmpty) return const SizedBox.shrink();
                RelationshipGoalOption? found;
                for (final g in c.primaryGoalOptions) {
                  if (g.key == c.primaryGoalKey.value) { found = g; break; }
                }
                if (found == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(found.subtitle, style: AppTextStyles.editLovedOneSecondaryRowCategory, softWrap: true),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.editLovedOneCardBg,
            borderRadius: BorderRadius.circular(_kCardRadiusSmall),
            border: Border.all(color: AppColors.editLovedOneCardBorder),
            boxShadow: AppShadows.editLovedOneCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '✨ Secondary Goals ',
                      style: AppTextStyles.editLovedOneLabel,
                      children: [TextSpan(text: '(Choose up to 3)', style: AppTextStyles.editLovedOneSecondaryRowCategory)],
                    ),
                  ),
                  Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.editLovedOneSecondaryPillBg,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('${c.secondaryGoalIds.length}/3', style: AppTextStyles.editLovedOneSecondaryPill),
                  )),
                ],
              ),
              const SizedBox(height: 12),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: _kSecondaryRowPadding),
                          decoration: BoxDecoration(
                            gradient: isSelected ? AppGradients.editLovedOneSecondaryRowSelected : null,
                            color: isSelected ? null : (isDisabled ? AppColors.editLovedOnePlaceholder.withValues(alpha: 0.3) : Colors.white),
                            borderRadius: BorderRadius.circular(_kSecondaryRowRadius),
                            border: Border.all(
                              color: isSelected ? AppColors.editLovedOneSecondaryRowSelectedBorder : AppColors.editLovedOneInputBorder,
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
                                child: isSelected ? Icon(Icons.check, size: 14, color: Colors.white) : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      goal.label,
                                      style: isSelected ? AppTextStyles.editLovedOneSecondaryRowTitleSelected : AppTextStyles.editLovedOneSecondaryRowTitle,
                                    ),
                                    Text(goal.categoryTitle, style: AppTextStyles.editLovedOneSecondaryRowCategory),
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
        ),
        const SizedBox(height: 16),
        _buildInfoCard(
          icon: Icons.flag_outlined,
          title: 'Personalized Guidance',
          body: 'These goals help Cherish AI understand what matters most in your relationship, so we can provide tailored suggestions and meaningful gift ideas.',
        ),
      ],
    );
  }

  Widget _buildHobbies(BuildContext context, EditLovedOneController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, size: _kSectionIconSize, color: AppColors.editLovedOneSectionIcon),
            const SizedBox(width: 8),
            Text('Hobbies & Preferences', style: AppTextStyles.editLovedOneSectionHeader),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Select hobbies, interests, and dislikes directly on this page - all changes save automatically when you click Save',
          style: AppTextStyles.editLovedOneInfoCardBody,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.editLovedOneCardBg,
            borderRadius: BorderRadius.circular(_kCardRadiusSmall),
            border: Border.all(color: AppColors.editLovedOneInfoCardBorder),
            boxShadow: AppShadows.editLovedOneCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '🎨 Hobbies & Interests ',
                        style: AppTextStyles.editLovedOneLabel,
                        children: [TextSpan(text: '(Select up to 8 total, 1 per category)', style: AppTextStyles.editLovedOneSecondaryRowCategory)],
                      ),
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.editLovedOneSecondaryPillBg,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('${c.totalHobbies}/8', style: AppTextStyles.editLovedOneSecondaryPill),
                  )),
                ],
              ),
              const SizedBox(height: 12),
              Obx(() => Column(
                children: c.hobbyCategories.map((cat) {
                  final selectedId = c.selectedHobbyByCategory[cat.key];
                  final isMaxReached = selectedId != null;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(_kCategoryCardPadding),
                      decoration: BoxDecoration(
                        color: cat.backgroundColor,
                        borderRadius: BorderRadius.circular(_kCategoryCardRadius),
                        border: Border.all(color: AppColors.editLovedOneInfoCardBorder.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cat.title, style: AppTextStyles.editLovedOneCategoryTitle),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: _kChipGap,
                            runSpacing: _kChipGap,
                            children: cat.chips.map((chip) {
                              final isSelected = selectedId == chip.id;
                              final isDisabled = !isSelected && isMaxReached;
                              return GestureDetector(
                                onTap: isDisabled ? null : () => c.onToggleHobby(cat.key, chip.id),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                                  decoration: BoxDecoration(
                                    gradient: isSelected ? AppGradients.profileSaveBtn : null,
                                    color: isSelected ? null : (isDisabled ? Colors.white.withValues(alpha: 0.5) : Colors.white),
                                    borderRadius: BorderRadius.circular(_kChipRadius),
                                    border: isSelected ? null : Border.all(color: AppColors.editLovedOneInfoCardBorder),
                                  ),
                                  child: Text(
                                    chip.label,
                                    style: isSelected ? AppTextStyles.editLovedOneChipSelected : AppTextStyles.editLovedOneChip,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDislikes(BuildContext context, EditLovedOneController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.block, size: _kSectionIconSize, color: AppColors.editLovedOneDislikesSectionIcon),
            const SizedBox(width: 8),
            Text('Dislikes', style: AppTextStyles.editLovedOneSectionHeader),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.editLovedOneCardBg,
            borderRadius: BorderRadius.circular(_kCardRadiusSmall),
            border: Border.all(color: AppColors.editLovedOneDislikesCardBorder),
            boxShadow: AppShadows.editLovedOneCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Dislikes ',
                      style: AppTextStyles.editLovedOneLabel,
                      children: [TextSpan(text: '(Select up to 4 + 2 custom)', style: AppTextStyles.editLovedOneSecondaryRowCategory)],
                    ),
                  ),
                  Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.dislikesFinalPillBg,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text('${c.totalDislikes}/6', style: AppTextStyles.dislikesFinalPill),
                  )),
                ],
              ),
              Obx(() {
                if (c.customDislikes.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Custom Dislikes', style: AppTextStyles.editLovedOneCustomDislikeLabel),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: _kChipGap,
                        runSpacing: _kChipGap,
                        children: c.customDislikes.map((item) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                            decoration: BoxDecoration(
                              color: AppColors.editLovedOneCustomDislikeChipBg,
                              borderRadius: BorderRadius.circular(_kChipRadius),
                              border: Border.all(color: AppColors.editLovedOneCustomDislikeChipBorder),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(item, style: AppTextStyles.editLovedOneChip),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () => c.onRemoveCustomDislike(item),
                                  child: Icon(Icons.close, size: 14, color: AppColors.editLovedOneLabel),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }),
              Obx(() => Column(
                children: c.dislikeCategories.map((cat) {
                  final selectedId = c.selectedDislikeByCategory[cat.key];
                  final isMaxReached = selectedId != null;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(_kCategoryCardPadding),
                      decoration: BoxDecoration(
                        color: cat.backgroundColor,
                        borderRadius: BorderRadius.circular(_kCategoryCardRadius),
                        border: Border.all(color: AppColors.editLovedOneDislikesCardBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cat.title, style: AppTextStyles.editLovedOneCategoryTitle),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: _kChipGap,
                            runSpacing: _kChipGap,
                            children: cat.items.map((item) {
                              final isSelected = selectedId == item.id;
                              final isDisabled = !isSelected && isMaxReached;
                              return GestureDetector(
                                onTap: isDisabled ? null : () => c.onToggleDislike(cat.key, item.id),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                                  decoration: BoxDecoration(
                                    gradient: isSelected ? AppGradients.dislikesCta : null,
                                    color: isSelected ? null : (isDisabled ? Colors.white.withValues(alpha: 0.5) : Colors.white),
                                    borderRadius: BorderRadius.circular(_kChipRadius),
                                    border: isSelected ? null : Border.all(color: AppColors.editLovedOneDislikesCardBorder),
                                  ),
                                  child: Text(
                                    item.label,
                                    style: isSelected ? AppTextStyles.editLovedOneChipSelected : AppTextStyles.editLovedOneChip,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
              Obx(() {
                if (!c.canAddCustomDislike) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.editLovedOneAddCustomDislikeBg,
                      borderRadius: BorderRadius.circular(_kInputRadius),
                      border: Border.all(color: AppColors.editLovedOneAddCustomDislikeBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: c.customDislikeInputCtrl,
                          style: AppTextStyles.editLovedOneInput,
                          decoration: InputDecoration(
                            hintText: 'Add custom dislike (press Enter)',
                            hintStyle: AppTextStyles.editLovedOneInputPlaceholder,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: AppColors.editLovedOneDislikesCardBorder),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                          onSubmitted: (_) => c.onAddCustomDislike(),
                        ),
                        const SizedBox(height: 8),
                        Text('Press Enter to add', style: AppTextStyles.editLovedOneAddCustomHint),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSave(BuildContext context, EditLovedOneController c, double bottomPadding) {
    return Container(
      padding: EdgeInsets.only(left: _kPaddingH, right: _kPaddingH, top: 24, bottom: 24 + bottomPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.white.withValues(alpha: 0.95),
            Colors.white,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
          child: Obx(() => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.isSaving.value ? null : () => c.onSaveChanges(),
              borderRadius: BorderRadius.circular(_kDashedBtnRadius),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: c.isSaving.value ? null : AppGradients.profileSaveBtn,
                  color: c.isSaving.value ? AppColors.editLovedOnePlaceholder.withValues(alpha: 0.5) : null,
                  borderRadius: BorderRadius.circular(_kDashedBtnRadius),
                 
                ),
                child: c.isSaving.value
                    ? const Center(child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      ))
                    : Center(child: Text('Save Changes', style: AppTextStyles.profileSaveBtn)),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
