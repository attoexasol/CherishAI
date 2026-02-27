// lib/presentation/business_onboarding/products_services/models/product_service_model.dart

class ProductServiceModel {
  ProductServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.priceMin,
    required this.priceMax,
    required this.category,
    required this.tags,
    this.siteId,
    this.images = const [],
  });

  final String id;
  final String name;
  final String description;
  final double priceMin;
  final double priceMax;
  final String category;
  final List<String> tags;
  final String? siteId;
  final List<String> images;

  ProductServiceModel copyWith({
    String? id,
    String? name,
    String? description,
    double? priceMin,
    double? priceMax,
    String? category,
    List<String>? tags,
    String? siteId,
    List<String>? images,
  }) {
    return ProductServiceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      category: category ?? this.category,
      tags: tags ?? List.from(this.tags),
      siteId: siteId ?? this.siteId,
      images: images ?? List.from(this.images),
    );
  }
}
