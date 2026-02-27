// lib/presentation/business_onboarding/products_services/controllers/products_services_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../models/product_service_model.dart';
import '../views/add_product_service_dialog.dart';

class ProductsServicesController extends GetxController {
  final RxInt usedCount = 0.obs;
  final int maxCount = 15;
  final RxList<ProductServiceModel> items = <ProductServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    usedCount.value = items.length;
  }

  void _updateUsedCount() {
    usedCount.value = items.length;
  }

  void onBack() => Get.back();

  List<Map<String, String>> get locations => [
        {'id': 'main', 'label': 'Main Location'},
      ];

  void openAddProductDialog() {
    Get.dialog<void>(
      AddProductServiceDialog(
        locations: locations,
        categories: categories,
        onAdd: addProduct,
        onCancel: () => Get.back(),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0x80000000),
    );
  }

  void openEditProductDialog(ProductServiceModel product) {
    Get.dialog<void>(
      AddProductServiceDialog(
        locations: locations,
        categories: categories,
        initialProduct: product,
        onAdd: addProduct,
        onUpdate: updateProduct,
        onCancel: () => Get.back(),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0x80000000),
    );
  }

  static const List<Map<String, String>> categories = [
    {'value': 'gifts', 'label': '🎁 Gifts & Personalized Items'},
    {'value': 'food', 'label': '🍽️ Food & Dining Experiences'},
    {'value': 'wellness', 'label': '🧘 Wellness & Self-Care Services'},
    {'value': 'entertainment', 'label': '🎭 Entertainment & Leisure'},
    {'value': 'fashion', 'label': '👗 Fashion & Style'},
    {'value': 'home', 'label': '🏠 Home & Lifestyle'},
    {'value': 'travel', 'label': '✈️ Travel & Getaways'},
    {'value': 'memories', 'label': '📸 Memories & Creative Services'},
    {'value': 'family', 'label': '👨‍👩‍👧‍👦 Family & Children Services'},
    {'value': 'learning', 'label': '📚 Learning & Personal Growth'},
  ];

  void onCompleteRegistration() {
    Get.offAllNamed(AppRoutes.businessDashboard);
  }

  void addProduct(ProductServiceModel product) {
    items.add(product);
    _updateUsedCount();
    Get.back();
  }

  void updateProduct(ProductServiceModel updated) {
    final index = items.indexWhere((p) => p.id == updated.id);
    if (index >= 0) {
      items[index] = updated;
      _updateUsedCount();
    }
    Get.back();
  }

  void deleteProduct(ProductServiceModel product) {
    items.remove(product);
    _updateUsedCount();
  }
}
