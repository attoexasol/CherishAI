// lib/presentation/business_onboarding/products_services/controllers/add_business_location_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/business_category_options.dart';
import '../models/business_location_model.dart';

class AddBusinessLocationController extends GetxController {
  final locationNameController = TextEditingController();
  final RxString selectedCountry = ''.obs;
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stateRegionController = TextEditingController();
  final streetAddressController = TextEditingController();
  final contactPersonController = TextEditingController();
  final emailController = TextEditingController();
  final telController = TextEditingController();
  final descriptionController = TextEditingController();
  final operatingHoursController = TextEditingController();

  /// Multi-select: at least one category required.
  final RxList<String> selectedCategories = <String>[].obs;
  final RxDouble priceRangeValue = 2.0.obs;
  final RxList<String> selectedDeliveryTypes = <String>[].obs;
  final RxString logoFilePath = ''.obs;
  final RxList<String> imagePaths = <String>[].obs;
  /// Prevents double-tap from calling Get.back twice (second pop would close the screen below and show blank).
  final RxBool isSubmitting = false.obs;

  /// Same list as product registration; selection behavior is multi-select here.
  static List<Map<String, String>> get categories => List<Map<String, String>>.from(businessLocationCategoryOptions);

  static final List<String> countries = [
    'United States', 'Canada', 'United Kingdom', 'Australia', 'Germany',
    'France', 'Italy', 'Spain', 'Japan', 'China', 'India', 'Brazil', 'Mexico',
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

  void onToggleDeliveryType(String type) {
    if (selectedDeliveryTypes.contains(type)) {
      selectedDeliveryTypes.remove(type);
    } else {
      selectedDeliveryTypes.add(type);
    }
    selectedDeliveryTypes.refresh();
  }

  String? validate() {
    if (locationNameController.text.trim().isEmpty) return 'Location Name is required';
    if (selectedCountry.value.isEmpty) return 'Country is required';
    if (cityController.text.trim().isEmpty) return 'City is required';
    if (postalCodeController.text.trim().isEmpty) return 'Postal Code is required';
    if (contactPersonController.text.trim().isEmpty) return 'Contact Person is required';
    if (selectedCategories.isEmpty) return 'Product or Services Category is required';
    if (selectedDeliveryTypes.isEmpty) return 'Select at least one Delivery Type';
    return null;
  }

  void toggleCategory(String value) {
    if (selectedCategories.contains(value)) {
      selectedCategories.remove(value);
    } else {
      selectedCategories.add(value);
    }
    selectedCategories.refresh();
  }

  BusinessLocationModel buildModel() {
    final cats = List<String>.from(selectedCategories);
    return BusinessLocationModel(
      locationName: locationNameController.text.trim(),
      country: selectedCountry.value,
      city: cityController.text.trim(),
      postalCode: postalCodeController.text.trim(),
      stateRegion: stateRegionController.text.trim(),
      streetAddress: streetAddressController.text.trim(),
      contactPerson: contactPersonController.text.trim(),
      email: emailController.text.trim(),
      tel: telController.text.trim(),
      category: cats.isEmpty ? '' : cats.first,
      categories: cats,
      description: descriptionController.text.trim(),
      priceRangeValue: priceRangeValue.value,
      operatingHours: operatingHoursController.text.trim(),
      deliveryTypes: List<String>.from(selectedDeliveryTypes),
      logoPath: logoFilePath.value.isEmpty ? null : logoFilePath.value,
      imagePaths: List<String>.from(imagePaths),
    );
  }

  void submit() {
    if (isSubmitting.value) return;
    final err = validate();
    if (err != null) {
      Get.snackbar('Validation', err, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isSubmitting.value = true;
    Get.back(result: buildModel());
  }

  @override
  void onClose() {
    locationNameController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    stateRegionController.dispose();
    streetAddressController.dispose();
    contactPersonController.dispose();
    emailController.dispose();
    telController.dispose();
    descriptionController.dispose();
    operatingHoursController.dispose();
    super.onClose();
  }
}
