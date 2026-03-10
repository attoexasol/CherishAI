// lib/presentation/business_dashboard/controllers/business_dashboard_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/storage/business_storage.dart';
import '../../business_onboarding/products_services/controllers/products_services_controller.dart';
import '../../business_onboarding/products_services/models/product_service_model.dart';
import '../../business_onboarding/products_services/models/business_location_model.dart';
import '../settings/controllers/business_account_settings_controller.dart';
import '../settings/views/business_account_settings_dialog.dart';

class BusinessDashboardController extends GetxController {
  final RxInt views = 1200.obs;
  final RxInt interactions = 89.obs;
  final RxInt websiteClicks = 45.obs;
  final RxDouble viewsChangePct = 12.0.obs;
  final RxDouble interactionsChangePct = 8.0.obs;
  final RxDouble websiteChangePct = 5.0.obs;
  final RxString selectedTab = 'products'.obs; // 'products' or 'locations'
  final RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> locations = <Map<String, dynamic>>[].obs;

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredProducts {
    if (searchQuery.value.isEmpty) return products;
    final q = searchQuery.value;
    return products.where((p) {
      return ((p['name'] as String? ?? '').toLowerCase().contains(q));
    }).toList();
  }

  List<Map<String, dynamic>> get filteredLocations {
    final withName = locations.where((loc) => (loc['locationName'] as String? ?? '').trim().isNotEmpty).toList();
    if (searchQuery.value.isEmpty) return withName;
    final q = searchQuery.value;
    return withName.where((l) {
      return (l['locationName'] as String? ?? '').toLowerCase().contains(q);
    }).toList();
  }

  void onSearchChanged(String value) {
    searchQuery.value = value.trim().toLowerCase();
  }

  void switchTab(String tab) {
    selectedTab.value = tab;
    searchController.clear();
    searchQuery.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    loadAll();
  }

  @override
  void onReady() {
    super.onReady();
    // Reload when returning from other screens
    loadAll();
  }

  /// Load all data from storage
  Future<void> loadAll() async {
    final productsData = await BusinessStorage.loadProductsRaw();
    final locationsData = await BusinessStorage.loadLocationsRaw();
    products.value = productsData;
    locations.value = locationsData;
  }

  /// Add product
  Future<void> addProduct(Map<String, dynamic> productMap) async {
    products.add(productMap);
    await BusinessStorage.saveProductsRaw(products.toList());
  }

  /// Update product by id
  Future<void> updateProduct(String id, Map<String, dynamic> updatedMap) async {
    final index = products.indexWhere((p) => p['id'] == id);
    if (index >= 0) {
      products[index] = updatedMap;
      await BusinessStorage.saveProductsRaw(products.toList());
    }
  }

  /// Delete product by id
  Future<void> deleteProduct(String id) async {
    products.removeWhere((p) => p['id'] == id);
    await BusinessStorage.saveProductsRaw(products.toList());
  }

  /// Add location
  Future<void> addLocation(Map<String, dynamic> locationMap) async {
    locations.add(locationMap);
    await BusinessStorage.saveLocationsRaw(locations.toList());
  }

  /// Update location by id
  Future<void> updateLocation(String id, Map<String, dynamic> updatedMap) async {
    final index = locations.indexWhere((l) => l['id'] == id);
    if (index >= 0) {
      locations[index] = updatedMap;
      await BusinessStorage.saveLocationsRaw(locations.toList());
    }
  }

  /// Delete location by id
  Future<void> deleteLocation(String id) async {
    locations.removeWhere((l) => l['id'] == id);
    await BusinessStorage.saveLocationsRaw(locations.toList());
  }

  void onBack() {
    Get.offNamed(AppRoutes.productsServices);
  }

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

  /// Opens the same Add Business Location dialog as products/services screen.
  Future<void> openAddBusinessLocationDialog() async {
    if (Get.isRegistered<ProductsServicesController>()) {
      final productsController = Get.find<ProductsServicesController>();
      await productsController.openAddBusinessLocationDialog();
      // Reload after adding
      await loadAll();
    }
  }

  @override
  void onClose() {
    // Do not dispose searchController here: the dashboard screen may still be
    // in the tree (e.g. after closing a dialog), and its TextField would then
    // use a disposed controller. The controller is only re-created on next
    // navigation to dashboard, so avoiding dispose prevents "used after dispose".
    super.onClose();
  }

  void onToggleViewMode() {
    switchTab(selectedTab.value == 'products' ? 'locations' : 'products');
  }

  /// Open edit product dialog
  Future<void> onEditProduct(Map<String, dynamic> productMap) async {
    final product = _mapToProduct(productMap);
    if (Get.isRegistered<ProductsServicesController>()) {
      final productsController = Get.find<ProductsServicesController>();
      productsController.openEditProductDialog(product);
      // Reload after edit
      await loadAll();
    }
  }

  /// Delete product with confirmation
  Future<void> onDeleteProduct(Map<String, dynamic> productMap) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await deleteProduct(productMap['id'] as String);
      await loadAll();
    }
  }

  /// Open edit location dialog
  Future<void> onEditLocation(Map<String, dynamic> locationMap) async {
    final location = _mapToLocation(locationMap);
    if (Get.isRegistered<ProductsServicesController>()) {
      final productsController = Get.find<ProductsServicesController>();
      productsController.openEditBusinessLocationDialog(location);
      // Reload after edit
      await Future.delayed(const Duration(milliseconds: 300));
      await loadAll();
    }
  }

  /// Delete location with confirmation
  Future<void> onDeleteLocation(Map<String, dynamic> locationMap) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Location'),
        content: const Text('Are you sure you want to delete this location?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await deleteLocation(locationMap['id'] as String);
      await loadAll();
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

  /// Convert ProductServiceModel to Map for storage
  static Map<String, dynamic> productToMap(ProductServiceModel product) {
    return {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'priceMin': product.priceMin,
      'priceMax': product.priceMax,
      'category': product.category,
      'tags': product.tags,
      'siteId': product.siteId,
      'images': product.images,
    };
  }

  /// Convert BusinessLocationModel to Map for storage
  static Map<String, dynamic> locationToMap(BusinessLocationModel location) {
    return {
      'id': '${location.locationName}_${location.city}_${location.country}_${DateTime.now().millisecondsSinceEpoch}',
      'locationName': location.locationName,
      'country': location.country,
      'city': location.city,
      'postalCode': location.postalCode,
      'stateRegion': location.stateRegion,
      'streetAddress': location.streetAddress,
      'contactPerson': location.contactPerson,
      'email': location.email,
      'tel': location.tel,
      'category': location.category,
      'categories': location.categories,
      'description': location.description,
      'priceRangeValue': location.priceRangeValue,
      'operatingHours': location.operatingHours,
      'deliveryTypes': location.deliveryTypes,
      'logoPath': location.logoPath,
      'imagePaths': location.imagePaths,
    };
  }
}
