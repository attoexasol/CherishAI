// lib/presentation/business_dashboard/controllers/business_dashboard_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../settings/controllers/business_account_settings_controller.dart';
import '../settings/views/business_account_settings_dialog.dart';

class BusinessDashboardController extends GetxController {
  final RxInt views = 1200.obs;
  final RxInt interactions = 89.obs;
  final RxInt websiteClicks = 45.obs;
  final RxDouble viewsChangePct = 12.0.obs;
  final RxDouble interactionsChangePct = 8.0.obs;
  final RxDouble websiteChangePct = 5.0.obs;
  final RxBool hasProducts = false.obs;

  void onBack() => Get.back();

  void onOpenSettings() {
    Get.put(BusinessAccountSettingsController(), permanent: false);
    Get.dialog<void>(
      const BusinessAccountSettingsDialog(),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  void onManageProducts() {
    Get.toNamed(AppRoutes.productsServices);
  }

  void onAddProduct() {
    Get.toNamed(AppRoutes.productsServices);
  }

  void onViewPlans() {
    Get.toNamed(AppRoutes.businessChoosePlan);
  }
}
