// lib/presentation/subscription/controllers/manage_subscription_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../widgets/unsubscribe_dialog.dart';

/// Plan data for Manage Subscription screen only. Matches React allPlans exactly.
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
  final List<String> features;
  final String borderColorKey; // 'essential' | 'plus' | 'unlimited'
  final bool popular;
}

class ManageSubscriptionController extends GetxController {
  final RxBool showPlans = false.obs;
  final RxString currentPlanId = 'plus'.obs;

  static const List<ManageSubPlan> manageSubscriptionPlans = [
    ManageSubPlan(
      id: 'essential',
      name: 'Cherish Essential',
      price: '\$8',
      period: '/month',
      description: 'Perfect for getting started',
      features: [
        'Up to 3 loved ones',
        'Basic gift suggestions',
        'Event reminders',
        'Monthly message ideas',
      ],
      borderColorKey: 'essential',
      popular: false,
    ),
    ManageSubPlan(
      id: 'plus',
      name: 'Cherish Plus',
      price: '\$15',
      period: '/month',
      description: 'Most popular choice',
      features: [
        'Up to 6 loved ones',
        'Advanced AI gift ideas',
        'Unlimited event tracking',
        'Daily personalized messages',
        'Local business recommendations',
        'Priority support',
      ],
      borderColorKey: 'plus',
      popular: true,
    ),
    ManageSubPlan(
      id: 'unlimited',
      name: 'Cherish Unlimited',
      price: '\$25',
      period: '/month',
      description: 'For relationship experts',
      features: [
        'Unlimited loved ones',
        'Premium AI insights',
        'Unlimited everything',
        'Exclusive relationship tips',
        'Advanced analytics',
        'White-glove support',
        'Early access to new features',
      ],
      borderColorKey: 'unlimited',
      popular: false,
    ),
  ];

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
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': 'essential',
      'name': 'Cherish Essential',
      'price': '\$8',
      'period': '/month',
      'tagline': 'Perfect for getting started',
    });
  }

  void onUpgradeToUnlimited() {
    Get.toNamed(AppRoutes.checkout, arguments: {
      'id': 'unlimited',
      'name': 'Cherish Unlimited',
      'price': '\$25',
      'period': '/month',
      'tagline': 'For relationship experts',
    });
  }
}
