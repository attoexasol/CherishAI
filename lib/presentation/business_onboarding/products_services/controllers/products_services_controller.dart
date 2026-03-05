// lib/presentation/business_onboarding/products_services/controllers/products_services_controller.dart
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../constants/business_category_options.dart';
import '../models/business_location_model.dart';
import '../models/product_service_model.dart';
import '../views/add_product_service_dialog.dart';
import '../widgets/add_business_location_dialog.dart';
import 'add_business_location_controller.dart';

class ProductsServicesController extends GetxController {
  final RxInt usedCount = 0.obs;
  final int maxCount = 15;
  final RxList<ProductServiceModel> items = <ProductServiceModel>[].obs;

  /// Locations added via "Add Business Location" dialog (for chip preview).
  final RxList<BusinessLocationModel> locationsAdded = <BusinessLocationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    usedCount.value = items.length;
  }

  void _updateUsedCount() {
    usedCount.value = items.length;
  }

  void onBack() => Get.back();

  Future<BusinessLocationModel?> openAddBusinessLocationDialog() async {
    Get.put(AddBusinessLocationController());
    try {
      final result = await Get.dialog<BusinessLocationModel>(
        const AddBusinessLocationDialog(),
        barrierDismissible: true,
        barrierColor: const Color(0x66000000),
      );
      // Only add valid location; empty/invalid entries would render as empty chips and cause blank white block.
      if (result != null && result.locationName.trim().isNotEmpty) {
        locationsAdded.add(result);
      }
      return result;
    } finally {
      if (Get.isRegistered<AddBusinessLocationController>()) {
        // Defer delete so the dialog is fully unmounted before controllers are disposed.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (Get.isRegistered<AddBusinessLocationController>()) {
            Get.delete<AddBusinessLocationController>();
          }
        });
      }
    }
  }

  /// Location Name dropdown: Main Location + saved business locations from Add Business Location.
  /// When none added, fallback to Main Location only. When locations added, include Main + added so selection works and edit mode preselects.
  List<Map<String, String>> get locations {
    final added = locationsAdded;
    final fromAdded = added.indexed
        .map((e) => {'id': 'loc_${e.$1}', 'label': e.$2.locationName})
        .toList();
    return [
      {'id': 'main', 'label': 'Main Location'},
      ...fromAdded,
    ];
  }

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

  /// Same list as business location; product registration uses single-select only.
  static List<Map<String, String>> get categories => List<Map<String, String>>.from(businessLocationCategoryOptions);

  void onCompleteRegistration() {
    Get.offAllNamed(AppRoutes.businessDashboard);
  }

  void addProduct(ProductServiceModel product) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Product save: location=${product.siteId}, images=${product.images.length}');
    }
    items.add(product);
    _updateUsedCount();
    Get.back();
  }

  void updateProduct(ProductServiceModel updated) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Product update: location=${updated.siteId}, images=${updated.images.length}');
    }
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
