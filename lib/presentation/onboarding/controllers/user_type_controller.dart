// lib/presentation/onboarding/controllers/user_type_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for User Type selection. Navigation matches React:
/// back -> auth; individual -> /individual/user-info; business -> /business/splash.
class UserTypeController extends GetxController {
  final Rx<String?> selectedType = Rx<String?>(null);
  final RxBool isNavigating = false.obs;

  static const _kDelayMs = 600;

  void onBack() {
    Get.offNamed(AppRoutes.auth);
  }

  void onSelectIndividual() {
    if (isNavigating.value) return;
    selectedType.value = 'individual';
    isNavigating.value = true;
    Future.delayed(const Duration(milliseconds: _kDelayMs), () {
      isNavigating.value = false;
      Get.offNamed(AppRoutes.individualUserInfo);
    });
  }

  void onSelectBusiness() {
    if (isNavigating.value) return;
    selectedType.value = 'business';
    isNavigating.value = true;
    Future.delayed(const Duration(milliseconds: _kDelayMs), () {
      isNavigating.value = false;
      Get.toNamed(AppRoutes.businessSplash);
    });
  }
}
