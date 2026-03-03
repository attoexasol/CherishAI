// lib/presentation/dislikes/controllers/dislikes_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';

/// Minimal UI state for Dislikes screen. Max 1 selection per category; Back/Continue; Add Custom Dislike per category.
class DislikesController extends GetxController {
  /// categoryKey -> selected option id or custom label (null if none). Max 1 per category.
  final RxMap<String, String?> selectedByCategory = <String, String?>{}.obs;

  /// categoryKey -> list of custom dislike labels added to that category. Shown as chips in the category card.
  final RxMap<String, RxList<String>> customOptionsByCategory = <String, RxList<String>>{}.obs;

  final RxBool isSubmitting = false.obs;
  final RxBool showCustomDislikeForm = false.obs;

  final TextEditingController customDislikeTextController = TextEditingController();

  static const int _kMaxCustomDislikesTotal = 2;

  @override
  void onInit() {
    super.onInit();
    customDislikeTextController.addListener(_syncCustomDislikeInput);
  }

  void _syncCustomDislikeInput() {
    customDislikeInput.value = customDislikeTextController.text;
  }

  final RxString customDislikeInput = ''.obs;

  @override
  void onClose() {
    customDislikeTextController.removeListener(_syncCustomDislikeInput);
    customDislikeTextController.dispose();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  /// Toggle selection for one option in a category. Max 1 per category: selecting another replaces current; tapping same deselects.
  void toggleCategorySelection(String categoryKey, String optionIdOrLabel) {
    final current = selectedByCategory[categoryKey];
    if (current == optionIdOrLabel) {
      selectedByCategory[categoryKey] = null;
    } else {
      selectedByCategory[categoryKey] = optionIdOrLabel;
    }
    selectedByCategory.refresh();
  }

  /// Show the inline Add Custom Dislike form. Custom dislikes are added to [categoryKey] (e.g. wellness_personality).
  void onAddCustomDislike() {
    if (_totalCustomCount >= _kMaxCustomDislikesTotal) return;
    showCustomDislikeForm.value = true;
  }

  /// Cancel: hide form and clear input.
  void cancelCustomDislikeForm() {
    showCustomDislikeForm.value = false;
    customDislikeTextController.clear();
    customDislikeInput.value = '';
  }

  /// Add custom dislike to [categoryKey]. Validates, prevents duplicates (case-insensitive), sets as selected (max 1), clears and hides form.
  void addCustomDislike(String categoryKey) {
    final text = customDislikeTextController.text.trim();
    if (text.isEmpty) {
      Get.snackbar(
        'Dislike',
        'Please enter a dislike',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    if (_totalCustomCount >= _kMaxCustomDislikesTotal) {
      Get.snackbar(
        'Limit reached',
        'You can add up to $_kMaxCustomDislikesTotal custom dislikes.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    final list = customOptionsByCategory.putIfAbsent(categoryKey, () => <String>[].obs);
    final exists = list.any((e) => e.toLowerCase() == text.toLowerCase());
    if (exists) {
      Get.snackbar(
        'Duplicate',
        'This dislike is already added in this category.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.prefsDialogBg,
        colorText: AppColors.prefsSectionTitle,
        margin: const EdgeInsets.all(16),
      );
      return;
    }
    list.add(text);
    list.refresh();
    selectedByCategory[categoryKey] = text;
    selectedByCategory.refresh();
    customOptionsByCategory.refresh();
    customDislikeTextController.clear();
    customDislikeInput.value = '';
    showCustomDislikeForm.value = false;
  }

  int get _totalCustomCount {
    int n = 0;
    for (final list in customOptionsByCategory.values) {
      n += list.length;
    }
    return n;
  }

  bool get canAddMoreCustomDislikes => _totalCustomCount < _kMaxCustomDislikesTotal;

  void onContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.personalNote);
    });
  }
}
