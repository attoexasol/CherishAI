// lib/presentation/business_onboarding/products_services/views/add_product_service_dialog.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_shadows.dart';
import '../models/product_service_model.dart';

const double _kModalRadius = 20;
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 24;
const double _kHeaderIconSize = 40;
const double _kHeaderIconInner = 20;
const double _kCloseSize = 32;
const double _kBodyPadding = 24;
const double _kBodySpacing = 20;
const double _kLabelMb = 8;
const double _kInputPaddingH = 24;
const double _kInputPaddingV = 16;
const double _kInputRadius = 16;
const double _kTextAreaMinH = 80;
const double _kSliderHeight = 8;
const double _kSliderThumbSize = 20;
const double _kChipPaddingH = 12;
const double _kChipPaddingV = 6;
const double _kChipRadius = 999;
const double _kUploadIconSize = 48;
const double _kUploadIconInner = 24;
const double _kUploadPaddingV = 24;
const double _kUploadRadius = 16;
const double _kCtaPaddingV = 16;
const double _kCtaRadius = 16;
const double _kMaxModalWidth = 448;
const double _kMaxModalHeightFactor = 0.85;
const double _kDropdownFontSize = 14;

const List<String> _kOccasions = [
  'Birthday', 'Anniversary', 'Wedding', "Valentine's Day",
  "Mother's Day", "Father's Day", 'Graduation', 'Thank You',
  'Just Because', 'Apology', 'Congratulations', 'Get Well',
];

class AddProductServiceDialog extends StatefulWidget {
  const AddProductServiceDialog({
    super.key,
    required this.locations,
    required this.categories,
    required this.onAdd,
    required this.onCancel,
    this.initialProduct,
    this.onUpdate,
  });

  final List<Map<String, String>> locations;
  final List<Map<String, String>> categories;
  final void Function(ProductServiceModel product) onAdd;
  final VoidCallback onCancel;
  final ProductServiceModel? initialProduct;
  final void Function(ProductServiceModel product)? onUpdate;

  @override
  State<AddProductServiceDialog> createState() => _AddProductServiceDialogState();
}

class _AddProductServiceDialogState extends State<AddProductServiceDialog> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedLocation = '';
  String selectedCategory = '';
  double minPrice = 50;
  double maxPrice = 100;
  final Set<String> selectedOccasions = {};
  final List<String> selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  static const int _kMaxImages = 3;

  bool get _isEditMode => widget.initialProduct != null;

  @override
  void initState() {
    super.initState();
    final p = widget.initialProduct;
    if (p != null) {
      nameController.text = p.name;
      descriptionController.text = p.description;
      selectedLocation = p.siteId ?? '';
      selectedCategory = p.category;
      minPrice = p.priceMin;
      maxPrice = p.priceMax;
      selectedOccasions.addAll(p.tags);
      selectedImages.addAll(p.images);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void onPickImages() {
    if (selectedImages.length >= _kMaxImages) return;
    final ctx = context;
    showModalBottomSheet<void>(
      context: ctx,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Product Image',
                style: AppTextStyles.businessInfoLabel.copyWith(fontSize: 18),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.businessInfoPriceBadgeBgStart,
                  child: Icon(Icons.photo_library_outlined, color: AppColors.businessInfoBadgeStart),
                ),
                title: Text('Choose from Gallery', style: AppTextStyles.businessInfoInput),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickFromGallery();
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.businessInfoPriceBadgeBgStart,
                  child: Icon(Icons.camera_alt_outlined, color: AppColors.businessInfoBadgeStart),
                ),
                title: Text('Take Photo', style: AppTextStyles.businessInfoInput),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickFromCamera();
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFromGallery() async {
    try {
      final int remaining = _kMaxImages - selectedImages.length;
      final List<XFile> files = await _imagePicker.pickMultiImage(
        imageQuality: 85,
        limit: remaining,
      );
      if (files.isEmpty) return;
      if (!mounted) return;
      setState(() {
        for (final f in files) {
          if (selectedImages.length < _kMaxImages) selectedImages.add(f.path);
        }
      });
    } catch (_) {
      if (mounted) {
        Get.snackbar('Error', 'Could not pick image from gallery.');
      }
    }
  }

  Future<void> _pickFromCamera() async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );
      if (file == null) return;
      if (!mounted) return;
      setState(() {
        if (selectedImages.length < _kMaxImages) selectedImages.add(file.path);
      });
    } catch (_) {
      if (mounted) {
        Get.snackbar('Error', 'Could not take photo.');
      }
    }
  }

  void _removeImage(int index) {
    setState(() => selectedImages.removeAt(index));
  }

  void onSubmitAddProduct() {
    if (nameController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        selectedCategory.isEmpty ||
        selectedLocation.isEmpty) return;
    final product = ProductServiceModel(
      id: _isEditMode ? widget.initialProduct!.id : DateTime.now().millisecondsSinceEpoch.toString(),
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      priceMin: minPrice,
      priceMax: maxPrice,
      category: selectedCategory,
      tags: selectedOccasions.toList(),
      siteId: selectedLocation.isEmpty ? null : selectedLocation,
      images: List.from(selectedImages),
    );
    if (_isEditMode && widget.onUpdate != null) {
      widget.onUpdate!(product);
    } else {
      widget.onAdd(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: _kMaxModalWidth,
            maxHeight: MediaQuery.of(context).size.height * _kMaxModalHeightFactor,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_kModalRadius),
            boxShadow: [
              BoxShadow(offset: Offset(0, 20), blurRadius: 40, color: Colors.black.withValues(alpha: 0.2)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(_kBodyPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNameField(),
                      SizedBox(height: _kBodySpacing),
                      _buildLocationDropdown(),
                      SizedBox(height: _kBodySpacing),
                      _buildCategoryDropdown(),
                      SizedBox(height: _kBodySpacing),
                      _buildDescriptionField(),
                      SizedBox(height: _kBodySpacing),
                      _buildPriceRange(),
                      SizedBox(height: _kBodySpacing),
                      _buildOccasions(),
                      SizedBox(height: _kBodySpacing),
                      _buildProductImages(),
                      SizedBox(height: _kBodySpacing),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _kHeaderPaddingH, vertical: _kHeaderPaddingV),
      decoration: BoxDecoration(
        gradient: AppGradients.businessInfoBadge,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_kModalRadius),
          topRight: Radius.circular(_kModalRadius),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: _kHeaderIconSize,
            height: _kHeaderIconSize,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.inventory_2_rounded, size: _kHeaderIconInner, color: Colors.white),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_isEditMode ? 'Edit Product/Service' : 'Add Product/Service', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                SizedBox(height: 4),
                Text(_isEditMode ? 'Update your product details' : 'Tell us what you offer', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8))),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onCancel,
              borderRadius: BorderRadius.circular(_kCloseSize / 2),
              child: Container(
                width: _kCloseSize,
                height: _kCloseSize,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('×', style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product/Service Name *', style: AppTextStyles.businessInfoLabel),
        SizedBox(height: _kLabelMb),
        _input(
          controller: nameController,
          placeholder: 'e.g., Custom Bouquet',
        ),
      ],
    );
  }

  TextStyle get _dropdownTextStyle => TextStyle(
        fontSize: _kDropdownFontSize,
        color: AppColors.businessInfoInputText,
        fontWeight: FontWeight.w400,
      );

  TextStyle get _dropdownHintStyle => TextStyle(
        fontSize: _kDropdownFontSize,
        color: AppColors.businessInfoPlaceholder,
        fontWeight: FontWeight.w400,
      );

  Widget _buildLocationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location Name *', style: AppTextStyles.businessInfoLabel),
        SizedBox(height: _kLabelMb),
        _dropdown(
          value: selectedLocation,
          hint: 'Select a location',
          items: widget.locations.map((e) => DropdownMenuItem<String>(value: e['id'], child: Text(e['label']!, style: _dropdownTextStyle))).toList(),
          onChanged: (v) => setState(() => selectedLocation = v ?? ''),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product/Service Category *', style: AppTextStyles.businessInfoLabel),
        SizedBox(height: _kLabelMb),
        _dropdown(
          value: selectedCategory,
          hint: 'Select a category',
          items: widget.categories.map((e) => DropdownMenuItem<String>(value: e['value'], child: Text(e['label']!, style: _dropdownTextStyle))).toList(),
          onChanged: (v) => setState(() => selectedCategory = v ?? ''),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Description *', style: AppTextStyles.businessInfoLabel),
        SizedBox(height: _kLabelMb),
        Container(
          constraints: BoxConstraints(minHeight: _kTextAreaMinH),
          decoration: BoxDecoration(
            color: AppColors.businessInfoInputBg,
            borderRadius: BorderRadius.circular(_kInputRadius),
            border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
          ),
          child: TextField(
            controller: descriptionController,
            maxLines: 4,
            style: AppTextStyles.businessInfoInput,
            decoration: InputDecoration(
              hintText: 'Brief description of what you offer...',
              hintStyle: TextStyle(color: AppColors.businessInfoPlaceholder),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Price Range *', style: AppTextStyles.businessInfoLabel),
            SizedBox(width: 8),
            Text('\$${minPrice.round()} - \$${maxPrice.round()}', style: AppTextStyles.businessInfoPriceBadge),
          ],
        ),
        SizedBox(height: 12),
        Text('Minimum Price', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: _kSliderHeight,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: _kSliderThumbSize / 2),
            overlayShape: RoundSliderOverlayShape(overlayRadius: _kSliderThumbSize / 2 + 4),
            activeTrackColor: AppColors.businessInfoBadgeStart,
            inactiveTrackColor: AppColors.businessInfoInputBorder,
            thumbColor: AppColors.businessInfoBadgeStart,
          ),
          child: Slider(
            value: minPrice.clamp(0.0, maxPrice),
            min: 0,
            max: 1000,
            divisions: 200,
            onChanged: (v) => setState(() {
              minPrice = v;
              if (minPrice > maxPrice) maxPrice = minPrice;
            }),
          ),
        ),
        SizedBox(height: 8),
        Text('Maximum Price', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
        SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: _kSliderHeight,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: _kSliderThumbSize / 2),
            overlayShape: RoundSliderOverlayShape(overlayRadius: _kSliderThumbSize / 2 + 4),
            activeTrackColor: AppColors.businessInfoSliderThumbEnd,
            inactiveTrackColor: AppColors.businessInfoInputBorder,
            thumbColor: AppColors.businessInfoSliderThumbEnd,
          ),
          child: Slider(
            value: maxPrice.clamp(minPrice, 1000.0),
            min: 0,
            max: 1000,
            divisions: 200,
            onChanged: (v) => setState(() {
              maxPrice = v;
              if (maxPrice < minPrice) minPrice = maxPrice;
            }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$0', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
            Text('\$500', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
            Text('\$1000', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
          ],
        ),
      ],
    );
  }

  Widget _buildOccasions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Occasions (Optional)', style: AppTextStyles.businessInfoLabel),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _kOccasions.map((tag) {
            final selected = selectedOccasions.contains(tag);
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() {
                  if (selected) selectedOccasions.remove(tag);
                  else selectedOccasions.add(tag);
                }),
                borderRadius: BorderRadius.circular(_kChipRadius),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                  decoration: BoxDecoration(
                    gradient: selected ? AppGradients.businessInfoBadge : null,
                    color: selected ? null : AppColors.businessInfoPriceBadgeBgStart,
                    borderRadius: BorderRadius.circular(_kChipRadius),
                    border: selected ? null : Border.all(color: AppColors.businessInfoInputBorder),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      color: selected ? Colors.white : AppColors.businessInfoUploadText,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProductImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Images (${selectedImages.length}/$_kMaxImages)', style: AppTextStyles.businessInfoLabel),
        SizedBox(height: 12),
        if (selectedImages.isNotEmpty) ...[
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final path = selectedImages[index];
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(_kUploadRadius),
                      child: Image.file(
                        File(path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _removeImage(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 1)),
                              ],
                            ),
                            child: Icon(Icons.close, size: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 12),
        ],
        if (selectedImages.length < _kMaxImages)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPickImages,
              borderRadius: BorderRadius.circular(_kUploadRadius),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: _kUploadPaddingV),
                decoration: BoxDecoration(
                  color: AppColors.businessInfoPriceBadgeBgStart,
                  borderRadius: BorderRadius.circular(_kUploadRadius),
                  border: Border.all(color: AppColors.businessInfoUploadBorder, width: 2, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Container(
                      width: _kUploadIconSize,
                      height: _kUploadIconSize,
                      decoration: BoxDecoration(
                        gradient: AppGradients.businessInfoBadge,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.cloud_upload_rounded, size: _kUploadIconInner, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text('Upload Product Images', style: AppTextStyles.businessInfoUploadTitle),
                    SizedBox(height: 4),
                    Text('Up to $_kMaxImages images, PNG or JPG', style: AppTextStyles.businessInfoUploadHint),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddButton() {
    final valid = nameController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        selectedCategory.isNotEmpty &&
        selectedLocation.isNotEmpty;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: valid ? onSubmitAddProduct : null,
        borderRadius: BorderRadius.circular(_kCtaRadius),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: _kCtaPaddingV),
          decoration: BoxDecoration(
            gradient: valid ? AppGradients.businessInfoCta : null,
            color: valid ? null : AppColors.businessInfoSliderInactive,
            borderRadius: BorderRadius.circular(_kCtaRadius),
            boxShadow: valid ? AppShadows.businessInfoCta : null,
          ),
          child: Center(child: Text(_isEditMode ? 'Update Product' : 'Add Product', style: AppTextStyles.businessInfoCta)),
        ),
      ),
    );
  }

  Widget _input({required TextEditingController controller, required String placeholder}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyles.businessInfoInput,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: AppColors.businessInfoPlaceholder),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _kInputPaddingH - 4, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint, style: _dropdownHintStyle),
          isExpanded: true,
          isDense: true,
          iconSize: 20,
          style: TextStyle(fontSize: _kDropdownFontSize, color: AppColors.businessInfoInputText, fontWeight: FontWeight.w400),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
