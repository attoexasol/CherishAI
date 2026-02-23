// lib/presentation/subscription_manage/controllers/manage_subscription_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../../subscription/models/plan_model.dart';
import '../views/before_you_go_dialog.dart';

/// Controller for Manage Subscription screen. Collapsed/expanded states and Unsubscribe flow.
/// Does NOT change business logic; wires to existing checkout/cancel flows.
class ManageSubscriptionController extends GetxController {
  /// When true, show full "Choose Your Plan" list; when false, only current plan card + Upgrade + Unsubscribe.
  final RxBool showPlans = false.obs;

  /// Current plan id from existing subscription source (e.g. plus).
  final RxString currentPlanId = 'plus'.obs;

  List<PlanModel> get plans => PlansData.plans;

  PlanModel get currentPlan =>
      plans.firstWhere((p) => p.id == currentPlanId.value, orElse: () => PlansData.plus);

  void onBack() {
    Get.back();
  }

  void onHelp() {
    Get.toNamed(AppRoutes.helpFeedback);
  }

  /// Expand plan list (tap "Upgrade" in collapsed state).
  void onUpgrade() {
    showPlans.value = true;
  }

  /// Collapse plan list (tap "Hide Plans").
  void onHidePlans() {
    showPlans.value = false;
  }

  /// Open "Before you go..." dialog when user taps Unsubscribe.
  void onUnsubscribe() {
    Get.dialog<void>(
      const BeforeYouGoDialog(),
      barrierDismissible: true,
      barrierColor: AppColors.beforeYouGoBarrier,
    );
  }

  /// Pause subscription (same flow as React). Hook to existing service.
  void onPauseSubscription() {
    Get.back();
    // TODO: call existing pause subscription API/service
  }

  /// Switch to a lower plan (navigate to manage subscription expanded or plan selection).
  void onSwitchToLowerPlan() {
    Get.back();
    showPlans.value = true;
  }

  /// User confirms cancel. Hook to existing cancel flow.
  void onConfirmCancel() {
    Get.back();
    // Same as ChoosePlanController.onCancelSubscription - existing cancel flow
  }

  /// Keep subscription: close dialog only.
  void onKeepSubscription() {
    Get.back();
  }

  /// Downgrade to Essential. Navigate to checkout with essential plan (existing flow).
  void onDowngradeToEssential() {
    final plan = PlansData.essential;
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': plan.id,
      'name': plan.name,
      'price': plan.price,
      'period': plan.period,
      'tagline': plan.subtitle,
    });
  }

  /// Upgrade to Unlimited. Navigate to checkout with unlimited plan (existing flow).
  void onUpgradeToUnlimited() {
    final plan = PlansData.unlimited;
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': plan.id,
      'name': plan.name,
      'price': plan.price,
      'period': plan.period,
      'tagline': plan.subtitle,
    });
  }
}
