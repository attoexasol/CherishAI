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
  /// Default false so new users see the 4-day trial section; set true when user has an active plan.
  final RxBool hasActiveSubscription = false.obs;

  /// Active plan display (from existing subscription service).
  final RxString activePlanName = 'Cherish Plus'.obs;
  final RxString activePlanPriceLine = '\$16/month - Renews Feb 20, 2026'.obs;

  List<PlanModel> get plans => PlansData.plans;

  /// Selected plan for UI (border/checkmark). Default Plus.
  PlanModel get selectedPlan =>
      plans.firstWhere((p) => p.id == selectedPlanId.value, orElse: () => PlansData.plus);

  /// Price text for selected plan, e.g. "\$9/month", "\$16/month".
  String get selectedPlanPriceText => '${selectedPlan.price}/month';

  /// Short name for selected plan (Essential / Plus / Unlimited).
  String get selectedPlanName => selectedPlan.ctaDisplayName;

  /// Bottom CTA label: for new users "Start 4-Day Free Trial — {price}/month", else subscriber CTA unchanged.
  String get bottomCtaLabel {
    if (!hasActiveSubscription.value) {
      return 'Start 4-Day Free Trial — $selectedPlanPriceText';
    }
    return 'Start with $selectedPlanName — $selectedPlanPriceText';
  }

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
