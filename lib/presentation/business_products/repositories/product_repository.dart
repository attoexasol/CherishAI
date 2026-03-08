// lib/presentation/business_products/repositories/product_repository.dart
import '../../../core/storage/business_storage.dart';
import '../../business_onboarding/products_services/models/product_service_model.dart';

/// Loads products from storage. Products are keyed by siteId (business/location id).
class ProductRepository {
  /// Returns all saved products from storage (alias for getAllProducts).
  Future<List<ProductServiceModel>> getSavedProducts() async => getAllProducts();

  Future<List<ProductServiceModel>> getAllProducts() async {
    final raw = await BusinessStorage.loadProductsRaw();
    return raw.map(_mapToProduct).toList();
  }

  static ProductServiceModel _mapToProduct(Map<String, dynamic> map) {
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
}
