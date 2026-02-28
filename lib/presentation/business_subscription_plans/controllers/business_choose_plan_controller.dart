// lib/presentation/business_subscription_plans/controllers/business_choose_plan_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class BusinessChoosePlanModel {
  const BusinessChoosePlanModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.period,
    required this.description,
    required this.headerGradientColors,
    required this.emoji,
    required this.includesTitle,
    required this.includesItems,
    required this.analyticsTitle,
    required this.analyticsItems,
    this.isPopular = false,
  });
  final String id;
  final String name;
  final String subtitle;
  final int price;
  final String period;
  final String description;
  final List<Color> headerGradientColors;
  final String emoji;
  final String includesTitle;
  final List<String> includesItems;
  final String analyticsTitle;
  final List<String> analyticsItems;
  final bool isPopular;
}

class BusinessChoosePlanController extends GetxController {
  final RxString currentPlan = 'basic'.obs;

  static const List<BusinessChoosePlanModel> plans = [
    BusinessChoosePlanModel(
      id: 'basic',
      name: 'Business Partner -',
      subtitle: 'Basic',
      price: 10,
      period: 'month',
      description: 'For single-location businesses looking to be discovered locally',
      headerGradientColors: [Color(0xFFDBEAFE), Color(0xFFE0E7FF), Color(0xFFF5F3FF)],
      emoji: '✨',
      includesTitle: "What's included:",
      includesItems: [
        '1 business location',
        'Up to 15 products or services listed',
        'Business profile with website and social links viewed',
        'Your products & services proposed to the right users at the right moment of need',
      ],
      analyticsTitle: 'Analytics:',
      analyticsItems: ['Business site views', 'Impressions and interactions'],
      isPopular: false,
    ),
    BusinessChoosePlanModel(
      id: 'plus',
      name: 'Business Partner',
      subtitle: 'Plus',
      price: 19,
      period: 'month',
      description: 'For growing businesses with multiple locations and a broader presence',
      headerGradientColors: [Color(0xFFF3E8FF), Color(0xFFFCE7F3), Color(0xFFFFF1F2)],
      emoji: '👑',
      includesTitle: "What's included:",
      includesItems: [
        'Up to 7 business locations',
        'Up to 130 products or services listed',
        'Business profiles with website and social links',
        'Expanded visibility across multiple neighborhoods or cities',
        'Your business is suggested more broadly when care matters most',
      ],
      analyticsTitle: '',
      analyticsItems: [],
      isPopular: true,
    ),
  ];

  void onBackToDashboard() {
    Get.back();
  }

  void onUpgradeToPlus() {
    Get.toNamed(AppRoutes.businessInformation);
  }
}
