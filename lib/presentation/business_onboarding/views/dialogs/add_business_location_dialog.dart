// lib/presentation/business_onboarding/views/dialogs/add_business_location_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_gradients.dart';
import '../../../../../app/theme/app_shadows.dart';
import '../../controllers/business_information_controller.dart';

const double _kDialogRadius = 20;
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 24;
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
const double _kCtaRadius = 16;
const double _kMaxDialogWidth = 448;
const double _kTextAreaMinHeight = 80;

class AddBusinessLocationDialog extends StatefulWidget {
  const AddBusinessLocationDialog({super.key});

  @override
  State<AddBusinessLocationDialog> createState() => _AddBusinessLocationDialogState();
}

class _AddBusinessLocationDialogState extends State<AddBusinessLocationDialog> {
  final _locationName = TextEditingController();
  final _country = TextEditingController();
  final _city = TextEditingController();
  final _postalCode = TextEditingController();
  final _stateRegion = TextEditingController();
  final _streetAddress = TextEditingController();
  final _contactPerson = TextEditingController();
  final _email = TextEditingController();
  final _tel = TextEditingController();
  final _description = TextEditingController();
  final _hours = TextEditingController();

  String _selectedCategory = '';
  double _priceRangeValue = 2.0;
  String _selectedDeliveryType = '';

  @override
  void dispose() {
    _locationName.dispose();
    _country.dispose();
    _city.dispose();
    _postalCode.dispose();
    _stateRegion.dispose();
    _streetAddress.dispose();
    _contactPerson.dispose();
    _email.dispose();
    _tel.dispose();
    _description.dispose();
    _hours.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessInformationController>();
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        constraints: BoxConstraints(maxWidth: _kMaxDialogWidth, maxHeight: MediaQuery.of(context).size.height * 0.85),
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
            _buildHeader(c),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(_kContentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _field('Location Name *', _locationName, 'e.g., Main Office, Branch 1'),
                    SizedBox(height: _kContentSpacing),
                    _field('Country *', _country, 'e.g., United States'),
                    SizedBox(height: _kContentSpacing),
                    _field('City *', _city, 'e.g., New York'),
                    SizedBox(height: _kContentSpacing),
                    _field('Postal Code *', _postalCode, 'e.g., 10001'),
                    SizedBox(height: _kContentSpacing),
                    _field('State/Region (optional)', _stateRegion, 'e.g., New York (Optional)'),
                    SizedBox(height: _kContentSpacing),
                    _field('Street Address (optional)', _streetAddress, 'e.g., 123 Main Street (Optional)'),
                    SizedBox(height: _kContentSpacing),
                    _field('Contact Person *', _contactPerson, 'Full name of primary contact'),
                    SizedBox(height: _kContentSpacing),
                    _field('Email', _email, 'e.g., contact@yourbusiness.com'),
                    SizedBox(height: _kContentSpacing),
                    _field('Tel', _tel, '(555) 123-4567'),
                    SizedBox(height: _kContentSpacing),
                    _buildCategoryDropdown(),
                    SizedBox(height: _kContentSpacing),
                    _buildLabel('Description'),
                    SizedBox(height: _kLabelMb),
                    _buildTextArea(_description, 'What makes this location special...'),
                    SizedBox(height: _kContentSpacing),
                    _buildPriceRange(),
                    SizedBox(height: _kContentSpacing),
                    _buildLabel('Operating Hours'),
                    SizedBox(height: _kLabelMb),
                    Text('Lets customers know when they can visit, contact, or book your services.', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12)),
                    SizedBox(height: _kHelperMb),
                    _field('', _hours, 'e.g., Mon-Fri · 9:00 AM – 6:00 PM'),
                    SizedBox(height: _kContentSpacing),
                    _buildDeliveryType(),
                    SizedBox(height: _kContentSpacing),
                    _buildUploadLogo(),
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

  Widget _buildHeader(BusinessInformationController c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _kHeaderPaddingH, vertical: _kHeaderPaddingV),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFA78BFA), Color(0xFF818CF8)],
        ),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(_kDialogRadius), topRight: Radius.circular(_kDialogRadius)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Business Location', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 4),
                Text('Add a new business location', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8))),
              ],
            ),
          ),
          Material(
            color: Colors.white.withOpacity(0.2),
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
    return Text(text, style: AppTextStyles.businessInfoLabel);
  }

  Widget _field(String label, TextEditingController controller, String hint) {
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

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Product or Services Category *'),
        SizedBox(height: _kLabelMb),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.businessInfoInputBg,
            borderRadius: BorderRadius.circular(_kInputRadius),
            border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              hint: Text('Select a category', style: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder), maxLines: 1, overflow: TextOverflow.ellipsis),
              isExpanded: true,
              isDense: true,
              items: BusinessInformationController.categories
                  .map((e) => DropdownMenuItem<String>(value: e['value'], child: Text(e['label']!, style: AppTextStyles.businessInfoInput, maxLines: 1, overflow: TextOverflow.ellipsis)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedCategory = v ?? ''),
              selectedItemBuilder: (context) => BusinessInformationController.categories.map((e) => Text(e['label']!, style: AppTextStyles.businessInfoInput, maxLines: 1, overflow: TextOverflow.ellipsis)).toList(),
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
        _buildLabel('Price Range *'),
        SizedBox(height: _kLabelMb),
        Text('This helps Cherish match your offerings to customers\' expectations and budgets.', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12)),
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
            value: _priceRangeValue,
            min: 1,
            max: 4,
            divisions: 3,
            onChanged: (v) => setState(() => _priceRangeValue = v.clamp(1.0, 4.0)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$ Budget', style: TextStyle(fontSize: 12, color: _priceRangeValue <= 1 ? const Color(0xFF059669) : AppColors.businessInfoDeliveryDesc)),
            Text('\$\$ Moderate', style: TextStyle(fontSize: 12, color: _priceRangeValue >= 1.5 && _priceRangeValue <= 2.5 ? const Color(0xFF4F46E5) : AppColors.businessInfoDeliveryDesc)),
            Text('\$\$\$ Upscale', style: TextStyle(fontSize: 12, color: _priceRangeValue >= 2.5 && _priceRangeValue <= 3.5 ? AppColors.businessInfoDeliveryIcon : AppColors.businessInfoDeliveryDesc)),
            Text('\$\$\$\$ Luxury', style: TextStyle(fontSize: 12, color: _priceRangeValue >= 3.5 ? const Color(0xFFE11D48) : AppColors.businessInfoDeliveryDesc)),
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
          child: Text(BusinessInformationController.priceRangeLabel(_priceRangeValue), style: AppTextStyles.businessInfoPriceBadge, textAlign: TextAlign.center),
        ),
      ],
    );
  }

  Widget _buildDeliveryType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Delivery Type *'),
        SizedBox(height: _kLabelMb),
        Text('Tell customers how your services or products can be accessed.', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12)),
        const SizedBox(height: 12),
        _deliveryCard(Icons.local_shipping_rounded, 'Delivery', 'Items can be delivered to the customer', 'delivery'),
        const SizedBox(height: 8),
        _deliveryCard(Icons.storefront_rounded, 'On-site', 'Services or experiences take place at your location', 'on-site'),
        const SizedBox(height: 8),
        _deliveryCard(Icons.computer_rounded, 'Digital', 'Online or digital services available', 'digital'),
      ],
    );
  }

  Widget _deliveryCard(IconData icon, String title, String desc, String value) {
    final selected = _selectedDeliveryType == value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedDeliveryType = value),
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
                  children: [
                    Text(title, style: AppTextStyles.businessInfoDeliveryTitle.copyWith(color: selected ? AppColors.businessInfoDeliveryTitleSelected : AppColors.businessInfoDeliveryTitle)),
                    const SizedBox(height: 4),
                    Text(desc, style: AppTextStyles.businessInfoDeliveryDesc),
                  ],
                ),
              ),
              if (selected) Icon(Icons.check_circle, size: 20, color: AppColors.businessInfoViewPlansBtnStart),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Business Logo/Photo'),
        SizedBox(height: _kLabelMb),
        Text('Upload a logo or photo to represent your business', style: AppTextStyles.businessInfoHelper.copyWith(fontSize: 12)),
        const SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(_kInputRadius),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColors.businessInfoInputBg,
                borderRadius: BorderRadius.circular(_kInputRadius),
                border: Border.all(color: AppColors.businessInfoUploadBorder, width: 2, style: BorderStyle.solid),
              ),
              child: Column(
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

  Widget _buildCta(BusinessInformationController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          c.onSubmitAddLocation();
        },
        borderRadius: BorderRadius.circular(_kCtaRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: _kCtaPaddingV),
          decoration: BoxDecoration(
            gradient: AppGradients.businessInfoCta,
            borderRadius: BorderRadius.circular(_kCtaRadius),
            boxShadow: AppShadows.businessInfoCta,
          ),
          child: Center(child: Text('Add Location', style: AppTextStyles.businessInfoCta)),
        ),
      ),
    );
  }
}
