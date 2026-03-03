// lib/presentation/loved_one_preferences/controllers/loved_one_preferences_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../models/special_occasion_item.dart';
import '../views/dialogs/add_special_occasion_dialog.dart';
import '../views/dialogs/add_custom_hobby_dialog.dart';

/// Minimal UI state for Loved One Preferences. Back -> pop; Continue -> same as React.
/// Chips: max 1 per category. Add Special Occasion / Add Custom Hobby open modals and add to lists.
class LovedOnePreferencesController extends GetxController {
  /// categoryKey -> selected chip id (null if none). Max 1 per category.
  final RxMap<String, String?> selectedByCategory = <String, String?>{}.obs;
  final RxBool isSubmitting = false.obs;

  /// Special occasions added via Add Special Occasion dialog.
  final RxList<SpecialOccasionItem> specialOccasions = <SpecialOccasionItem>[].obs;

  /// Custom hobbies added via Add Custom Hobby dialog (max 2).
  final RxList<String> customHobbies = <String>[].obs;

  /// Form state for Add Special Occasion dialog (same controller instance as screen).
  late final TextEditingController occasionNameController;
  final Rxn<DateTime> selectedOccasionDate = Rxn<DateTime>();

  /// Form state for Add Custom Hobby dialog.
  late final TextEditingController customHobbyController;

  @override
  void onInit() {
    super.onInit();
    occasionNameController = TextEditingController();
    customHobbyController = TextEditingController();
  }

  @override
  void onClose() {
    occasionNameController.dispose();
    customHobbyController.dispose();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  /// Opens the Add Special Occasion modal. Clears form; submit adds to [specialOccasions] and closes.
  void openAddSpecialOccasionDialog() {
    occasionNameController.clear();
    selectedOccasionDate.value = null;
    Get.dialog<void>(
      const AddSpecialOccasionDialog(),
      barrierColor: AppColors.prefsDialogBarrier,
      barrierDismissible: false,
    );
  }

  /// Opens the Add Custom Hobby modal. Clears form; submit adds to [customHobbies] and closes (max 2).
  void openAddCustomHobbyDialog() {
    customHobbyController.clear();
    Get.dialog<void>(
      const AddCustomHobbyDialog(),
      barrierColor: AppColors.prefsDialogBarrier,
      barrierDismissible: false,
    );
  }

  /// Show date picker and set [selectedOccasionDate]. Call from dialog with context.
  Future<void> pickOccasionDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedOccasionDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      selectedOccasionDate.value = date;
    }
  }

  /// Validate, add to list, clear form, close dialog. Call from dialog Add button.
  void addOccasion() {
    final name = occasionNameController.text.trim();
    final date = selectedOccasionDate.value;
    if (name.isEmpty || date == null) {
      Get.snackbar(
        'Missing information',
        'Please enter an occasion name and select a date.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    specialOccasions.add(SpecialOccasionItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      date: date,
    ));
    specialOccasions.refresh();
    occasionNameController.clear();
    selectedOccasionDate.value = null;
    Get.back();
  }

  /// Removes occasion at [index].
  void removeOccasion(int index) {
    if (index >= 0 && index < specialOccasions.length) {
      specialOccasions.removeAt(index);
      specialOccasions.refresh();
    }
  }

  /// Validate, add to [customHobbies] (max 2, no duplicates), clear, close. Call from dialog Add button.
  void addCustomHobby() {
    final value = customHobbyController.text.trim();
    if (value.isEmpty) {
      Get.snackbar(
        'Missing information',
        'Please enter a hobby name.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    if (customHobbies.length >= 2) {
      Get.snackbar(
        'Limit reached',
        'You can add up to 2 custom hobbies.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    final lower = value.toLowerCase();
    if (customHobbies.any((h) => h.toLowerCase() == lower)) {
      Get.snackbar(
        'Duplicate',
        'This hobby is already added.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    customHobbies.add(value);
    customHobbies.refresh();
    customHobbyController.clear();
    Get.back();
  }

  /// Removes a custom hobby by value.
  void removeCustomHobby(String value) {
    customHobbies.remove(value);
    customHobbies.refresh();
  }

  void onAddSpecialOccasion() {
    openAddSpecialOccasionDialog();
  }

  void onToggleChip(String categoryKey, String chipKey) {
    final current = selectedByCategory[categoryKey];
    if (current == chipKey) {
      selectedByCategory[categoryKey] = null;
    } else {
      selectedByCategory[categoryKey] = chipKey;
    }
    selectedByCategory.refresh();
  }

  void onAddCustomHobby() {
    if (customHobbies.length >= 2) {
      Get.snackbar(
        'Limit reached',
        'You can add up to 2 custom hobbies.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    openAddCustomHobbyDialog();
  }

  void onContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.dislikes);
    });
  }
}
