// lib/presentation/dislikes/controllers/dislikes_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Dislikes screen. Multi-select chips; Back/Continue/Add Custom match React.
class DislikesController extends GetxController {
  final RxList<String> selectedDislikeIds = <String>[].obs;
  final RxBool isSubmitting = false.obs;

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

  void onAddCustomDislike() {
    // Hook to existing modal/route. No new flow.
  }

  void onContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.personalNote);
    });
  }
}
