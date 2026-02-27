// lib/presentation/business_profile/controllers/business_profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../business_dashboard/settings/controllers/business_account_settings_controller.dart';
import '../../business_dashboard/settings/views/business_account_settings_dialog.dart';

class BusinessProfileController extends GetxController {
  final RxBool isEditMode = false.obs;
  final RxString selectedCategory = RxString('food');
  final RxString selectedCountry = RxString('France');
  final RxDouble priceRangeValue = 2.0.obs;
  final RxList<String> deliveryTypes = <String>[].obs;

  final businessNameController = TextEditingController();
  final contactPersonController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final websiteController = TextEditingController();
  final descriptionController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stateRegionController = TextEditingController();
  final streetAddressController = TextEditingController();
  final hoursController = TextEditingController();
  final whatsappController = TextEditingController();
  final telegramController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final redditController = TextEditingController();
  final snapchatController = TextEditingController();
  final tiktokController = TextEditingController();

  final RxString profilePhotoUrl = RxString('https://images.unsplash.com/photo-1758887261865-a2b89c0f7ac5?w=400');
  final RxString businessLogoPath = RxString('');

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

  static String categoryLabel(String value) {
    final found = categories.where((c) => c['value'] == value).toList();
    return found.isNotEmpty ? found.first['label']! : value;
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  void loadProfile() {
    businessNameController.text = 'xcgvnv';
    contactPersonController.text = 'vbn';
    emailController.text = 'vbn@gmail.com';
    telController.text = 'vbn';
    websiteController.text = 'https://www.youtube.com/';
    descriptionController.text = 'DFbzsdfbz';
    selectedCountry.value = 'France';
    cityController.text = 'xvbn';
    postalCodeController.text = 'vbn';
    stateRegionController.text = 'n';
    streetAddressController.text = 'n vbn';
    hoursController.text = '';
    priceRangeValue.value = 2.0;
    selectedCategory.value = 'food';
    deliveryTypes.assignAll([]);
  }

  void onBack() => Get.back();

  void onOpenEdit() {
    Get.toNamed(AppRoutes.businessEditProfile);
  }

  void onCloseEdit() {
    Get.back();
  }

  void onSaveAllChanges() {
    Get.back();
  }

  void onLogout() {
    Get.offAllNamed(AppRoutes.auth);
  }

  void onOpenAccountSettings() {
    if (!Get.isRegistered<BusinessAccountSettingsController>()) {
      Get.put(BusinessAccountSettingsController(), permanent: false);
    }
    Get.dialog<void>(
      const BusinessAccountSettingsDialog(),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  void onUploadLogo() {}

  void onAddLocation() {}

  void toggleDeliveryType(String type) {
    if (deliveryTypes.contains(type)) {
      deliveryTypes.remove(type);
    } else {
      deliveryTypes.add(type);
    }
  }

  bool isDeliveryTypeSelected(String type) => deliveryTypes.contains(type);

  void onSelectCategory(String value) => selectedCategory.value = value;
  void onSelectCountry(String value) => selectedCountry.value = value;
  void onChangePrice(double value) => priceRangeValue.value = value.clamp(1.0, 4.0);

  String get mainAddressFormatted {
    final parts = <String>[];
    if (streetAddressController.text.trim().isNotEmpty) parts.add(streetAddressController.text.trim());
    if (cityController.text.trim().isNotEmpty) parts.add(cityController.text.trim());
    if (stateRegionController.text.trim().isNotEmpty) parts.add(stateRegionController.text.trim());
    if (postalCodeController.text.trim().isNotEmpty) parts.add(postalCodeController.text.trim());
    if (selectedCountry.value.isNotEmpty) parts.add(selectedCountry.value);
    return parts.join(', ');
  }

  @override
  void onClose() {
    businessNameController.dispose();
    contactPersonController.dispose();
    emailController.dispose();
    telController.dispose();
    websiteController.dispose();
    descriptionController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    stateRegionController.dispose();
    streetAddressController.dispose();
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
