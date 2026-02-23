// lib/presentation/subscription/controllers/choose_plan_controller.dart
import 'package:get/get.dart';
import '../models/plan_model.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Choose your plan. Selection + purchase/cancel hooks match React.
/// Do NOT change subscription/payment logic; only call existing service methods.
class ChoosePlanController extends GetxController {
  final RxString selectedPlanId = 'plus'.obs;
  final RxBool isLoadingPurchase = false.obs;

  /// When true, show active subscription card at top (from existing data source).
  final RxBool hasActiveSubscription = true.obs;

  /// Active plan display (from existing subscription service).
  final RxString activePlanName = 'Cherish Plus'.obs;
  final RxString activePlanPriceLine = '\$16/month - Renews Feb 20, 2026'.obs;

  List<PlanModel> get plans => PlansData.plans;

  /// Selected plan for UI (border/checkmark). Default Plus.
  PlanModel get selectedPlan =>
      plans.firstWhere((p) => p.id == selectedPlanId.value, orElse: () => PlansData.plus);

  /// Bottom CTA label: "Start with Essential — $9/month" / "Start with Plus — $16/month" etc.
  String get bottomCtaLabel =>
      'Start with ${selectedPlan.ctaDisplayName} — ${selectedPlan.price}/month';

  void onBack() {
    Get.back();
  }

  void onSelectPlan(String planId) {
    selectedPlanId.value = planId;
  }

  void onStartSelectedPlan() {
    onStartPlan(selectedPlanId.value);
  }

  void onStartPlan(String planId) {
    if (isLoadingPurchase.value) return;
    isLoadingPurchase.value = true;
    final plan = plans.firstWhere((p) => p.id == planId, orElse: () => PlansData.plus);
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': plan.id,
      'name': plan.name,
      'price': plan.price,
      'period': plan.period,
      'tagline': plan.subtitle,
    });
    isLoadingPurchase.value = false;
  }

  void onCancelSubscription() {
    // Hook to existing cancel flow. Do NOT implement here.
  }
}
