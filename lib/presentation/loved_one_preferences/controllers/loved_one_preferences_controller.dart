// lib/presentation/loved_one_preferences/controllers/loved_one_preferences_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Loved One Preferences. Back -> pop; Continue -> same as React.
/// Chips: max 1 per category. Add Special Occasion / Add Custom Hobby hook to existing flow.
class LovedOnePreferencesController extends GetxController {
  /// categoryKey -> selected chip id (null if none). Max 1 per category.
  final RxMap<String, String?> selectedByCategory = <String, String?>{}.obs;
  final RxBool isSubmitting = false.obs;

  void onBack() {
    Get.back();
  }

  void onAddSpecialOccasion() {
    // Hook to existing route/dialog. No new flow.
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
    // Hook to existing route/dialog. No new flow.
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
