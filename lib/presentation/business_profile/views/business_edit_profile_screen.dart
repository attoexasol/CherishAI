// lib/presentation/business_profile/views/business_edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/business_profile_controller.dart';

const double _kMaxWidth = 600;
const double _kHeaderPaddingH = 20;
const double _kHeaderPaddingTop = 48;
const double _kHeaderPaddingBottom = 64;
const double _kBackPillPaddingH = 16;
const double _kBackPillPaddingV = 10;
const double _kBackPillRadius = 999;
const double _kCloseBtnSize = 40;
const double _kProfileSize = 80;
const double _kProfileRadius = 16;
const double _kContentOverlapPx = 24;
const double _kContentPaddingH = 20;
const double _kCardPadding = 24;
const double _kCardRadius = 20;
const double _kCardSpacing = 16;
const double _kLabelMb = 6;
const double _kInputPaddingH = 16;
const double _kInputPaddingV = 12;
const double _kInputRadius = 16;
const double _kSectionIconSize = 18;
const double _kSliderHeight = 8;
const double _kSliderThumbSize = 24;
const double _kDeliveryCardPadding = 12;
const double _kDeliveryCardRadius = 12;
const double _kUploadIconSize = 48;
const double _kCtaHeight = 56;
const double _kCtaBottomPadding = 24;
const double _kScrollBottomPadding = 120;

class BusinessEditProfileScreen extends StatelessWidget {
  const BusinessEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessProfileController>();
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.businessDashboardPageBg),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              _buildHeader(context, c, topPad),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    _kContentPaddingH,
                    0,
                    _kContentPaddingH,
                    _kScrollBottomPadding + _kCtaHeight + _kCtaBottomPadding + bottomPad,
                  ),
                  child: Transform.translate(
                    offset: Offset(0, -_kContentOverlapPx),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildBusinessInfoCard(c),
                            SizedBox(height: _kCardSpacing),
                            _buildContactCard(c),
                            SizedBox(height: _kCardSpacing),
                            _buildLocationCard(c),
                            SizedBox(height: _kCardSpacing),
                            _buildBusinessDetailsCard(c),
                            SizedBox(height: _kCardSpacing),
                            _buildLogoCard(c),
                            SizedBox(height: _kCardSpacing),
                            _buildSocialCard(c),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _buildSaveCta(context, c, bottomPad),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, BusinessProfileController c, double topPad) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(_kHeaderPaddingH, _kHeaderPaddingTop + topPad, _kHeaderPaddingH, _kHeaderPaddingBottom),
      decoration: BoxDecoration(gradient: AppGradients.businessDashboardHeader),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxWidth),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: c.onCloseEdit,
                      borderRadius: BorderRadius.circular(_kBackPillRadius),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: _kBackPillPaddingH, vertical: _kBackPillPaddingV),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(_kBackPillRadius),
                          border: Border.all(color: Color(0xFFE9D5FF), width: 2),
                          boxShadow: AppShadows.businessDashboardBackBtn,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.businessDashboardBackIcon),
                            SizedBox(width: 8),
                            Text('Back', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.businessDashboardBackIcon)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text('Edit Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: c.onCloseEdit,
                      borderRadius: BorderRadius.circular(_kCloseBtnSize / 2),
                      child: Container(
                        width: _kCloseBtnSize,
                        height: _kCloseBtnSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: AppShadows.businessDashboardBackBtn,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.close, size: 24, color: AppColors.businessDashboardBackIcon),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: _kProfileSize,
                    height: _kProfileSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(_kProfileRadius),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: AppShadows.businessDashboardBackBtn,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Obx(() => Image.network(
                      c.profilePhotoUrl.value,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.person_rounded, size: 40, color: AppColors.businessDashboardBackIcon),
                    )),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      gradient: AppGradients.businessInfoBadge,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: AppShadows.businessDashboardBackBtn,
                    ),
                    child: Icon(Icons.camera_alt_rounded, size: 14, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                c.businessNameController.text.isEmpty ? 'Business' : c.businessNameController.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                c.contactPersonController.text,
                style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppGradients.businessInfoBadge,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: Colors.white),
                    SizedBox(width: 6),
                    Text('Premium Partner', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.businessDashboardCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.businessDashboardCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: _kSectionIconSize, color: AppColors.businessInfoBadgeStart),
              SizedBox(width: 8),
              Text(title, style: AppTextStyles.businessDashboardSectionTitle.copyWith(fontSize: 16)),
            ],
          ),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _input(TextEditingController controller, {String? hint, int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: AppTextStyles.businessInfoInput,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.businessInfoPlaceholder, fontSize: 14),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
        ),
      ),
    );
  }

  Widget _buildBusinessInfoCard(BusinessProfileController c) {
    return _buildCard(
      icon: Icons.store_rounded,
      title: 'Business Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Business Name *', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.businessNameController, hint: 'Enter business name'),
          SizedBox(height: 16),
          Text('Category *', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          Obx(() => _dropdown(
            value: c.selectedCategory.value,
            hint: 'Select category',
            items: BusinessProfileController.categories.map((e) => DropdownMenuItem<String>(value: e['value'], child: Text(e['label']!))).toList(),
            onChanged: c.onSelectCategory,
          )),
          SizedBox(height: 16),
          Text('Contact Person *', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.contactPersonController, hint: 'Contact person name'),
          SizedBox(height: 16),
          Text('Description', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.descriptionController, hint: 'Tell customers about your business...', maxLines: 3),
        ],
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: (_kInputPaddingH - 4).clamp(0.0, double.infinity), vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint, style: TextStyle(fontSize: 14, color: AppColors.businessInfoPlaceholder)),
          isExpanded: true,
          items: items,
          onChanged: (v) { if (v != null) onChanged(v); },
        ),
      ),
    );
  }

  Widget _buildContactCard(BusinessProfileController c) {
    return _buildCard(
      icon: Icons.mail_outline_rounded,
      title: 'Contact Information',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.emailController, hint: 'email@example.com'),
          SizedBox(height: 16),
          Text('Phone', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.telController, hint: '+1 (555) 123-4567'),
          SizedBox(height: 16),
          Text('Website', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.websiteController, hint: 'https://yourbusiness.com'),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BusinessProfileController c) {
    return _buildCard(
      icon: Icons.location_on_outlined,
      title: 'Location',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Country *', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          Obx(() => _dropdown(
            value: c.selectedCountry.value,
            hint: 'Select a country',
            items: BusinessProfileController.countries.map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
            onChanged: c.onSelectCountry,
          )),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City *', style: AppTextStyles.businessInfoLabel),
                    SizedBox(height: _kLabelMb),
                    _input(c.cityController, hint: 'City'),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Postal Code *', style: AppTextStyles.businessInfoLabel),
                    SizedBox(height: _kLabelMb),
                    _input(c.postalCodeController, hint: '12345'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('State/Region', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.stateRegionController, hint: 'State or region'),
          SizedBox(height: 16),
          Text('Street Address', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.streetAddressController, hint: '123 Main Street'),
          SizedBox(height: 16),
          Text('Additional Locations', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onAddLocation,
              borderRadius: BorderRadius.circular(_kInputRadius),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.businessInfoAddLocationBorder),
                  borderRadius: BorderRadius.circular(_kInputRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_rounded, size: 20, color: AppColors.businessInfoAddLocationText),
                    SizedBox(width: 8),
                    Text('Add Location', style: AppTextStyles.businessInfoAddLocation),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsCard(BusinessProfileController c) {
    return _buildCard(
      icon: Icons.schedule_rounded,
      title: 'Business Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Operating Hours', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: _kLabelMb),
          _input(c.hoursController, hint: 'E.g., Mon-Fri 9:00 AM - 6:00 PM'),
          SizedBox(height: 16),
          Text('Price Range', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: 8),
          Obx(() {
            final v = c.priceRangeValue.value.round().clamp(1, 4);
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppGradients.businessInfoPriceBadge,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.businessInfoPriceBadgeBorder),
                  ),
                  child: Text(BusinessProfileController.priceRangeLabel(c.priceRangeValue.value), style: AppTextStyles.businessInfoPriceBadge, textAlign: TextAlign.center),
                ),
                SizedBox(height: 12),
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
                    value: c.priceRangeValue.value.clamp(1.0, 4.0),
                    min: 1,
                    max: 4,
                    divisions: 3,
                    onChanged: c.onChangePrice,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$ Budget', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
                    Text('\$\$ Moderate', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
                    Text('\$\$\$ Upscale', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
                    Text('\$\$\$\$ Luxury', style: TextStyle(fontSize: 12, color: AppColors.businessInfoDeliveryDesc)),
                  ],
                ),
              ],
            );
          }),
          SizedBox(height: 16),
          Text('Delivery Type', style: AppTextStyles.businessInfoLabel),
          SizedBox(height: 8),
          Obx(() => Column(
            children: [
              _DeliveryRow(icon: Icons.local_shipping_rounded, label: 'Delivery', isSelected: c.isDeliveryTypeSelected('delivery'), onTap: () => c.toggleDeliveryType('delivery')),
              SizedBox(height: 8),
              _DeliveryRow(icon: Icons.storefront_rounded, label: 'On-site', isSelected: c.isDeliveryTypeSelected('on-site'), onTap: () => c.toggleDeliveryType('on-site')),
              SizedBox(height: 8),
              _DeliveryRow(icon: Icons.computer_rounded, label: 'Digital', isSelected: c.isDeliveryTypeSelected('digital'), onTap: () => c.toggleDeliveryType('digital')),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildLogoCard(BusinessProfileController c) {
    return _buildCard(
      icon: Icons.camera_alt_rounded,
      title: 'Business Logo/Photo',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onUploadLogo,
          borderRadius: BorderRadius.circular(_kInputRadius),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: AppColors.businessInfoPriceBadgeBgStart,
              borderRadius: BorderRadius.circular(_kInputRadius),
              border: Border.all(color: AppColors.businessInfoUploadBorder, width: 2, style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                Container(
                  width: _kUploadIconSize,
                  height: _kUploadIconSize,
                  decoration: BoxDecoration(gradient: AppGradients.businessInfoBadge, shape: BoxShape.circle),
                  child: Icon(Icons.camera_alt_rounded, size: 24, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text('Click to upload photo', style: AppTextStyles.businessInfoUploadTitle),
                SizedBox(height: 4),
                Text('PNG, JPG up to 5MB', style: AppTextStyles.businessInfoUploadHint),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialCard(BusinessProfileController c) {
    final rows = [
      _SocialRow(controller: c.whatsappController, label: 'WhatsApp'),
      _SocialRow(controller: c.telegramController, label: 'Telegram'),
      _SocialRow(controller: c.instagramController, label: 'Instagram'),
      _SocialRow(controller: c.facebookController, label: 'Facebook'),
      _SocialRow(controller: c.redditController, label: 'Reddit'),
      _SocialRow(controller: c.snapchatController, label: 'Snapchat'),
      _SocialRow(controller: c.tiktokController, label: 'TikTok'),
    ];
    return _buildCard(
      icon: Icons.chat_bubble_outline_rounded,
      title: 'Social Media & Messaging',
      child: Column(
        children: rows.map((r) => Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: AppColors.businessInfoPriceBadgeBgStart, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(Icons.chat_rounded, size: 20, color: AppColors.businessInfoBadgeStart),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _input(r.controller, hint: r.label),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSaveCta(BuildContext context, BusinessProfileController c, double bottomPad) {
    return Container(
      padding: EdgeInsets.fromLTRB(_kContentPaddingH, 16, _kContentPaddingH, _kCtaBottomPadding + bottomPad),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.01)),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxWidth),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onSaveAllChanges,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                height: _kCtaHeight,
                decoration: BoxDecoration(
                  gradient: AppGradients.businessInfoCta,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppShadows.businessInfoCta,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_rounded, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Save All Changes', style: AppTextStyles.businessInfoCta),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DeliveryRow extends StatelessWidget {
  const _DeliveryRow({required this.icon, required this.label, required this.isSelected, required this.onTap});
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kDeliveryCardRadius),
        child: Container(
          padding: EdgeInsets.all(_kDeliveryCardPadding),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.businessInfoDeliveryCardSelectedBgStart : Colors.white,
            borderRadius: BorderRadius.circular(_kDeliveryCardRadius),
            border: Border.all(
              color: isSelected ? AppColors.businessInfoDeliveryCardSelectedBorder : AppColors.businessInfoDeliveryCardBorder,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.businessInfoDeliveryIcon),
              SizedBox(width: 12),
              Text(label, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? AppColors.businessInfoDeliveryTitleSelected : AppColors.businessInfoDeliveryTitle)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialRow {
  const _SocialRow({required this.controller, required this.label});
  final TextEditingController controller;
  final String label;
}
