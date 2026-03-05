// lib/presentation/business_onboarding/products_services/widgets/add_business_location_dialog.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_shadows.dart';
import '../constants/business_category_options.dart';
import '../controllers/add_business_location_controller.dart';

const double _kDialogRadius = 23;
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 20;
const double _kCloseSize = 32;
const double _kContentPadding = 24;
const double _kContentSpacing = 20;
const double _kLabelMb = 8;
const double _kHelperMb = 4;
const double _kInputPaddingH = 24;
const double _kInputPaddingV = 16;
const double _kInputRadius = 16;
const double _kDeliveryCardPadding = 16;
const double _kDeliveryCardRadius = 16;
const double _kDeliveryIconSize = 20;
const double _kPriceBadgePadding = 12;
const double _kPriceBadgeRadius = 12;
const double _kSliderHeight = 8;
const double _kSliderThumbSize = 24;
const double _kUploadIconSize = 48;
const double _kCtaPaddingV = 16;
const double _kCtaRadius = 17;
const double _kMaxDialogWidth = 420;
const double _kTextAreaMinHeight = 80;
const Color _kHeaderPurple = Color(0xFF8B7CFF);
const int _kMaxImages = 3;
const double _kThumbSize = 72;
const double _kThumbRadius = 12;

class AddBusinessLocationDialog extends StatefulWidget {
  const AddBusinessLocationDialog({super.key});

  @override
  State<AddBusinessLocationDialog> createState() => _AddBusinessLocationDialogState();
}

class _AddBusinessLocationDialogState extends State<AddBusinessLocationDialog> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  void _showUploadSourceSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: AppColors.businessInfoInputBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(_kInputRadius)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Upload photo', style: AppTextStyles.businessInfoLabel),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.photo_camera, color: AppColors.businessInfoBadgeStart),
                title: Text('Camera', style: AppTextStyles.businessInfoInput),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: AppColors.businessInfoBadgeStart),
                title: Text('Gallery', style: AppTextStyles.businessInfoInput),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickFromGallery();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFromCamera() async {
    if (_selectedImages.length >= _kMaxImages) {
      Get.snackbar('', 'You can upload up to $_kMaxImages images.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      final XFile? img = await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
      if (img != null && mounted) {
        setState(() {
          if (_selectedImages.length < _kMaxImages) _selectedImages.add(img);
        });
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar('Upload', 'Could not open camera. Please check permissions.', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  Future<void> _pickFromGallery() async {
    if (_selectedImages.length >= _kMaxImages) {
      Get.snackbar('', 'You can upload up to $_kMaxImages images.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      final List<XFile> list = await _picker.pickMultiImage(imageQuality: 85);
      if (!mounted) return;
      final int remaining = _kMaxImages - _selectedImages.length;
      if (list.isEmpty) return;
      setState(() {
        for (int i = 0; i < list.length && _selectedImages.length < _kMaxImages; i++) {
          _selectedImages.add(list[i]);
        }
        if (list.length > remaining) {
          Get.snackbar('', 'You can upload up to $_kMaxImages images.', snackPosition: SnackPosition.BOTTOM);
        }
      });
    } catch (e) {
      if (mounted) {
        Get.snackbar('Upload', 'Could not open gallery. Please check permissions.', snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void _removeImage(int index) {
    setState(() => _selectedImages.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AddBusinessLocationController>();
    final width = MediaQuery.of(context).size.width;
    final dialogWidth = (width * 0.92).clamp(0.0, _kMaxDialogWidth);
    final horizontalPadding = ((width - dialogWidth) / 2).clamp(16.0, double.infinity);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_kDialogRadius),
          boxShadow: [
            BoxShadow(offset: const Offset(0, 25), blurRadius: 50, spreadRadius: -12, color: const Color(0x40000000)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(_kContentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _field(c, 'Location Name *', c.locationNameController, 'e.g., Main Office, Branch 1'),
                    SizedBox(height: _kContentSpacing),
                    _buildCountryField(c),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'City *', c.cityController, 'e.g., New York'),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'Postal Code *', c.postalCodeController, 'e.g., 10001'),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'State/Region (optional)', c.stateRegionController, 'e.g., New York (Optional)'),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'Street Address (optional)', c.streetAddressController, 'e.g., 123 Main Street (Optional)'),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'Contact Person *', c.contactPersonController, 'Full name of primary contact'),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'Email', c.emailController, 'e.g., contact@yourbusiness.com'),
                    SizedBox(height: _kContentSpacing),
                    _field(c, 'Tel', c.telController, '(555) 123-4567'),
                    SizedBox(height: _kContentSpacing),
                    _buildCategoryMultiSelect(c),
                    SizedBox(height: _kContentSpacing),
                    _buildLabel('Description'),
                    SizedBox(height: _kLabelMb),
                    _buildTextArea(c.descriptionController, 'What makes this location special...'),
                    SizedBox(height: _kContentSpacing),
                    _buildPriceRange(c),
                    SizedBox(height: _kContentSpacing),
                    _buildLabel('Operating Hours'),
                    SizedBox(height: _kLabelMb),
                    _field(c, '', c.operatingHoursController, 'e.g., Mon-Fri 9:00 AM - 5:00 PM'),
                    SizedBox(height: _kContentSpacing),
                    _buildDeliveryType(c),
                    SizedBox(height: _kContentSpacing),
                    _buildUploadPhotos(c),
                    SizedBox(height: _kContentSpacing),
                    _buildCta(c),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _kHeaderPaddingH, vertical: _kHeaderPaddingV),
      decoration: BoxDecoration(
        color: _kHeaderPurple,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(_kDialogRadius), topRight: Radius.circular(_kDialogRadius)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Business Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 4),
                Text('Add a new business location', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.9))),
              ],
            ),
          ),
          Material(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(_kCloseSize / 2),
            child: InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(_kCloseSize / 2),
              child: SizedBox(width: _kCloseSize, height: _kCloseSize, child: Icon(Icons.close, size: 20, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.businessInfoLabel, maxLines: 2, overflow: TextOverflow.ellipsis);
  }

  Widget _field(AddBusinessLocationController c, String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[_buildLabel(label), SizedBox(height: _kLabelMb)],
        Container(
          decoration: BoxDecoration(
            color: AppColors.businessInfoInputBg,
            borderRadius: BorderRadius.circular(_kInputRadius),
            border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
          ),
          child: TextField(
            controller: controller,
            style: AppTextStyles.businessInfoInput,
            maxLines: label.contains('Description') ? 4 : 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryField(AddBusinessLocationController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Country *'),
        SizedBox(height: _kLabelMb),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.businessInfoInputBg,
            borderRadius: BorderRadius.circular(_kInputRadius),
            border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
          ),
          child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: c.selectedCountry.value.isEmpty ? null : c.selectedCountry.value,
              hint: Text('Select a country', style: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder), maxLines: 1, overflow: TextOverflow.ellipsis),
              isExpanded: true,
              isDense: true,
              items: AddBusinessLocationController.countries
                  .map((e) => DropdownMenuItem<String>(value: e, child: Text(e, style: AppTextStyles.businessInfoInput, maxLines: 1, overflow: TextOverflow.ellipsis)))
                  .toList(),
              onChanged: (v) => c.selectedCountry.value = v ?? '',
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildTextArea(TextEditingController controller, String hint) {
    return Container(
      constraints: const BoxConstraints(minHeight: _kTextAreaMinHeight),
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: AppTextStyles.businessInfoInput,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
        ),
      ),
    );
  }

  static const int _kMaxChipsVisible = 2;

  void _showCategoryPickerSheet(AddBusinessLocationController c) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: AppColors.businessInfoInputBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(_kInputRadius)),
            border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select categories', style: AppTextStyles.businessInfoLabel),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text('Done', style: AppTextStyles.businessInfoInput.copyWith(fontWeight: FontWeight.w600, color: _kHeaderPurple)),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: AppColors.businessInfoInputBorder),
                Flexible(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: businessLocationCategoryOptions.length,
                    itemBuilder: (context, i) {
                      final e = businessLocationCategoryOptions[i];
                      final value = e['value']!;
                      final label = e['label']!;
                      final description = e['description'] ?? '';
                      return Obx(() {
                        final selected = c.selectedCategories.contains(value);
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => c.toggleCategory(value),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    selected ? Icons.check_box : Icons.check_box_outline_blank,
                                    size: 24,
                                    color: selected ? _kHeaderPurple : AppColors.businessInfoPlaceholder,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          label,
                                          style: AppTextStyles.businessInfoInput.copyWith(fontWeight: FontWeight.w600),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (description.isNotEmpty) ...[
                                          const SizedBox(height: 2),
                                          Text(
                                            description,
                                            style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12, color: AppColors.businessInfoPlaceholder),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryMultiSelect(AddBusinessLocationController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Product or Services Category *'),
        SizedBox(height: _kLabelMb),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _showCategoryPickerSheet(c),
            borderRadius: BorderRadius.circular(_kInputRadius),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
              decoration: BoxDecoration(
                color: AppColors.businessInfoInputBg,
                borderRadius: BorderRadius.circular(_kInputRadius),
                border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
              ),
              child: Obx(() {
                final selected = c.selectedCategories;
                if (selected.isEmpty) {
                  return Text(
                    'Select categories',
                    style: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                final optionMap = {for (var e in businessLocationCategoryOptions) e['value']!: e['label']!};
                final labels = selected.map((v) => optionMap[v] ?? v).toList();
                if (labels.length <= _kMaxChipsVisible) {
                  return Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: labels.map((l) => _categoryChip(l)).toList(),
                  );
                }
                final visible = labels.take(_kMaxChipsVisible).toList();
                final rest = labels.length - _kMaxChipsVisible;
                return Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ...visible.map((l) => _categoryChip(l)),
                    _categoryChip('+$rest more'),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _kHeaderPurple.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _kHeaderPurple.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.businessInfoInput.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPriceRange(AddBusinessLocationController c) {
    return Obx(() {
      final v = c.priceRangeValue.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Price Range *'),
          SizedBox(height: _kLabelMb),
          Text('Help Cherish match your offerings to customer expectations and budgets.', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: _kSliderHeight,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: _kSliderThumbSize / 2),
              overlayShape: RoundSliderOverlayShape(overlayRadius: _kSliderThumbSize / 2 + 4),
              activeTrackColor: AppColors.businessInfoSliderActive,
              inactiveTrackColor: AppColors.businessInfoSliderInactive,
              thumbColor: AppColors.businessInfoSliderThumbStart,
            ),
            child: Slider(
              value: v,
              min: 1,
              max: 4,
              divisions: 3,
              onChanged: (val) => c.priceRangeValue.value = val.clamp(1.0, 4.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ Budget', style: TextStyle(fontSize: 12, color: v <= 1 ? const Color(0xFF059669) : AppColors.businessInfoDeliveryDesc)),
              Text('\$\$ Moderate', style: TextStyle(fontSize: 12, color: v >= 1.5 && v <= 2.5 ? const Color(0xFF4F46E5) : AppColors.businessInfoDeliveryDesc)),
              Text('\$\$\$ Upscale', style: TextStyle(fontSize: 12, color: v >= 2.5 && v <= 3.5 ? AppColors.businessInfoDeliveryIcon : AppColors.businessInfoDeliveryDesc)),
              Text('\$\$\$\$ Luxury', style: TextStyle(fontSize: 12, color: v >= 3.5 ? const Color(0xFFE11D48) : AppColors.businessInfoDeliveryDesc)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(_kPriceBadgePadding),
            decoration: BoxDecoration(
              gradient: AppGradients.businessInfoPriceBadge,
              borderRadius: BorderRadius.circular(_kPriceBadgeRadius),
              border: Border.all(color: AppColors.businessInfoPriceBadgeBorder),
            ),
            child: Text(AddBusinessLocationController.priceRangeLabel(v), style: AppTextStyles.businessInfoPriceBadge, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
      );
    });
  }

  Widget _buildDeliveryType(AddBusinessLocationController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Delivery Type *'),
        SizedBox(height: _kLabelMb),
        Text('Tell customers how your services or products can be accessed.', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 12),
        Column(
          children: [
            _deliveryCard(c, Icons.local_shipping_rounded, 'Delivery', 'Items can be shipped, or via courier', 'delivery'),
            const SizedBox(height: 8),
            _deliveryCard(c, Icons.storefront_rounded, 'On-site', 'Customers can take advantage of your physical store', 'on-site'),
            const SizedBox(height: 8),
            _deliveryCard(c, Icons.computer_rounded, 'Digital', 'Online or digital services available', 'digital'),
          ],
        ),
      ],
    );
  }

  Widget _deliveryCard(AddBusinessLocationController c, IconData icon, String title, String desc, String value) {
    return Obx(() {
      final selected = c.selectedDeliveryTypes.contains(value);
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => c.onToggleDeliveryType(value),
          borderRadius: BorderRadius.circular(_kDeliveryCardRadius),
          child: Container(
            padding: const EdgeInsets.all(_kDeliveryCardPadding),
            decoration: BoxDecoration(
              gradient: selected ? AppGradients.businessInfoDeliveryCardSelected : null,
              color: selected ? null : AppColors.businessInfoDeliveryCardBg,
              borderRadius: BorderRadius.circular(_kDeliveryCardRadius),
              border: Border.all(
                color: selected ? AppColors.businessInfoDeliveryCardSelectedBorder : AppColors.businessInfoDeliveryCardBorder,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: _kDeliveryIconSize, color: AppColors.businessInfoDeliveryIcon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: AppTextStyles.businessInfoDeliveryTitle.copyWith(color: selected ? AppColors.businessInfoDeliveryTitleSelected : AppColors.businessInfoDeliveryTitle), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(desc, style: AppTextStyles.businessInfoDeliveryDesc, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                if (selected) Icon(Icons.check_circle, size: 20, color: AppColors.businessInfoViewPlansBtnStart),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildUploadPhotos(AddBusinessLocationController c) {
    final hasImages = _selectedImages.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Business Logo/Photo'),
        SizedBox(height: _kLabelMb),
        Text('Upload a logo or photo to represent your business.', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _selectedImages.length >= _kMaxImages ? null : _showUploadSourceSheet,
            borderRadius: BorderRadius.circular(_kInputRadius),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.businessInfoInputBg,
                borderRadius: BorderRadius.circular(_kInputRadius),
                border: Border.all(color: AppColors.businessInfoUploadBorder, width: 2, style: BorderStyle.solid),
              ),
              child: hasImages
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Product Images (${_selectedImages.length}/$_kMaxImages)', style: AppTextStyles.businessInfoUploadTitle),
                        const SizedBox(height: 12),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final crossCount = constraints.maxWidth > 280 ? 3 : 2;
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: List.generate(_selectedImages.length, (i) {
                                return _ThumbnailWithRemove(
                                  file: _selectedImages[i],
                                  onRemove: () => _removeImage(i),
                                );
                              }),
                            );
                          },
                        ),
                        if (_selectedImages.length < _kMaxImages) ...[
                          const SizedBox(height: 12),
                          Text('Tap to add more', style: AppTextStyles.businessInfoUploadHint),
                        ],
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          width: _kUploadIconSize,
                          height: _kUploadIconSize,
                          decoration: BoxDecoration(gradient: AppGradients.businessInfoUploadIconBg, shape: BoxShape.circle),
                          child: Icon(Icons.cloud_upload_rounded, size: 24, color: AppColors.businessInfoUploadIcon),
                        ),
                        const SizedBox(height: 8),
                        Text('Click to upload photo', style: AppTextStyles.businessInfoUploadTitle),
                        const SizedBox(height: 4),
                        Text('PNG, JPG up to 5MB', style: AppTextStyles.businessInfoUploadHint),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  void _onAddLocationTap(AddBusinessLocationController c) {
    c.logoFilePath.value = _selectedImages.isNotEmpty ? _selectedImages.first.path : '';
    c.submit();
  }

  Widget _buildCta(AddBusinessLocationController c) {
    return Obx(() {
      final submitting = c.isSubmitting.value;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: submitting ? null : () => _onAddLocationTap(c),
          borderRadius: BorderRadius.circular(_kCtaRadius),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: _kCtaPaddingV),
            decoration: BoxDecoration(
              gradient: submitting ? null : AppGradients.businessInfoCta,
              color: submitting ? AppColors.businessInfoSliderInactive : null,
              borderRadius: BorderRadius.circular(_kCtaRadius),
              boxShadow: submitting ? null : AppShadows.businessInfoCta,
            ),
            child: Center(child: Text('Add Location', style: AppTextStyles.businessInfoCta)),
          ),
        ),
      );
    });
  }
}

class _ThumbnailWithRemove extends StatelessWidget {
  const _ThumbnailWithRemove({required this.file, required this.onRemove});

  final XFile file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final path = file.path;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(_kThumbRadius),
          child: SizedBox(
            width: _kThumbSize,
            height: _kThumbSize,
            child: path.startsWith('http') || path.startsWith('blob')
                ? Image.network(path, fit: BoxFit.cover)
                : Image.file(File(path), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -4,
          right: -4,
          child: Material(
            color: Colors.black54,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: onRemove,
              customBorder: const CircleBorder(),
              child: const SizedBox(width: 24, height: 24, child: Icon(Icons.close, size: 16, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
