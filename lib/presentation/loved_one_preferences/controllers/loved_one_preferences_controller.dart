// lib/presentation/loved_one_preferences/controllers/loved_one_preferences_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../views/dialogs/add_special_occasion_dialog.dart';
import '../views/dialogs/add_custom_hobby_dialog.dart';

/// One special occasion entry (mirrors React occasions list).
class SpecialOccasionItem {
  const SpecialOccasionItem({
    required this.id,
    required this.name,
    required this.date,
  });
  final String id;
  final String name;
  final String date;
}

/// Minimal UI state for Loved One Preferences. Back -> pop; Continue -> same as React.
/// Chips: max 1 per category. Add Special Occasion / Add Custom Hobby open modals and add to lists.
class LovedOnePreferencesController extends GetxController {
  /// categoryKey -> selected chip id (null if none). Max 1 per category.
  final RxMap<String, String?> selectedByCategory = <String, String?>{}.obs;
  final RxBool isSubmitting = false.obs;

  /// Special occasions added via Add Special Occasion dialog.
  final RxList<SpecialOccasionItem> specialOccasions = <SpecialOccasionItem>[].obs;

  /// Custom hobbies added via Add Custom Hobby dialog (max 2 in React).
  final RxList<String> customHobbies = <String>[].obs;

  void onBack() {
    Get.back();
  }

  /// Opens the Add Special Occasion modal. Submit adds to [specialOccasions] and closes.
  void openAddSpecialOccasionDialog() {
    Get.dialog<void>(
      const AddSpecialOccasionDialog(),
      barrierColor: AppColors.prefsDialogBarrier,
      barrierDismissible: false,
    );
  }

  /// Opens the Add Custom Hobby modal. Submit adds to [customHobbies] and closes.
  void openAddCustomHobbyDialog() {
    Get.dialog<void>(
      const AddCustomHobbyDialog(),
      barrierColor: AppColors.prefsDialogBarrier,
      barrierDismissible: false,
    );
  }

  /// Called by Add Special Occasion dialog on submit. Adds to list and dialog closes via Get.back().
  void addSpecialOccasion(String name, String date) {
    specialOccasions.add(SpecialOccasionItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      date: date,
    ));
    specialOccasions.refresh();
  }

  /// Called by Add Custom Hobby dialog on submit. Adds to list (max 2). Dialog closes via Get.back().
  void addCustomHobby(String name) {
    if (customHobbies.length >= 2) return;
    customHobbies.add(name);
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
