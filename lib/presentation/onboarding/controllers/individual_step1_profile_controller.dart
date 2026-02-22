// lib/presentation/onboarding/controllers/individual_step1_profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

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
    // UI-only stub. If project later adds image picker, wire here.
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
