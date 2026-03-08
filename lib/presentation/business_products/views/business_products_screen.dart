// lib/presentation/business_products/views/business_products_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/business_products_controller.dart';
import '../../business_onboarding/products_services/models/product_service_model.dart';

const double _kCardRadius = 14;
const double _kImageSize = 72;
const double _kPaddingH = 24;
const double _kListPaddingBottom = 24;

class BusinessProductsScreen extends StatefulWidget {
  const BusinessProductsScreen({super.key, required this.businessId});

  final String businessId;

  @override
  State<BusinessProductsScreen> createState() => _BusinessProductsScreenState();
}

class _BusinessProductsScreenState extends State<BusinessProductsScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(BusinessProductsController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BusinessProductsController>().fetchBusinessProducts(widget.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BusinessProductsController>();
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.giftIdeasDetailPageBgStart,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.giftIdeasDetailCountdownDays),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Business Products',
          style: AppTextStyles.giftIdeasDetailEventTitle.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final products = controller.products;
        if (products.isEmpty) {
          return Center(
            child: Text(
              'No products available',
              style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 16),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(_kPaddingH, 16, _kPaddingH, _kListPaddingBottom + bottomPadding),
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ProductCard(product: product),
            );
          },
        );
      }),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final ProductServiceModel product;

  String get _priceRange {
    if (product.priceMin == product.priceMax) {
      return '\$${product.priceMin.toStringAsFixed(0)}';
    }
    return '\$${product.priceMin.toStringAsFixed(0)} – \$${product.priceMax.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = product.images.isNotEmpty;
    final imagePath = hasImage ? product.images.first : null;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_kCardRadius)),
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: _kImageSize,
                height: _kImageSize,
                child: _buildProductImage(imagePath),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(fontSize: 15),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(
                    _priceRange,
                    style: AppTextStyles.giftIdeasDetailWhyPerfectTitle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.giftIdeasDetailCountdownDays,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String? path) {
    if (path == null || path.isEmpty) {
      return ColoredBox(
        color: AppColors.giftIdeasDetailSecondaryBtnBg,
        child: Icon(Icons.shopping_bag_outlined, size: 32, color: AppColors.giftIdeasDetailFilterLabel),
      );
    }
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder());
    }
    final file = File(path);
    if (file.existsSync()) {
      return Image.file(file, fit: BoxFit.cover);
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return ColoredBox(
      color: AppColors.giftIdeasDetailSecondaryBtnBg,
      child: Icon(Icons.image_not_supported_outlined, size: 28, color: AppColors.giftIdeasDetailFilterLabel),
    );
  }
}
