// lib/presentation/onboarding/views/individual_step1_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/individual_step1_profile_controller.dart';

const double _kBackBtnSize = 48;
const double _kBackBtnInset = 20;
const double _kAvatarSize = 44;
const double _kStepPillAvatarGap = 10;
const double _kTitleTop = 16;
const double _kTitleSubtitleGap = 6;
const double _kSectionGap = 24;
const double _kCardRadius = 16;
const double _kCardPaddingV = 20;
const double _kCardPaddingH = 24;
const double _kLabelIconSize = 18;
const double _kLabelBottom = 10;
const double _kHelperTop = 8;
const double _kInputHeight = 48;
const double _kInputRadius = 8;
const double _kChipRadius = 8;
const double _kChipPaddingV = 12;
const double _kChipPaddingH = 16;
const double _kChipGap = 10;
const double _kPhotoCircleSize = 120;
const double _kPhotoCircleStrokeWidth = 2;
const double _kCameraBadgeSize = 32;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 16;
const double _kRequiredHintTop = 8;
const double _kHorizontalPadding = 24;

class IndividualStep1ProfileScreen extends StatelessWidget {
  const IndividualStep1ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.profileStep1PageBg,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kHorizontalPadding,
                  right: _kHorizontalPadding,
                  top: _kBackBtnInset + _kBackBtnSize + 12,
                  bottom: _kCtaHeight + _kCtaBottomPadding + _kRequiredHintTop + 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStepPillAndAvatar(context),
                    SizedBox(height: _kTitleTop),
                    _buildTitleSubtitle(),
                    SizedBox(height: _kSectionGap),
                    _buildProfilePhotoSection(context),
                    SizedBox(height: _kSectionGap),
                    _buildNameCard(context),
                    SizedBox(height: _kSectionGap),
                    _buildAgeCard(context),
                    SizedBox(height: _kSectionGap),
                    _buildGenderCard(context),
                    SizedBox(height: _kSectionGap),
                    _buildAddressCard(context),
                    SizedBox(height: _kSectionGap),
                    _buildPhoneCard(context),
                  ],
                ),
              ),
              Positioned(
                top: _kBackBtnInset,
                left: _kHorizontalPadding,
                child: _buildBackButton(context),
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

  Widget _buildBackButton(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onBack,
        borderRadius: BorderRadius.circular(_kBackBtnSize / 2),
        child: Container(
          width: _kBackBtnSize,
          height: _kBackBtnSize,
          decoration: BoxDecoration(
            color: AppColors.profileStep1BackBtnBg,
            shape: BoxShape.circle,
            boxShadow: AppShadows.profileStep1BackButton,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.arrow_back_rounded, size: 24, color: AppColors.profileStep1BackBtnIcon),
        ),
      ),
    );
  }

  Widget _buildStepPillAndAvatar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.favorite, size: 16, color: AppColors.profileStep1StepPillText),
        const SizedBox(width: 6),
        Text('Step 1 of 4', style: AppTextStyles.profileStep1StepPill),
        SizedBox(width: _kStepPillAvatarGap),
        Container(
          width: _kAvatarSize,
          height: _kAvatarSize,
          decoration: BoxDecoration(
            gradient: AppGradients.profileStep1Avatar,
            shape: BoxShape.circle,
            boxShadow: AppShadows.profileStep1Avatar,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.person, color: AppColors.white, size: 26),
        ),
      ],
    );
  }

  Widget _buildTitleSubtitle() {
    return Column(
      children: [
        Text(
          'Tell Cherish AI about yourself',
          textAlign: TextAlign.center,
          style: AppTextStyles.profileStep1Title,
        ),
        SizedBox(height: _kTitleSubtitleGap),
        Text(
          'Personalize your Cherish AI experience',
          textAlign: TextAlign.center,
          style: AppTextStyles.profileStep1Subtitle,
        ),
      ],
    );
  }

  Widget _buildProfilePhotoSection(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return Column(
      children: [
        Text(
          'Profile Photo (Optional)',
          style: AppTextStyles.profileStep1SectionLabel,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: c.onTapAddPhoto,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: _kPhotoCircleSize,
                height: _kPhotoCircleSize,
                decoration: BoxDecoration(
                  color: AppColors.profileStep1PhotoCircleInner,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(_kPhotoCircleSize, _kPhotoCircleSize),
                      painter: _DashedCirclePainter(
                        color: AppColors.profileStep1PhotoCircleBorder,
                        strokeWidth: _kPhotoCircleStrokeWidth,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, size: 32, color: AppColors.profileStep1PhotoIcon),
                        const SizedBox(height: 6),
                        Text('Add Photo', style: AppTextStyles.profileStep1AddPhoto),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: _kCameraBadgeSize,
                  height: _kCameraBadgeSize,
                  decoration: BoxDecoration(
                    color: AppColors.profileStep1PhotoIcon,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.profileStep1CameraBadge,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.camera_alt, color: AppColors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: _kHelperTop),
        Text(
          'Help us put a face to your beautiful journey',
          style: AppTextStyles.profileStep1Helper,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: _kCardPaddingV, horizontal: _kCardPaddingH),
      decoration: BoxDecoration(
        color: AppColors.profileStep1CardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.profileStep1Card,
      ),
      child: child,
    );
  }

  Widget _buildNameCard(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return _buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite, size: _kLabelIconSize, color: AppColors.profileStep1PhotoIcon),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.profileStep1CardTitle.copyWith(color: AppColors.profileStep1CardLabel),
                    children: [
                      const TextSpan(text: 'How should Cherish AI call you?'),
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: AppColors.profileStep1RequiredAsterisk, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: _kLabelBottom),
          SizedBox(
            height: _kInputHeight,
            child: TextField(
              controller: c.name,
              style: AppTextStyles.profileStep1Input,
              decoration: InputDecoration(
                hintText: 'Your name or nickname',
                hintStyle: AppTextStyles.profileStep1InputPlaceholder,
                filled: true,
                fillColor: AppColors.profileStep1InputBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_kInputRadius),
                  borderSide: const BorderSide(color: AppColors.profileStep1InputBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_kInputRadius),
                  borderSide: const BorderSide(color: AppColors.profileStep1InputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_kInputRadius),
                  borderSide: const BorderSide(color: AppColors.profileStep1PhotoIcon, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          SizedBox(height: _kHelperTop),
          Text(
            'This is how Cherish AI will address you throughout your experience',
            style: AppTextStyles.profileStep1Helper,
          ),
        ],
      ),
    );
  }

  Widget _buildAgeCard(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return _buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: AppTextStyles.profileStep1CardTitle.copyWith(color: AppColors.profileStep1CardLabel),
              children: [
                const TextSpan(text: 'Age Range '),
                TextSpan(
                  text: '*',
                  style: TextStyle(color: AppColors.profileStep1RequiredAsterisk, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(height: _kLabelBottom),
          Obx(() {
            return Wrap(
              spacing: _kChipGap,
              runSpacing: _kChipGap,
              children: IndividualStep1ProfileController.ageRangeOptions.map((option) {
                final selected = c.selectedAgeRange.value == option;
                return _buildChip(
                  label: option,
                  selected: selected,
                  onTap: () => c.onSelectAgeRange(option),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGenderCard(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return _buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: AppTextStyles.profileStep1CardTitle.copyWith(color: AppColors.profileStep1CardLabel),
              children: [
                const TextSpan(text: 'Gender '),
                TextSpan(
                  text: '*',
                  style: TextStyle(color: AppColors.profileStep1RequiredAsterisk, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(height: _kLabelBottom),
          Obx(() {
            return Row(
              children: IndividualStep1ProfileController.genderOptions.map((option) {
                final selected = c.selectedGender.value == option;
                return Padding(
                  padding: EdgeInsets.only(right: option != IndividualStep1ProfileController.genderOptions.last ? _kChipGap : 0),
                  child: _buildChip(
                    label: option,
                    selected: selected,
                    onTap: () => c.onSelectGender(option),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildChip({required String label, required bool selected, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kChipRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: _kChipPaddingV, horizontal: _kChipPaddingH),
          decoration: BoxDecoration(
            color: selected ? AppColors.profileStep1ChipSelectedBg : AppColors.profileStep1CardBg,
            borderRadius: BorderRadius.circular(_kChipRadius),
            border: Border.all(
              color: selected ? AppColors.profileStep1ChipSelectedBg : AppColors.profileStep1ChipBorder,
            ),
          ),
          child: Text(
            label,
            style: selected ? AppTextStyles.profileStep1ChipSelected : AppTextStyles.profileStep1Chip,
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return _buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: _kLabelIconSize, color: AppColors.profileStep1PhotoIcon),
              const SizedBox(width: 8),
              Text('Your Address', style: AppTextStyles.profileStep1CardTitle),
            ],
          ),
          SizedBox(height: _kLabelBottom),
          Obx(() => _buildDropdown<String>(
            value: c.selectedCountry.value.isEmpty ? null : c.selectedCountry.value,
            hint: 'Select your country',
            items: IndividualStep1ProfileController.countryOptions,
            onChanged: c.onSelectCountry,
          )),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInput(controller: c.city, hint: 'Your city'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInput(controller: c.postalCode, hint: 'Postal code'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInput(controller: c.stateRegion, hint: 'State, province, or region'),
          const SizedBox(height: 12),
          _buildInput(controller: c.street, hint: 'Street address (optional)'),
          SizedBox(height: _kHelperTop),
          Text(
            'Your location helps Cherish AI suggest thoughtful gifts and services nearby. No need to share street number or building details.',
            style: AppTextStyles.profileStep1Helper,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneCard(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return _buildFormCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phone_outlined, size: _kLabelIconSize, color: AppColors.profileStep1PhotoIcon),
              const SizedBox(width: 8),
              Text('Phone Number (Optional)', style: AppTextStyles.profileStep1CardTitle),
            ],
          ),
          SizedBox(height: _kLabelBottom),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: Obx(() => _buildDropdown<String>(
                  value: c.selectedCountryCode.value,
                  hint: '+1',
                  items: IndividualStep1ProfileController.countryCodeOptions
                      .map((e) => '${e['code']} ${e['label']}')
                      .toList(),
                  onChanged: c.onSelectCountryCode,
                )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInput(controller: c.phone, hint: 'Phone number'),
              ),
            ],
          ),
          SizedBox(height: _kHelperTop),
          Text(
            'For important reminders and thoughtful notifications',
            style: AppTextStyles.profileStep1Helper,
          ),
        ],
      ),
    );
  }

  Widget _buildInput({required TextEditingController controller, required String hint}) {
    return SizedBox(
      height: _kInputHeight,
      child: TextField(
        controller: controller,
        style: AppTextStyles.profileStep1Input,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.profileStep1InputPlaceholder,
          filled: true,
          fillColor: AppColors.profileStep1InputBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_kInputRadius),
            borderSide: const BorderSide(color: AppColors.profileStep1InputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_kInputRadius),
            borderSide: const BorderSide(color: AppColors.profileStep1InputBorder),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<T> items,
    required void Function(T) onChanged,
  }) {
    return SizedBox(
      height: _kInputHeight,
      child: DropdownButtonFormField<T>(
        value: value,
        hint: Text(hint, style: AppTextStyles.profileStep1InputPlaceholder),
        isExpanded: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.profileStep1InputBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_kInputRadius),
            borderSide: const BorderSide(color: AppColors.profileStep1InputBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_kInputRadius),
            borderSide: const BorderSide(color: AppColors.profileStep1InputBorder),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e', style: AppTextStyles.profileStep1Input))).toList(),
        onChanged: (v) => v != null ? onChanged(v) : null,
      ),
    );
  }

  Widget _buildBottomCta(BuildContext context) {
    final c = Get.find<IndividualStep1ProfileController>();
    return Container(
      padding: EdgeInsets.fromLTRB(_kHorizontalPadding, 12, _kHorizontalPadding, _kCtaBottomPadding + MediaQuery.paddingOf(context).bottom),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: c.isSubmitting.value ? null : c.onContinue,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    height: _kCtaHeight,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: c.isSubmitting.value ? null : AppGradients.profileStep1Cta,
                      color: c.isSubmitting.value ? AppColors.profileStep1InputBorder : null,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: AppShadows.profileStep1Cta,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Continue to Next Step', style: AppTextStyles.profileStep1Cta),
                        const SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: AppColors.white, size: 20),
                      ],
                    ),
                  ),
                ),
              )),
          SizedBox(height: _kRequiredHintTop),
          Text('• Required fields', style: AppTextStyles.profileStep1RequiredHint),
        ],
      ),
    );
  }
}

/// Paints a dashed circle inside the container (used for profile photo circle).
class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({required this.color, required this.strokeWidth});
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2 - strokeWidth / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    const dashCount = 24;
    for (var i = 0; i < dashCount; i++) {
      final start = i * (2 * 3.14159 / dashCount);
      final sweep = 2 * 3.14159 / dashCount * 0.6;
      canvas.drawArc(Rect.fromCircle(center: center, radius: r), start, sweep, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
