// lib/presentation/business_subscription/controllers/business_manage_subscription_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/business_unsubscribe_dialog.dart';
import '../widgets/business_cancel_reason_dialog.dart';
import '../widgets/business_cancel_final_step_dialog.dart';

class BusinessPlan {
  const BusinessPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    required this.features,
    required this.gradientColors,
    required this.cardBgColors,
    required this.borderColor,
    this.popular = false,
  });
  final String id;
  final String name;
  final String price;
  final String period;
  final String description;
  final List<String> features;
  final List<int> gradientColors;
  final List<int> cardBgColors;
  final int borderColor;
  final bool popular;
}

class BusinessManageSubscriptionController extends GetxController {
  final RxBool showPlans = false.obs;
  final RxString currentPlanId = 'basic'.obs;
  final RxString cancelReason = ''.obs;
  final TextEditingController cancelFeedbackController = TextEditingController();

  static const List<BusinessPlan> businessPlans = [
    BusinessPlan(
      id: 'basic',
      name: 'Business Partner - Basic',
      price: '\$10',
      period: '/month',
      description: 'For single-location businesses',
      features: [
        '1 business location',
        'Up to 15 products or services',
        'Business profile with links',
        'Smart user matching',
        'Basic analytics',
      ],
      gradientColors: [0xFF60A5FA, 0xFF6366F1],
      cardBgColors: [0xFFEFF6FF, 0xFFE0E7FF],
      borderColor: 0xFF93C5FD,
      popular: false,
    ),
    BusinessPlan(
      id: 'plus',
      name: 'Business Partner Plus',
      price: '\$19',
      period: '/month',
      description: 'For growing businesses',
      features: [
        'Up to 7 business locations',
        'Up to 130 products or services',
        'Business profiles with links',
        'Expanded visibility',
        'Priority support',
        'Advanced analytics',
      ],
      gradientColors: [0xFFA78BFA, 0xFFEC4899],
      cardBgColors: [0xFFFAF5FF, 0xFFFDF2F8],
      borderColor: 0xFFE9D5FF,
      popular: true,
    ),
  ];

  BusinessPlan get currentPlan =>
      businessPlans.firstWhere((p) => p.id == currentPlanId.value, orElse: () => businessPlans.first);

  @override
  void onClose() {
    cancelFeedbackController.dispose();
    super.onClose();
  }

  void onTogglePlans() {
    showPlans.toggle();
  }

  void onUnsubscribe() {
    Get.dialog<void>(
      const BusinessUnsubscribeDialog(),
      barrierDismissible: false,
      barrierColor: AppColors.beforeYouGoBarrier,
    );
  }

  void onPauseSubscription() {
    Get.back();
  }

  void onConfirmCancel() {
    Get.back();
    Future.microtask(() => openCancelReasonDialog());
  }

  void onKeepSubscription() {
    _resetCancelFlow();
    Get.back();
  }

  void openCancelReasonDialog() {
    cancelReason.value = '';
    cancelFeedbackController.clear();
    Get.dialog<void>(
      const BusinessCancelReasonDialog(),
      barrierDismissible: false,
      barrierColor: AppColors.beforeYouGoBarrier,
    );
  }

  void openFinalStepDialog() {
    Get.dialog<void>(
      const BusinessCancelFinalStepDialog(),
      barrierDismissible: false,
      barrierColor: AppColors.beforeYouGoBarrier,
    );
  }

  void onSelectCancelReason(String reason) {
    cancelReason.value = reason;
  }

  void onConfirmCancelSubscription() {
    _performCancelSubscription();
    _resetCancelFlow();
    Get.back();
  }

  void _performCancelSubscription() {
    // Existing cancel/terminate hook - wire to API without changing payload or behavior.
  }

  void _resetCancelFlow() {
    cancelReason.value = '';
    cancelFeedbackController.clear();
  }

  void onBack() => Get.back();

  void onHelp() {
    Get.toNamed(AppRoutes.helpFeedback);
  }

  void onUpgradeToPlus() {
    Get.toNamed(AppRoutes.businessInformation);
  }
}
