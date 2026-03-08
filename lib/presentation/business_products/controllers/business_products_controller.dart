// lib/presentation/business_products/controllers/business_products_controller.dart
import 'package:get/get.dart';
import '../repositories/product_repository.dart';
import '../../business_onboarding/products_services/models/product_service_model.dart';

class BusinessProductsController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  final RxList<ProductServiceModel> products = <ProductServiceModel>[].obs;
  final RxBool loading = true.obs;

  /// Loads all products belonging to the given business (filters by siteId == businessId).
  void loadProducts(String businessId) {
    fetchBusinessProducts(businessId);
  }

  Future<void> fetchBusinessProducts(String businessId) async {
    loading.value = true;
    try {
      final allProducts = await _productRepository.getSavedProducts();
      products.value = allProducts
          .where((p) => p.siteId == businessId)
          .toList();
    } finally {
      loading.value = false;
    }
  }
}
