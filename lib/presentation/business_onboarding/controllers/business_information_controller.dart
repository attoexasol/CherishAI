// lib/presentation/business_onboarding/controllers/business_information_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class BusinessInformationController extends GetxController {
  final RxBool isSubmitting = false.obs;
  final RxString selectedDeliveryType = RxString('');
  final RxDouble priceRangeValue = 2.0.obs;
  final RxString selectedCategory = RxString('');
  final RxString selectedCountry = RxString('');

  final businessNameController = TextEditingController();
  final contactPersonNameController = TextEditingController();
  final emailController = TextEditingController();
  final locationNameController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stateRegionController = TextEditingController();
  final streetAddressController = TextEditingController();
  final telController = TextEditingController();
  final websiteController = TextEditingController();
  final descriptionController = TextEditingController();
  final hoursController = TextEditingController();
  final whatsappController = TextEditingController();
  final telegramController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final redditController = TextEditingController();
  final snapchatController = TextEditingController();
  final tiktokController = TextEditingController();

  static const List<Map<String, String>> categories = [
    {'value': 'gifts', 'label': 'Gifts & Personalized Items'},
    {'value': 'food', 'label': 'Food & Dining Experiences'},
    {'value': 'wellness', 'label': 'Wellness & Self-Care Services'},
    {'value': 'entertainment', 'label': 'Entertainment & Leisure'},
    {'value': 'fashion', 'label': 'Fashion & Style'},
    {'value': 'home', 'label': 'Home & Lifestyle'},
    {'value': 'travel', 'label': 'Travel & Getaways'},
    {'value': 'memories', 'label': 'Memories & Creative Services'},
    {'value': 'family', 'label': 'Family & Children Services'},
    {'value': 'learning', 'label': 'Learning & Personal Growth'},
  ];

  static final List<String> countries = [
    'United States', 'Canada', 'United Kingdom', 'Australia', 'Germany',
    'France', 'Italy', 'Spain', 'Japan', 'China', 'India', 'Brazil', 'Mexico',
    'South Africa', 'Egypt', 'Nigeria', 'United Arab Emirates', 'Singapore',
    'Malaysia', 'New Zealand', 'Netherlands', 'Belgium', 'Switzerland', 'Sweden',
    'Norway', 'Denmark', 'Finland', 'Ireland', 'Portugal', 'Greece', 'Poland',
    'Czech Republic', 'Austria', 'Hungary', 'Romania', 'South Korea', 'Thailand',
    'Vietnam', 'Philippines', 'Indonesia', 'Pakistan', 'Bangladesh', 'Turkey',
    'Saudi Arabia', 'Israel', 'Argentina', 'Chile', 'Colombia', 'Peru', 'Venezuela',
  ]..sort();

  static String priceRangeLabel(double value) {
    final v = value.round().clamp(1, 4);
    switch (v) {
      case 1: return 'Budget (\$0 - \$50)';
      case 2: return 'Moderate (\$50 - \$200)';
      case 3: return 'Upscale (\$200 - \$500)';
      case 4: return 'Luxury (\$500+)';
      default: return 'Moderate (\$50 - \$200)';
    }
  }

  void onBack() => Get.back();

  void onContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 300), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.productsServices);
    });
  }

  void onViewPlans() {
    Get.toNamed(AppRoutes.choosePlan);
  }

  void onAddLocation() {
    // Stub: open add location modal / screen
  }

  void onUploadLogo() {
    // Stub: file picker
  }

  void onSelectDeliveryType(String type) {
    selectedDeliveryType.value = selectedDeliveryType.value == type ? '' : type;
  }

  void onChangePrice(double value) {
    priceRangeValue.value = value.clamp(1.0, 4.0);
  }

  void onSelectCountry(String value) {
    selectedCountry.value = value;
  }

  void onSelectCategory(String value) {
    selectedCategory.value = value;
  }

  @override
  void onClose() {
    businessNameController.dispose();
    contactPersonNameController.dispose();
    emailController.dispose();
    locationNameController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    stateRegionController.dispose();
    streetAddressController.dispose();
    telController.dispose();
    websiteController.dispose();
    descriptionController.dispose();
    hoursController.dispose();
    whatsappController.dispose();
    telegramController.dispose();
    instagramController.dispose();
    facebookController.dispose();
    redditController.dispose();
    snapchatController.dispose();
    tiktokController.dispose();
    super.onClose();
  }
}
