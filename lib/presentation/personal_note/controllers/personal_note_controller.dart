// lib/presentation/personal_note/controllers/personal_note_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Add a Personal Note. Back/Skip/Continue match React.
/// Note required; max 300 chars. Continue enabled when note is non-empty and <= 300.
class PersonalNoteController extends GetxController {
  static const int maxLength = 300;

  final noteController = TextEditingController();
  final RxInt charCount = 0.obs;
  final RxBool canContinue = false.obs;
  final RxBool isSubmitting = false.obs;

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

  void onSeeMoreExamples() {
    // Hook to existing modal/expand. No new flow.
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
