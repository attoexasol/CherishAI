// lib/presentation/personal_note/controllers/personal_note_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Add a Personal Note. Back/Continue (mandatory step).
/// Note required; max 200 chars. Continue enabled when note is non-empty and <= 200.
class PersonalNoteController extends GetxController {
  static const int maxLength = 200;

  final noteController = TextEditingController();
  final RxInt charCount = 0.obs;
  final RxBool canContinue = false.obs;
  final RxBool isSubmitting = false.obs;

  /// Expand/collapse "See more examples" list inside the card.
  final RxBool showExamples = false.obs;

  @override
  void onInit() {
    super.onInit();
    noteController.addListener(_updateFromNote);
  }

  void _updateFromNote() {
    final text = noteController.text;
    charCount.value = text.length;
    canContinue.value = text.trim().isNotEmpty && text.length <= maxLength;
  }

  @override
  void onClose() {
    noteController.removeListener(_updateFromNote);
    noteController.dispose();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  void onSkip() {
    Get.toNamed(AppRoutes.individualUserInfo);
  }

  void toggleSeeMoreExamples() {
    showExamples.toggle();
  }

  /// Fill textarea with [text] (truncated to maxLength), then collapse examples.
  void applyExample(String text) {
    noteController.text = text.length > maxLength ? text.substring(0, maxLength) : text;
    _updateFromNote();
    showExamples.value = false;
  }

  void onContinue() {
    if (!canContinue.value || isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.choosePlan);
    });
  }
}
