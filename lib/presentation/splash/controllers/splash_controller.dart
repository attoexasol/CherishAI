// lib/presentation/splash/controllers/splash_controller.dart
import 'dart:async';
import 'package:get/get.dart';

/// Mirrors SplashScreen UI state and actions. No business/API changes.
class SplashController extends GetxController {
  /// Active feature index for carousel (0..2), cycles every 4500ms.
  final RxInt activeFeature = 0.obs;

  static const int featureCount = 3;
  Timer? _featureTimer;

  @override
  void onReady() {
    super.onReady();
    _featureTimer = Timer.periodic(
      const Duration(milliseconds: 4500),
      (_) => activeFeature.value = (activeFeature.value + 1) % featureCount,
    );
  }

  @override
  void onClose() {
    _featureTimer?.cancel();
    super.onClose();
  }

  /// Navigate to auth (same as React navigate('/auth')).
  void goToAuth() {
    Get.offNamed('/auth');
  }
}
