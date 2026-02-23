// lib/presentation/checkout/controllers/checkout_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/plan_summary_model.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Checkout. Plan from Get.arguments; payment method selection; no payment logic changes.
class CheckoutController extends GetxController {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();

  final RxString selectedPaymentMethod = 'card'.obs;
  final Rx<PlanSummaryModel?> selectedPlan = Rx<PlanSummaryModel?>(null);
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _applyPlanFromArguments();
  }

  void _applyPlanFromArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final id = args['id'] as String?;
      final name = args['name'] as String?;
      final price = args['price'] as String?;
      var period = args['period'] as String?;
      final tagline = args['tagline'] as String?;
      if (id != null && name != null && price != null) {
        if (period != null && period.startsWith('/')) period = period.replaceFirst('/', '').trim();
        selectedPlan.value = PlanSummaryModel(
          id: id,
          name: name,
          priceDisplay: price,
          period: period ?? 'month',
          tagline: tagline,
        );
        return;
      }
    }
    selectedPlan.value = const PlanSummaryModel(
      id: 'plus',
      name: 'Cherish Plus',
      priceDisplay: '\$16',
      period: 'month',
      tagline: null,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    fullNameController.dispose();
    super.onClose();
  }

  void onBackToPlans() {
    Get.back();
  }

  void onSelectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void onCompletePurchase() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    // Hook to existing payment flow exactly like React. Do NOT implement here.
    Future.delayed(const Duration(milliseconds: 1500), () {
      isSubmitting.value = false;
      Get.offAllNamed(AppRoutes.home);
    });
  }
}
