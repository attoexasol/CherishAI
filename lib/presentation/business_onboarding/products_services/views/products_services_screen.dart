// lib/presentation/business_onboarding/products_services/views/products_services_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_shadows.dart';
import '../controllers/products_services_controller.dart';
import '../models/product_service_model.dart';

const double _kPaddingH = 24;
const double _kPaddingTop = 48;
const double _kPaddingBottom = 96;
const double _kMaxWidth = 520;
const double _kBackSize = 40;
const double _kBackMb = 24;
const double _kHeaderMb = 32;
const double _kTitleMb = 8;
const double _kUsageMt = 8;
const double _kAddCardPaddingV = 16;
const double _kAddCardRadius = 20;
const double _kAddCardIconSize = 24;
const double _kAddCardGap = 12;
const double _kBottomCtaPaddingH = 24;
const double _kBottomCtaBottom = 24;
const double _kCtaPaddingV = 16;
const double _kCtaRadius = 16;

class ProductsServicesScreen extends StatelessWidget {
  const ProductsServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductsServicesController>();
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.businessInfoPageBg),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    _kPaddingH,
                    _kPaddingTop,
                    _kPaddingH,
                    _kPaddingBottom + _kBottomCtaBottom + 56 + bottomPad,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildBackButton(c),
                          SizedBox(height: _kBackMb),
                          _buildHeader(c),
                          SizedBox(height: _kHeaderMb),
                          _buildProductList(c),
                          const SizedBox(height: 16),
                          _buildAddCard(c),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildBottomCta(context, c, bottomPad),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(ProductsServicesController c) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onBack,
          borderRadius: BorderRadius.circular(_kBackSize / 2),
          child: Container(
            width: _kBackSize,
            height: _kBackSize,
            decoration: BoxDecoration(
              color: AppColors.businessInfoBackBtnBg,
              shape: BoxShape.circle,
              boxShadow: AppShadows.businessInfoBackBtn,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.businessInfoBackIcon),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ProductsServicesController c) {
    return Obx(() {
      final used = c.usedCount.value;
      final max = c.maxCount;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Products & Services', style: AppTextStyles.businessInfoTitle),
          SizedBox(height: _kTitleMb),
          Text('What do you offer?', style: AppTextStyles.businessInfoSubtitle),
          SizedBox(height: _kUsageMt),
          Text(
            'Basic: Up to 15 products (1 location) • $used/$max used',
            style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 14, color: AppColors.businessInfoInputText),
          ),
        ],
      );
    });
  }

  Widget _buildAddCard(ProductsServicesController c) {
    return Obx(() {
      final canAdd = c.items.length < c.maxCount;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: canAdd ? c.openAddProductDialog : null,
          borderRadius: BorderRadius.circular(_kAddCardRadius),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: _kAddCardPaddingV),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(_kAddCardRadius),
              border: Border.all(
                color: canAdd ? AppColors.businessInfoUploadBorder : AppColors.businessInfoSliderInactive,
                width: 2,
                style: BorderStyle.solid,
              ),
              boxShadow: AppShadows.businessInfoUploadCard,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_rounded,
                  size: _kAddCardIconSize,
                  color: canAdd ? AppColors.businessInfoUploadText : AppColors.businessInfoDeliveryDesc,
                ),
                SizedBox(width: _kAddCardGap),
                Text(
                  'Add Product or Service',
                  style: AppTextStyles.businessInfoUploadTitle.copyWith(
                    color: canAdd ? AppColors.businessInfoUploadText : AppColors.businessInfoDeliveryDesc,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildProductList(ProductsServicesController c) {
    return Obx(() {
      if (c.items.isEmpty) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: c.items.map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _ProductCard(
                product: p,
                onEdit: () => c.openEditProductDialog(p),
                onDelete: () => c.deleteProduct(p),
              ),
            )).toList(),
      );
    });
  }

  Widget _buildBottomCta(BuildContext context, ProductsServicesController c, double bottomPad) {
    return Container(
      padding: EdgeInsets.fromLTRB(_kBottomCtaPaddingH, 16, _kBottomCtaPaddingH, _kBottomCtaBottom + bottomPad),
      decoration: BoxDecoration(
        color: AppColors.businessInfoPageBgEnd,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxWidth),
          child: SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onCompleteRegistration,
                borderRadius: BorderRadius.circular(_kCtaRadius),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: _kCtaPaddingV),
                  decoration: BoxDecoration(
                    gradient: AppGradients.businessInfoCta,
                    borderRadius: BorderRadius.circular(_kCtaRadius),
                    boxShadow: AppShadows.businessInfoCta,
                  ),
                  child: Center(
                    child: Text('Complete Registration', style: AppTextStyles.businessInfoCta),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const double _kProductCardThumbSize = 72;
const double _kProductCardThumbRadius = 12;

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });
  final ProductServiceModel product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final hasImages = product.images.isNotEmpty;
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(_kAddCardRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
        boxShadow: AppShadows.businessInfoUploadCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImages) ...[
            SizedBox(
              width: _kProductCardThumbSize,
              height: _kProductCardThumbSize,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_kProductCardThumbRadius),
                child: _ProductImage(path: product.images.first),
              ),
            ),
            SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTextStyles.businessInfoDeliveryTitle.copyWith(fontSize: 16)),
                if (product.description.isNotEmpty) ...[SizedBox(height: 4), Text(product.description, style: AppTextStyles.businessInfoUploadHint, maxLines: 2, overflow: TextOverflow.ellipsis)],
                SizedBox(height: 4),
                Text('\$${product.priceMin.round()} - \$${product.priceMax.round()}', style: AppTextStyles.businessInfoUploadTitle),
                if (product.tags.isNotEmpty) ...[SizedBox(height: 8), Wrap(spacing: 6, runSpacing: 4, children: product.tags.map((t) => Text(t, style: TextStyle(fontSize: 12, color: AppColors.businessInfoUploadText))).toList())],
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined, size: 20, color: AppColors.businessInfoDeliveryDesc),
                onPressed: onEdit,
              ),
              IconButton(
                icon: Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.businessInfoDeliveryDesc),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    final file = File(path);
    if (!file.existsSync()) {
      return ColoredBox(
        color: AppColors.businessInfoPriceBadgeBgStart,
        child: Icon(Icons.image_not_supported_outlined, size: 24, color: AppColors.businessInfoDeliveryDesc),
      );
    }
    return Image.file(file, fit: BoxFit.cover);
  }
}
