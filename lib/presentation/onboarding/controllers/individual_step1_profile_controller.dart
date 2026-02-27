// lib/presentation/onboarding/controllers/individual_step1_profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';

/// Minimal UI state for Individual Profile Step 1. Navigation matches React:
/// back -> pop; Continue to Next Step -> same action/route as React (step 2 or submit).
class IndividualStep1ProfileController extends GetxController {
  final name = TextEditingController();
  final city = TextEditingController();
  final postalCode = TextEditingController();
  final stateRegion = TextEditingController();
  final street = TextEditingController();
  final phone = TextEditingController();

  final RxString selectedCountry = RxString('');
  final RxString selectedAgeRange = RxString('');
  final RxString selectedGender = RxString('');
  final RxBool isSubmitting = false.obs;

  /// Path to the selected profile photo (null until user picks one).
  final RxnString profileImagePath = RxnString();
  final ImagePicker _imagePicker = ImagePicker();

  /// Static list mirroring typical React country/code list. Do not invent; if React uses API, wire later.
  static const List<String> countryOptions = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Other',
  ];

  /// Country code options for phone (e.g. +1 US/CA). Mirror React if it uses a static list.
  static const List<Map<String, String>> countryCodeOptions = [
    {'code': '+1', 'label': 'US/CA'},
    {'code': '+44', 'label': 'UK'},
    {'code': '+61', 'label': 'AU'},
    {'code': '+49', 'label': 'DE'},
    {'code': '+33', 'label': 'FR'},
  ];

  RxString selectedCountryCode = RxString('+1 US/CA');

  static const List<String> ageRangeOptions = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    '65+',
  ];

  static const List<String> genderOptions = ['Male', 'Female'];

  @override
  void onClose() {
    name.dispose();
    city.dispose();
    postalCode.dispose();
    stateRegion.dispose();
    street.dispose();
    phone.dispose();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  void onTapAddPhoto() {
    final context = Get.context;
    if (context == null) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: AppColors.profileStep1CardBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Profile Photo',
                style: AppTextStyles.profileStep1CardTitle.copyWith(
                  color: AppColors.profileStep1CardLabel,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.profileStep1PhotoCircleInner,
                  child: Icon(Icons.photo_library_outlined, color: AppColors.profileStep1PhotoIcon),
                ),
                title: Text('Choose from Gallery', style: AppTextStyles.profileStep1Input),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.profileStep1PhotoCircleInner,
                  child: Icon(Icons.camera_alt_outlined, color: AppColors.profileStep1PhotoIcon),
                ),
                title: Text('Take Photo', style: AppTextStyles.profileStep1Input),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (file != null) {
        profileImagePath.value = file.path;
      }
    } catch (_) {
      // User cancelled or permission denied; ignore.
    }
  }

  void onSelectAgeRange(String value) {
    selectedAgeRange.value = value;
  }

  void onSelectGender(String value) {
    selectedGender.value = value;
  }

  void onSelectCountry(String value) {
    selectedCountry.value = value;
  }

  void onSelectCountryCode(String value) {
    selectedCountryCode.value = value;
  }

  void onContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.individualAddLovedOne);
    });
  }
}
