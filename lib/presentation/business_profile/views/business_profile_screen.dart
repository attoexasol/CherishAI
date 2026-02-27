// lib/presentation/business_profile/views/business_profile_screen.dart
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
const double _kHeaderRadius = 0;
const double _kBackPillPaddingH = 16;
const double _kBackPillPaddingV = 10;
const double _kBackPillRadius = 999;
const double _kEditBtnSize = 40;
const double _kProfileSize = 80;
const double _kProfileRadius = 16;
const double _kContentOverlap = -48;
const double _kContentPaddingH = 20;
const double _kCardPadding = 24;
const double _kCardRadius = 20;
const double _kCardSpacing = 16;
const double _kSectionIconSize = 18;
const double _kRowIconSize = 40;
const double _kRowIconRadius = 12;
const double _kBottomBtnPaddingV = 12;
const double _kBottomBtnRadius = 16;
const double _kBottomAreaPadding = 96;

class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, c, topPad),
                Transform.translate(
                  offset: Offset(0, _kContentOverlap),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(_kContentPaddingH, 0, _kContentPaddingH, _kBottomAreaPadding + bottomPad),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildCard(
                              icon: Icons.store_rounded,
                              title: 'Business Information',
                              child: _buildBusinessInfo(c),
                            ),
                            SizedBox(height: _kCardSpacing),
                            _buildCard(
                              icon: Icons.mail_outline_rounded,
                              title: 'Contact Information',
                              child: _buildContactInfo(c),
                            ),
                            SizedBox(height: _kCardSpacing),
                            _buildCard(
                              icon: Icons.location_on_outlined,
                              title: 'Location',
                              child: _buildLocation(c),
                            ),
                            SizedBox(height: _kCardSpacing),
                            _buildCard(
                              icon: Icons.schedule_rounded,
                              title: 'Business Details',
                              child: _buildBusinessDetails(c),
                            ),
                            SizedBox(height: _kCardSpacing),
                            _buildCard(
                              icon: Icons.chat_bubble_outline_rounded,
                              title: 'Social Media & Messaging',
                              child: _buildSocial(c),
                            ),
                            SizedBox(height: _kCardSpacing),
                            _buildAccountSettingsBtn(c),
                            SizedBox(height: _kCardSpacing),
                            _buildLogOutBtn(c),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, BusinessProfileController c, double topPad) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(_kHeaderPaddingH, _kHeaderPaddingTop + topPad, _kHeaderPaddingH, _kHeaderPaddingBottom),
      decoration: BoxDecoration(
        gradient: AppGradients.businessDashboardHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_kHeaderRadius),
          bottomRight: Radius.circular(_kHeaderRadius),
        ),
      ),
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
                      onTap: c.onBack,
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
                  Text('Business Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: c.onOpenEdit,
                      borderRadius: BorderRadius.circular(_kEditBtnSize / 2),
                      child: Container(
                        width: _kEditBtnSize,
                        height: _kEditBtnSize,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.edit_rounded, size: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Container(
                width: _kProfileSize,
                height: _kProfileSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_kProfileRadius),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: AppShadows.businessDashboardBackBtn,
                ),
                clipBehavior: Clip.antiAlias,
                child: Obx(() {
                  final url = c.profilePhotoUrl.value;
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(Icons.person_rounded, size: 40, color: AppColors.businessDashboardBackIcon),
                  );
                }),
              ),
              SizedBox(height: 16),
              Text(
                c.businessNameController.text.isEmpty ? 'Your Business' : c.businessNameController.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                c.contactPersonController.text.isEmpty ? 'Username' : c.contactPersonController.text,
                style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.8)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0x33FBBF24),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: Color(0xFFFDE047)),
                    SizedBox(width: 6),
                    Text('Premium Partner', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFFFEF3C7))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required IconData icon, required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.businessDashboardCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.businessDashboardCard,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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

  Widget _buildBusinessInfo(BusinessProfileController c) {
    return Obx(() {
      final category = c.selectedCategory.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        _buildLabelValue('Business Name', c.businessNameController.text.isEmpty ? '—' : c.businessNameController.text),
        SizedBox(height: 12),
        _buildLabelValue('Category', BusinessProfileController.categoryLabel(category)),
        SizedBox(height: 12),
        _buildLabelValue('Contact Person', c.contactPersonController.text.isEmpty ? '—' : c.contactPersonController.text),
        SizedBox(height: 12),
        _buildLabelValue('Description', c.descriptionController.text.isEmpty ? 'No description provided' : c.descriptionController.text),
      ],
    );
    });
  }

  Widget _buildContactInfo(BusinessProfileController c) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildContactRow(Icons.mail_outline_rounded, Color(0xFFFAF5FF), 'Email', c.emailController.text.isEmpty ? 'Not provided' : c.emailController.text),
        SizedBox(height: 12),
        _buildContactRow(Icons.phone_outlined, Color(0xFFEEF2FF), 'Phone', c.telController.text.isEmpty ? 'Not provided' : c.telController.text),
        SizedBox(height: 12),
        _buildContactRow(Icons.language_rounded, Color(0xFFECFDF5), 'Website', c.websiteController.text.isEmpty ? 'Not provided' : c.websiteController.text),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, Color bg, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: _kRowIconSize,
          height: _kRowIconSize,
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(_kRowIconRadius)),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: AppColors.businessInfoBadgeStart),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: AppColors.businessDashboardSectionSubtitle)),
              SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 14, color: AppColors.businessDashboardMetricValue)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocation(BusinessProfileController c) {
    return Obx(() {
      final _ = c.selectedCountry.value;
      final addr = c.mainAddressFormatted;
      return _buildLabelValue('Main Address', addr.isEmpty ? '—' : addr);
    });
  }

  Widget _buildBusinessDetails(BusinessProfileController c) {
    return Obx(() {
      final priceVal = c.priceRangeValue.value;
      final types = c.deliveryTypes.toList();
      final hours = c.hoursController.text.isEmpty ? 'Not specified' : c.hoursController.text;
      final priceLabel = BusinessProfileController.priceRangeLabel(priceVal);
      final delivery = types.isEmpty ? 'Not specified' : types.map((t) {
        if (t == 'delivery') return 'Delivery';
        if (t == 'on-site') return 'On-site';
        if (t == 'digital') return 'Digital';
        return t;
      }).join(', ');
      return Column(
        mainAxisSize: MainAxisSize.min,
      children: [
        _buildContactRow(Icons.schedule_rounded, Color(0xFFFEF3C7), 'Operating Hours', hours),
        SizedBox(height: 12),
        _buildContactRow(Icons.attach_money_rounded, Color(0xFFFCE7F3), 'Price Range', priceLabel),
        SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: _kRowIconSize,
              height: _kRowIconSize,
              decoration: BoxDecoration(color: Color(0xFFDBEAFE), borderRadius: BorderRadius.circular(_kRowIconRadius)),
              alignment: Alignment.center,
              child: Icon(Icons.local_shipping_outlined, size: 18, color: Color(0xFF2563EB)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Type', style: TextStyle(fontSize: 12, color: AppColors.businessDashboardSectionSubtitle)),
                  SizedBox(height: 4),
                  Text(delivery, style: TextStyle(fontSize: 14, color: AppColors.businessDashboardMetricValue)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
    });
  }

  Widget _buildSocial(BusinessProfileController c) {
    final hasAny = c.whatsappController.text.isNotEmpty || c.telegramController.text.isNotEmpty ||
        c.instagramController.text.isNotEmpty || c.facebookController.text.isNotEmpty ||
        c.redditController.text.isNotEmpty || c.snapchatController.text.isNotEmpty || c.tiktokController.text.isNotEmpty;
    return Center(
      child: Text(
        hasAny ? 'Connected' : 'No social media connected',
        style: TextStyle(fontSize: 14, color: AppColors.businessDashboardSectionSubtitle, fontStyle: FontStyle.italic),
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: AppColors.businessDashboardSectionSubtitle)),
        SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 14, color: AppColors.businessDashboardMetricValue)),
      ],
    );
  }

  Widget _buildAccountSettingsBtn(BusinessProfileController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onOpenAccountSettings,
        borderRadius: BorderRadius.circular(_kBottomBtnRadius),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: _kBottomBtnPaddingV * 1.5),
          decoration: BoxDecoration(
            color: AppColors.businessDashboardCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: AppShadows.businessDashboardCard,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings_rounded, size: 18, color: AppColors.businessDashboardMetricValue),
              SizedBox(width: 10),
              Text('Account Settings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.businessDashboardMetricValue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogOutBtn(BusinessProfileController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onLogout,
        borderRadius: BorderRadius.circular(_kBottomBtnRadius),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: _kBottomBtnPaddingV * 1.5),
          decoration: BoxDecoration(
            color: AppColors.businessDashboardCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: AppShadows.businessDashboardCard,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, size: 18, color: Color(0xFFE11D48)),
              SizedBox(width: 10),
              Text('Log Out', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFFE11D48))),
            ],
          ),
        ),
      ),
    );
  }
}
