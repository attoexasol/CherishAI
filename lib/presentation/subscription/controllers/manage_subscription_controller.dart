// lib/presentation/subscription/controllers/manage_subscription_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../models/plan_model.dart';
import '../widgets/unsubscribe_dialog.dart';

/// Plan data for Manage Subscription screen. Derived from PlansData (single source).
class ManageSubPlan {
  const ManageSubPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.borderColorKey,
    this.popular = false,
  });
  final String id;
  final String name;
  final String price;
  final String period;
  final String description;
  final List<PlanIncludeItem> features;
  final String borderColorKey; // 'essential' | 'plus' | 'unlimited'
  final bool popular;
}

class ManageSubscriptionController extends GetxController {
  final RxBool showPlans = false.obs;
  final RxString currentPlanId = 'plus'.obs;

  static List<ManageSubPlan> get manageSubscriptionPlans => PlansData.plans.map((p) {
    return ManageSubPlan(
      id: p.id,
      name: p.displayTitleEmoji != null ? '${p.displayTitleEmoji} ${p.name}' : p.name,
      price: p.price,
      period: p.period,
      description: p.description ?? p.subtitle ?? p.name,
      features: p.includes,
      borderColorKey: p.id,
      popular: p.isRecommended,
    );
  }).toList();

  ManageSubPlan get currentPlan =>
      manageSubscriptionPlans.firstWhere((p) => p.id == currentPlanId.value, orElse: () => manageSubscriptionPlans[1]);

  void togglePlans() {
    showPlans.toggle();
  }

  void onUpgradePressed() {
    togglePlans();
  }

  void onUnsubscribePressed() {
    Get.dialog<void>(
      const UnsubscribeDialog(),
      barrierDismissible: false,
      barrierColor: AppColors.beforeYouGoBarrier,
    );
  }

  void onBack() => Get.back();
  void onHelp() => Get.toNamed(AppRoutes.helpFeedback);
  void onPauseSubscription() => Get.back();
  void onSwitchToLowerPlan() {
    Get.back();
    showPlans.value = true;
  }

  void onConfirmCancel() => Get.back();
  void onKeepSubscription() => Get.back();

  void onDowngradeToEssential() {
    final p = PlansData.essential;
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': p.id,
      'name': p.name,
      'price': p.price,
      'period': p.period,
      'tagline': p.subtitle,
    });
  }

  void onUpgradeToUnlimited() {
    final p = PlansData.unlimited;
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': p.id,
      'name': p.name,
      'price': p.price,
      'period': p.period,
      'tagline': p.subtitle,
    });
  }
}
