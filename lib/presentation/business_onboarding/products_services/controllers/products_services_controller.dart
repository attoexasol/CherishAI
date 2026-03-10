// lib/presentation/business_onboarding/products_services/controllers/products_services_controller.dart
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/storage/business_storage.dart';
import '../../../business_dashboard/controllers/business_dashboard_controller.dart';
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
    _loadFromStorage();
    usedCount.value = items.length;
  }

  /// Load products and locations from storage
  Future<void> _loadFromStorage() async {
    try {
      final productsData = await BusinessStorage.loadProductsRaw();
      items.clear();
      for (final map in productsData) {
        items.add(_mapToProduct(map));
      }
      final locationsData = await BusinessStorage.loadLocationsRaw();
      locationsAdded.clear();
      for (final map in locationsData) {
        locationsAdded.add(_mapToLocation(map));
      }
    } catch (e) {
      // Handle error
    }
  }

  /// Convert Map to ProductServiceModel
  ProductServiceModel _mapToProduct(Map<String, dynamic> map) {
    return ProductServiceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      priceMin: (map['priceMin'] as num).toDouble(),
      priceMax: (map['priceMax'] as num).toDouble(),
      category: map['category'] as String,
      tags: List<String>.from(map['tags'] as List? ?? []),
      siteId: map['siteId'] as String?,
      images: List<String>.from(map['images'] as List? ?? []),
    );
  }

  /// Convert Map to BusinessLocationModel
  BusinessLocationModel _mapToLocation(Map<String, dynamic> map) {
    return BusinessLocationModel(
      locationName: map['locationName'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      postalCode: map['postalCode'] as String,
      stateRegion: map['stateRegion'] as String? ?? '',
      streetAddress: map['streetAddress'] as String? ?? '',
      contactPerson: map['contactPerson'] as String,
      email: map['email'] as String? ?? '',
      tel: map['tel'] as String? ?? '',
      category: map['category'] as String,
      categories: List<String>.from(map['categories'] as List? ?? []),
      description: map['description'] as String? ?? '',
      priceRangeValue: (map['priceRangeValue'] as num).toDouble(),
      operatingHours: map['operatingHours'] as String? ?? '',
      deliveryTypes: List<String>.from(map['deliveryTypes'] as List? ?? []),
      logoPath: map['logoPath'] as String?,
      imagePaths: List<String>.from(map['imagePaths'] as List? ?? []),
    );
  }

  void _updateUsedCount() {
    usedCount.value = items.length;
  }

  void onBack() => Get.back();

  Future<BusinessLocationModel?> openAddBusinessLocationDialog({BusinessLocationModel? initialLocation}) async {
    // Delete previous instance only when opening again, so we never dispose
    // TextEditingControllers while the dialog widget might still be in the tree.
    if (Get.isRegistered<AddBusinessLocationController>()) {
      Get.delete<AddBusinessLocationController>();
    }
    Get.put(AddBusinessLocationController());
    if (initialLocation != null) {
      final controller = Get.find<AddBusinessLocationController>();
      controller.locationNameController.text = initialLocation.locationName;
      controller.selectedCountry.value = initialLocation.country;
      controller.cityController.text = initialLocation.city;
      controller.postalCodeController.text = initialLocation.postalCode;
      controller.stateRegionController.text = initialLocation.stateRegion;
      controller.streetAddressController.text = initialLocation.streetAddress;
      controller.contactPersonController.text = initialLocation.contactPerson;
      controller.emailController.text = initialLocation.email;
      controller.telController.text = initialLocation.tel;
      controller.selectedCategories.value = List<String>.from(initialLocation.categories);
      controller.descriptionController.text = initialLocation.description;
      controller.priceRangeValue.value = initialLocation.priceRangeValue;
      controller.operatingHoursController.text = initialLocation.operatingHours;
      controller.selectedDeliveryTypes.value = List<String>.from(initialLocation.deliveryTypes);
      controller.logoFilePath.value = initialLocation.logoPath ?? '';
      // Use imagePaths if available, otherwise fall back to logoPath for backward compatibility
      final paths = initialLocation.imagePaths.isNotEmpty 
          ? initialLocation.imagePaths 
          : (initialLocation.logoPath != null && initialLocation.logoPath!.isNotEmpty 
              ? [initialLocation.logoPath!] 
              : []);
      controller.imagePaths.value = List<String>.from(paths);
    }
    final result = await Get.dialog<BusinessLocationModel>(
        AddBusinessLocationDialog(
          initialImagePaths: initialLocation != null 
              ? (initialLocation.imagePaths.isNotEmpty 
                  ? initialLocation.imagePaths 
                  : (initialLocation.logoPath != null && initialLocation.logoPath!.isNotEmpty 
                      ? [initialLocation.logoPath!] 
                      : []))
              : null,
        ),
        barrierDismissible: true,
        barrierColor: const Color(0x66000000),
      );
      // Only add valid location; empty/invalid entries would render as empty chips and cause blank white block.
      if (result != null && result.locationName.trim().isNotEmpty) {
        if (initialLocation != null) {
          // Update existing location
          final index = locationsAdded.indexWhere((loc) => 
            loc.locationName == initialLocation.locationName && 
            loc.city == initialLocation.city &&
            loc.country == initialLocation.country
          );
          if (index >= 0) {
            locationsAdded[index] = result;
            // Save to storage
            await _saveLocationsToStorage();
            // Update dashboard if available
            _updateDashboardLocation(result, isUpdate: true);
          }
        } else {
          // Add new location
          locationsAdded.add(result);
          // Save to storage
          await _saveLocationsToStorage();
          // Update dashboard if available
          _updateDashboardLocation(result, isUpdate: false);
        }
      }
    return result;
  }

  void openEditBusinessLocationDialog(BusinessLocationModel location) {
    openAddBusinessLocationDialog(initialLocation: location);
  }

  void deleteBusinessLocation(BusinessLocationModel location) async {
    locationsAdded.remove(location);
    await _saveLocationsToStorage();
    // Update dashboard if available
    if (Get.isRegistered<BusinessDashboardController>()) {
      final dashboard = Get.find<BusinessDashboardController>();
      final locationMap = BusinessDashboardController.locationToMap(location);
      final id = locationMap['id'] as String;
      await dashboard.deleteLocation(id);
    }
  }

  /// Save locations to storage
  Future<void> _saveLocationsToStorage() async {
    final locationsList = locationsAdded.map((loc) {
      return BusinessDashboardController.locationToMap(loc);
    }).toList();
    await BusinessStorage.saveLocationsRaw(locationsList);
  }

  /// Update dashboard location
  void _updateDashboardLocation(BusinessLocationModel location, {required bool isUpdate}) async {
    if (Get.isRegistered<BusinessDashboardController>()) {
      final dashboard = Get.find<BusinessDashboardController>();
      final locationMap = BusinessDashboardController.locationToMap(location);
      if (isUpdate) {
        // Find existing id
        final existingLocations = await BusinessStorage.loadLocationsRaw();
        final existing = existingLocations.firstWhereOrNull((l) => 
          l['locationName'] == location.locationName &&
          l['city'] == location.city &&
          l['country'] == location.country
        );
        if (existing != null) {
          await dashboard.updateLocation(existing['id'] as String, locationMap);
        }
      } else {
        await dashboard.addLocation(locationMap);
      }
    }
  }

  /// Location Name dropdown: Main Location + saved business locations from Add Business Location.
  /// When none added, fallback to Main Location only. When locations added, include Main + added so selection works and edit mode preselects.
  List<Map<String, String>> get locations {
    final added = locationsAdded;
    final fromAdded = added.asMap().entries
        .map((e) => {'id': 'loc_${e.key}', 'label': e.value.locationName})
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

  void addProduct(ProductServiceModel product) async {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Product save: location=${product.siteId}, images=${product.images.length}');
    }
    items.add(product);
    _updateUsedCount();
    // Save to storage
    await _saveProductsToStorage();
    // Update dashboard if available
    _updateDashboardProduct(product, isUpdate: false);
    Get.back();
  }

  void updateProduct(ProductServiceModel updated) async {
    if (kDebugMode) {
      // ignore: avoid_print
      print('Product update: location=${updated.siteId}, images=${updated.images.length}');
    }
    final index = items.indexWhere((p) => p.id == updated.id);
    if (index >= 0) {
      items[index] = updated;
      _updateUsedCount();
      // Save to storage
      await _saveProductsToStorage();
      // Update dashboard if available
      _updateDashboardProduct(updated, isUpdate: true);
    }
    Get.back();
  }

  void deleteProduct(ProductServiceModel product) async {
    items.remove(product);
    _updateUsedCount();
    // Save to storage
    await _saveProductsToStorage();
    // Update dashboard if available
    if (Get.isRegistered<BusinessDashboardController>()) {
      final dashboard = Get.find<BusinessDashboardController>();
      await dashboard.deleteProduct(product.id);
    }
  }

  /// Save products to storage
  Future<void> _saveProductsToStorage() async {
    final productsList = items.map((p) => BusinessDashboardController.productToMap(p)).toList();
    await BusinessStorage.saveProductsRaw(productsList);
  }

  /// Update dashboard product
  void _updateDashboardProduct(ProductServiceModel product, {required bool isUpdate}) async {
    if (Get.isRegistered<BusinessDashboardController>()) {
      final dashboard = Get.find<BusinessDashboardController>();
      final productMap = BusinessDashboardController.productToMap(product);
      if (isUpdate) {
        await dashboard.updateProduct(product.id, productMap);
      } else {
        await dashboard.addProduct(productMap);
      }
    }
  }
}
