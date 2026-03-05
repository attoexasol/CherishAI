// lib/presentation/business_onboarding/controllers/business_information_controller.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/business_service_categories.dart';

class BusinessInformationController extends GetxController {
  final RxBool isSubmitting = false.obs;
  /// Selected delivery types: multiple allowed (e.g. ['delivery', 'on-site', 'digital']).
  final RxList<String> selectedDeliveryTypes = <String>[].obs;
  final RxDouble priceRangeValue = 2.0.obs;
  /// Selected product/service categories (multi-select for business registration).
  final RxList<String> selectedCategories = <String>[].obs;
  final RxString selectedCountry = RxString('');

  /// Path or URL of selected business logo (device path or web blob URL). Available for later submission.
  final RxString logoFilePath = RxString('');

  final ImagePicker _imagePicker = ImagePicker();

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

  /// Category list from shared master (multi-select for business registration).
  static List<Map<String, String>> get categories => List<Map<String, String>>.from(kBusinessServiceCategories);

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
    Get.toNamed(AppRoutes.businessChoosePlan);
  }

  /// Show upload source picker (Take Photo / Gallery / Cancel). Call from view; on web only gallery is shown.
  void onUploadLogo() {
    // View shows bottom sheet and calls pickLogoFromCamera / pickLogoFromGallery.
  }

  /// Pick image from camera. On web, use gallery only (call pickLogoFromGallery from view).
  Future<void> pickLogoFromCamera() async {
    if (kIsWeb) return;
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (file != null && file.path.isNotEmpty) {
        logoFilePath.value = file.path;
      }
    } catch (_) {}
  }

  /// Pick image from gallery. Safe on web (image_picker uses gallery on web).
  Future<void> pickLogoFromGallery() async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (file != null && file.path.isNotEmpty) {
        logoFilePath.value = file.path;
      }
    } catch (_) {}
  }

  void onToggleDeliveryType(String type) {
    if (selectedDeliveryTypes.contains(type)) {
      selectedDeliveryTypes.remove(type);
    } else {
      selectedDeliveryTypes.add(type);
    }
    selectedDeliveryTypes.refresh();
  }

  void onSelectDeliveryType(String type) {
    onToggleDeliveryType(type);
  }

  void onChangePrice(double value) {
    priceRangeValue.value = value.clamp(1.0, 4.0);
  }

  void onSelectCountry(String value) {
    selectedCountry.value = value;
  }

  /// Set single category (e.g. for dropdown in add location dialog). For this screen use onToggleCategory.
  void onSelectCategory(String value) {
    selectedCategories.assignAll(value.isEmpty ? [] : [value]);
    selectedCategories.refresh();
  }

  /// Toggle a category in multi-select list.
  void onToggleCategory(String value) {
    if (selectedCategories.contains(value)) {
      selectedCategories.remove(value);
    } else {
      selectedCategories.add(value);
    }
    selectedCategories.refresh();
  }

  /// Single value for backward compatibility (e.g. first selected or empty).
  String get selectedCategory => selectedCategories.isEmpty ? '' : selectedCategories.first;

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
