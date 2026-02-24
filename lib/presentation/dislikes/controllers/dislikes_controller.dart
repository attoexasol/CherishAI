// lib/presentation/dislikes/controllers/dislikes_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Dislikes screen. Multi-select chips; Back/Continue; Add Custom Dislike inline form (matches React).
class DislikesController extends GetxController {
  final RxList<String> selectedDislikeIds = <String>[].obs;
  final RxList<String> customDislikeLabels = <String>[].obs;
  final RxBool isSubmitting = false.obs;
  final RxBool showCustomDislikeForm = false.obs;

  final TextEditingController customDislikeTextController = TextEditingController();

  static const int _kMaxCustomDislikes = 2;

  @override
  void onInit() {
    super.onInit();
    customDislikeTextController.addListener(_syncCustomDislikeInput);
  }

  void _syncCustomDislikeInput() {
    customDislikeInput.value = customDislikeTextController.text;
  }

  /// Reactive copy for button enabled state (Obx cannot listen to TextEditingController).
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

  void toggleDislike(String id) {
    if (selectedDislikeIds.contains(id)) {
      selectedDislikeIds.remove(id);
    } else {
      selectedDislikeIds.add(id);
    }
    selectedDislikeIds.refresh();
  }

  /// Show the inline Add Custom Dislike form (trigger button tapped).
  void onAddCustomDislike() {
    if (customDislikeLabels.length >= _kMaxCustomDislikes) return;
    showCustomDislikeForm.value = true;
  }

  /// Cancel: hide form and clear input.
  void cancelCustomDislikeForm() {
    showCustomDislikeForm.value = false;
    customDislikeTextController.clear();
    customDislikeInput.value = '';
  }

  /// Add current custom dislike text to list (max 2), then hide form and clear. Matches React handleAddCustomDislike.
  void submitCustomDislike() {
    final text = customDislikeTextController.text.trim();
    if (text.isEmpty || customDislikeLabels.length >= _kMaxCustomDislikes) return;
    customDislikeLabels.add(text);
    customDislikeLabels.refresh();
    customDislikeTextController.clear();
    customDislikeInput.value = '';
    showCustomDislikeForm.value = false;
  }

  /// Remove a custom dislike label (e.g. for future chip delete).
  void removeCustomDislike(String label) {
    customDislikeLabels.remove(label);
    customDislikeLabels.refresh();
  }

  bool get canAddMoreCustomDislikes => customDislikeLabels.length < _kMaxCustomDislikes;

  void onContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.personalNote);
    });
  }
}
