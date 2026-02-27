// lib/presentation/business_onboarding/views/business_information_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/business_information_controller.dart';

const double _kPaddingH = 24;
const double _kPaddingTop = 48;
const double _kPaddingBottom = 96;
const double _kMaxWidth = 520;
const double _kBackSize = 40;
const double _kBackMb = 24;
const double _kBadgeSize = 56;
const double _kBadgeMb = 16;
const double _kBadgeIconSize = 28;
const double _kTitleMb = 8;
const double _kFormSpacing = 20;
const double _kLabelMb = 8;
const double _kHelperMb = 8;
const double _kInputPaddingH = 24;
const double _kInputPaddingV = 16;
const double _kInputRadius = 16;
const double _kDeliveryCardPadding = 16;
const double _kDeliveryCardRadius = 16;
const double _kDeliveryIconSize = 20;
const double _kDeliveryCheckSize = 20;
const double _kPriceBadgePadding = 12;
const double _kPriceBadgeRadius = 12;
const double _kSliderHeight = 8;
const double _kSliderThumbSize = 24;
const double _kUploadIconCircleSize = 48;
const double _kUploadIconSize = 24;
const double _kSocialIconSize = 40;
const double _kSocialInputPaddingH = 16;
const double _kSocialInputPaddingV = 10;
const double _kSocialInputRadius = 12;
const double _kSocialRowGap = 12;
const double _kCtaPaddingH = 32;
const double _kCtaPaddingV = 16;
const double _kCtaRadius = 16;
const double _kAddLocationPaddingV = 12;
const double _kAddLocationPaddingH = 16;
const double _kAddLocationRadius = 12;
const double _kUpgradeCardPadding = 16;
const double _kUpgradeCardRadius = 16;
const double _kUpgradeCardMb = 12;
const double _kViewPlansPaddingV = 12;
const double _kViewPlansPaddingH = 16;
const double _kViewPlansRadius = 12;
const double _kTextAreaMinHeight = 100;

class BusinessInformationScreen extends StatelessWidget {
  const BusinessInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.businessInfoPageBg),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              _kPaddingH,
              _kPaddingTop,
              _kPaddingH,
              _kPaddingBottom + MediaQuery.paddingOf(context).bottom,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                child: Builder(
                  builder: (context) {
                    final c = Get.find<BusinessInformationController>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildBackButton(c),
                        SizedBox(height: _kBackMb),
                        _buildHeader(),
                        SizedBox(height: 32),
                        _buildForm(c),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BusinessInformationController c) {
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

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: _kBadgeSize,
          height: _kBadgeSize,
          margin: const EdgeInsets.only(bottom: _kBadgeMb),
          decoration: BoxDecoration(
            gradient: AppGradients.businessInfoBadge,
            shape: BoxShape.circle,
            boxShadow: AppShadows.businessInfoBadge,
          ),
          child: Icon(Icons.store_rounded, size: _kBadgeIconSize, color: Colors.white),
        ),
        Text('Business Information', style: AppTextStyles.businessInfoTitle, textAlign: TextAlign.center),
        SizedBox(height: _kTitleMb),
        Text('Tell Cherish AI about your business', style: AppTextStyles.businessInfoSubtitle, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildForm(BusinessInformationController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Business Name *'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.businessNameController, placeholder: 'Your Business Name'),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Product or Services Category *'),
        SizedBox(height: _kLabelMb),
        Obx(() => _buildDropdown(
          value: c.selectedCategory.value,
          hint: 'Select a category',
          items: BusinessInformationController.categories
              .map((e) => DropdownMenuItem<String>(value: e['value'], child: Text(e['label']!)))
              .toList(),
          onChanged: (v) => c.onSelectCategory(v ?? ''),
        )),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Contact Person Name *'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.contactPersonNameController, placeholder: 'Full name of primary contact'),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Email *'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.emailController, placeholder: 'E.g. contact@yourbusiness.com', keyboardType: TextInputType.emailAddress),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Location 1 Name *'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.locationNameController, placeholder: 'E.g. Downtown Branch, Main Street, etc.'),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Country *'),
        SizedBox(height: _kLabelMb),
        Obx(() => _buildDropdown(
          value: c.selectedCountry.value,
          hint: 'Select a country',
          items: BusinessInformationController.countries
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => c.onSelectCountry(v ?? ''),
        )),
        SizedBox(height: _kFormSpacing),
        _buildLabel('City *'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.cityController, placeholder: 'E.g. New York'),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Postal Code *'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.postalCodeController, placeholder: 'E.g. 10001', keyboardType: TextInputType.number),
        SizedBox(height: _kFormSpacing),
        _buildLabel('State/Region (optional)'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.stateRegionController, placeholder: 'E.g. New York (Optional)'),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Street Address (optional)'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.streetAddressController, placeholder: 'E.g. 123 Main Street (Optional)'),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Tel (optional)'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.telController, placeholder: 'E.g. +1 (123) 456-7890 (Optional)', keyboardType: TextInputType.phone),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Website (optional)'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.websiteController, placeholder: 'https://yourbusiness.com (Optional)', keyboardType: TextInputType.url),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Business Description *'),
        SizedBox(height: _kLabelMb),
        Text('Briefly describe what you offer. This helps customers understand your products & services.', style: AppTextStyles.businessInfoHelper),
        SizedBox(height: _kHelperMb),
        _buildTextArea(controller: c.descriptionController, placeholder: 'What makes your business unique...'),
        SizedBox(height: _kFormSpacing),
        _buildPriceRange(c),
        SizedBox(height: _kFormSpacing),
        _buildLabel('Operating Hours'),
        SizedBox(height: _kLabelMb),
        _buildInput(controller: c.hoursController, placeholder: 'E.g. Mon-Fri 9:00 AM - 5:00 PM'),
        SizedBox(height: _kFormSpacing),
        _buildDeliveryType(c),
        SizedBox(height: _kFormSpacing),
        _buildUploadLogo(c),
        SizedBox(height: _kFormSpacing),
        _buildSocialSection(c),
        SizedBox(height: 24),
        _buildContinueButton(c),
        SizedBox(height: _kFormSpacing),
        _buildAddLocation(c),
        SizedBox(height: _kUpgradeCardMb),
        _buildUpgradeCard(c),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.businessInfoLabel);
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String placeholder,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
        boxShadow: AppShadows.businessInfoInput,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: AppTextStyles.businessInfoInput,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
        ),
      ),
    );
  }

  Widget _buildTextArea({required TextEditingController controller, required String placeholder}) {
    return Container(
      constraints: const BoxConstraints(minHeight: _kTextAreaMinHeight),
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
        boxShadow: AppShadows.businessInfoInput,
      ),
      child: TextField(
        controller: controller,
        maxLines: 5,
        style: AppTextStyles.businessInfoInput,
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: _kInputPaddingV),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required String hint,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _kInputPaddingH, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.businessInfoInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
        boxShadow: AppShadows.businessInfoInput,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          hint: Text(hint, style: AppTextStyles.businessInfoInput.copyWith(color: AppColors.businessInfoPlaceholder)),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildPriceRange(BusinessInformationController c) {
    return Obx(() {
      final v = c.priceRangeValue.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Price Range *'),
          SizedBox(height: _kLabelMb),
          Text('Help Cherish match your offerings to customer expectations and budgets.', style: AppTextStyles.businessInfoHelper),
          SizedBox(height: 16),
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
              onChanged: c.onChangePrice,
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
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(_kPriceBadgePadding),
            decoration: BoxDecoration(
              gradient: AppGradients.businessInfoPriceBadge,
              borderRadius: BorderRadius.circular(_kPriceBadgeRadius),
              border: Border.all(color: AppColors.businessInfoPriceBadgeBorder),
            ),
            child: Text(
              BusinessInformationController.priceRangeLabel(v),
              style: AppTextStyles.businessInfoPriceBadge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildDeliveryType(BusinessInformationController c) {
    return Obx(() {
      final selected = c.selectedDeliveryType.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Delivery Type *'),
          SizedBox(height: _kLabelMb),
          Text('Tell customers how your services or products can be accessed.', style: AppTextStyles.businessInfoHelper),
          SizedBox(height: 12),
          _DeliveryCard(
            icon: Icons.local_shipping_rounded,
            title: 'Delivery',
            description: 'Items can be shipped, or via courier',
            isSelected: selected == 'delivery',
            onTap: () => c.onSelectDeliveryType('delivery'),
          ),
          SizedBox(height: 8),
          _DeliveryCard(
            icon: Icons.storefront_rounded,
            title: 'On-site',
            description: 'Customers can take advantage of your physical store',
            isSelected: selected == 'on-site',
            onTap: () => c.onSelectDeliveryType('on-site'),
          ),
          SizedBox(height: 8),
          _DeliveryCard(
            icon: Icons.computer_rounded,
            title: 'Digital',
            description: 'Online or digital services available',
            isSelected: selected == 'digital',
            onTap: () => c.onSelectDeliveryType('digital'),
          ),
        ],
      );
    });
  }

  Widget _buildUploadLogo(BusinessInformationController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Business Logo/Photo'),
        SizedBox(height: _kLabelMb),
        Text('Upload a logo or photo to represent your business.', style: AppTextStyles.businessInfoHelper),
        SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: c.onUploadLogo,
            borderRadius: BorderRadius.circular(_kInputRadius),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(_kInputRadius),
                border: Border.all(color: AppColors.businessInfoUploadBorder, width: 2, style: BorderStyle.solid),
                boxShadow: AppShadows.businessInfoUploadCard,
              ),
              child: Column(
                children: [
                  Container(
                    width: _kUploadIconCircleSize,
                    height: _kUploadIconCircleSize,
                    decoration: BoxDecoration(
                      gradient: AppGradients.businessInfoUploadIconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.cloud_upload_rounded, size: _kUploadIconSize, color: AppColors.businessInfoUploadIcon),
                  ),
                  SizedBox(height: 8),
                  Text('Click to upload photo', style: AppTextStyles.businessInfoUploadTitle),
                  SizedBox(height: 4),
                  Text('PNG, JPG up to 5MB', style: AppTextStyles.businessInfoUploadHint),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSection(BusinessInformationController c) {
    final rows = [
      _SocialRow(label: 'WhatsApp', icon: Icons.chat_rounded, controller: c.whatsappController),
      _SocialRow(label: 'Telegram', icon: Icons.send_rounded, controller: c.telegramController),
      _SocialRow(label: 'Instagram', icon: Icons.camera_alt_rounded, controller: c.instagramController),
      _SocialRow(label: 'Facebook', icon: Icons.facebook_rounded, controller: c.facebookController),
      _SocialRow(label: 'Reddit', icon: Icons.forum_rounded, controller: c.redditController),
      _SocialRow(label: 'Snapchat', icon: Icons.photo_camera_rounded, controller: c.snapchatController),
      _SocialRow(label: 'TikTok', icon: Icons.music_note_rounded, controller: c.tiktokController),
    ];
    return Container(
      padding: EdgeInsets.all(_kDeliveryCardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.businessInfoSocialCardBgStart, AppColors.businessInfoSocialCardBgEnd],
        ),
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.businessInfoSocialCardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.message_rounded, size: 20, color: AppColors.businessInfoDeliveryIcon),
              SizedBox(width: 8),
              Text('Social Media & Messaging', style: AppTextStyles.businessInfoLabel),
            ],
          ),
          SizedBox(height: 16),
          ...rows.map((r) => Padding(
                padding: EdgeInsets.only(bottom: _kSocialRowGap),
                child: Row(
                  children: [
                    Container(
                      width: _kSocialIconSize,
                      height: _kSocialIconSize,
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Icon(r.icon, size: 24, color: AppColors.businessInfoUploadIcon),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.businessInfoSocialInputBg,
                          borderRadius: BorderRadius.circular(_kSocialInputRadius),
                          border: Border.all(color: AppColors.businessInfoInputBorder, width: 2),
                        ),
                        child: TextField(
                          controller: r.controller,
                          style: AppTextStyles.businessInfoInput.copyWith(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: r.label,
                            hintStyle: TextStyle(color: AppColors.businessInfoPlaceholder, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: _kSocialInputPaddingH, vertical: _kSocialInputPaddingV),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BusinessInformationController c) {
    return Obx(() => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: c.isSubmitting.value ? null : c.onContinue,
            borderRadius: BorderRadius.circular(_kCtaRadius),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: _kCtaPaddingH, vertical: _kCtaPaddingV),
              decoration: BoxDecoration(
                gradient: c.isSubmitting.value ? null : AppGradients.businessInfoCta,
                color: c.isSubmitting.value ? AppColors.businessInfoSliderInactive : null,
                borderRadius: BorderRadius.circular(_kCtaRadius),
                boxShadow: c.isSubmitting.value ? null : AppShadows.businessInfoCta,
              ),
              child: Center(
                child: Text(
                  c.isSubmitting.value ? 'Please wait...' : 'Continue',
                  style: AppTextStyles.businessInfoCta,
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildAddLocation(BusinessInformationController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onAddLocation,
        borderRadius: BorderRadius.circular(_kAddLocationRadius),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: _kAddLocationPaddingV, horizontal: _kAddLocationPaddingH),
          decoration: BoxDecoration(
            color: AppColors.businessInfoAddLocationBg,
            borderRadius: BorderRadius.circular(_kAddLocationRadius),
            border: Border.all(color: AppColors.businessInfoAddLocationBorder, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 20, color: AppColors.businessInfoAddLocationText),
              SizedBox(width: 8),
              Text('Add another business location', style: AppTextStyles.businessInfoAddLocation),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradeCard(BusinessInformationController c) {
    return Container(
      padding: EdgeInsets.all(_kUpgradeCardPadding),
      decoration: BoxDecoration(
        gradient: AppGradients.businessInfoUpgradeCard,
        borderRadius: BorderRadius.circular(_kUpgradeCardRadius),
        border: Border.all(color: AppColors.businessInfoUpgradeCardBorder),
      ),
      child: Column(
        children: [
          Text(
            'Upgrade to Plus to add up to 7 locations',
            style: AppTextStyles.businessInfoUpgradeText,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onViewPlans,
              borderRadius: BorderRadius.circular(_kViewPlansRadius),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: _kViewPlansPaddingV, horizontal: _kViewPlansPaddingH),
                decoration: BoxDecoration(
                  gradient: AppGradients.businessInfoViewPlansBtn,
                  borderRadius: BorderRadius.circular(_kViewPlansRadius),
                ),
                child: Center(child: Text('View Plans', style: AppTextStyles.businessInfoViewPlans)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
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
            gradient: isSelected ? AppGradients.businessInfoDeliveryCardSelected : null,
            color: isSelected ? null : AppColors.businessInfoDeliveryCardBg,
            borderRadius: BorderRadius.circular(_kDeliveryCardRadius),
            border: Border.all(
              color: isSelected ? AppColors.businessInfoDeliveryCardSelectedBorder : AppColors.businessInfoDeliveryCardBorder,
              width: 2,
            ),
            boxShadow: isSelected ? AppShadows.businessInfoDeliveryCardSelected : null,
          ),
          child: Row(
            children: [
              Icon(icon, size: _kDeliveryIconSize, color: AppColors.businessInfoDeliveryIcon),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.businessInfoDeliveryTitle.copyWith(
                        color: isSelected ? AppColors.businessInfoDeliveryTitleSelected : AppColors.businessInfoDeliveryTitle,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(description, style: AppTextStyles.businessInfoDeliveryDesc),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  width: _kDeliveryCheckSize,
                  height: _kDeliveryCheckSize,
                  decoration: BoxDecoration(
                    color: AppColors.businessInfoViewPlansBtnStart,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check, size: 12, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialRow {
  const _SocialRow({required this.label, required this.icon, required this.controller});
  final String label;
  final IconData icon;
  final TextEditingController controller;
}
