// lib/presentation/profile/views/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/profile_controller.dart';

const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingTop = 48;
const double _kHeaderPaddingBottom = 80;
const double _kEditBtnSize = 40;
const double _kEditBtnIconSize = 20;
const double _kEditBtnBorderWidth = 1.5;
const double _kAvatarSize = 96;
const double _kAvatarBorderWidth = 4;
const double _kStatusDotSize = 24;
const double _kContentPaddingH = 24;
const double _kCardRadius = 20;
const double _kCardPadding = 24;
const double _kStatCardGap = 12;
const double _kStatCardRowGap = 12;
const double _kStatIconSize = 16;
const double _kStatDecoCircleSize = 64;
const double _kStatDecoCircleOffset = 32;
const double _kInfoRowIconSize = 20;
const double _kMembershipDotSize = 8;
const double _kInputHeight = 48;
const double _kInputRadius = 12;
const double _kButtonHeight = 52;
const double _kButtonRadius = 16;
const double _kSectionGap = 20;
const double _kInfoRowGap = 14;
const double _kBottomNavRadius = 28;
const double _kBottomNavPaddingH = 16;
const double _kBottomNavPaddingV = 12;
const double _kBottomNavHeight = 72;
const double _kBottomNavHideLabelWidth = 280;
const double _kMaxContentWidth = 480;
/// Overlap of content over header gradient (React -mt-12). Cards may overlap gradient only.
const double _kContentOverlapHeader = 32;
const double _kScrollBottomPadding = 24;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProfileController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.homePageBg,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final showBottomNavLabels = screenWidth >= _kBottomNavHideLabelWidth;
              final paddingH = screenWidth < Breakpoints.sm ? 16.0 : _kContentPaddingH;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: _kBottomNavHeight + _kScrollBottomPadding + bottomPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(context, c),
                          Transform.translate(
                            offset: Offset(0, -_kContentOverlapHeader),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: paddingH),
                              child: Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: _kMaxContentWidth.clamp(0, screenWidth - paddingH * 2),
                                  ),
                                  child: Obx(() => Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      _buildStatsCardsSection(context, c),
                                      SizedBox(height: _kSectionGap + _kContentOverlapHeader),
                                      _buildPersonalInfo(context, c),
                                      const SizedBox(height: _kSectionGap),
                                      if (c.isEditMode.value) ...[
                                        _buildSaveButton(context, c),
                                        const SizedBox(height: 16),
                                      ],
                                      _buildManageSubscriptionButton(context, c),
                                      const SizedBox(height: 12),
                                      _buildLogoutButton(context, c),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNav(context, c, showBottomNavLabels),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCardsSection(BuildContext context, ProfileController c) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final gap = _kStatCardGap;
        final cardWidth = availableWidth > 0 ? (availableWidth - gap) / 2 : 0.0;
        if (cardWidth <= 0) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildStatCard(
                    context,
                    cardWidth: cardWidth,
                    icon: Icons.visibility_outlined,
                    label: 'Loved Ones',
                    count: c.lovedOnesCount.value.toString(),
                    delta: c.lovedOnesDelta.value,
                    decoColor: AppColors.profileStatDecoRose,
                    iconColor: AppColors.profileStatIconRose,
                  ),
                ),
                SizedBox(width: gap),
                SizedBox(
                  width: cardWidth,
                  child: _buildStatCard(
                    context,
                    cardWidth: cardWidth,
                    icon: Icons.favorite_border,
                    label: 'Moments',
                    count: c.momentsCount.value.toString(),
                    delta: c.momentsDelta.value,
                    decoColor: AppColors.profileStatDecoPink,
                    iconColor: AppColors.profileStatIconPink,
                  ),
                ),
              ],
            ),
            SizedBox(height: _kStatCardRowGap),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: cardWidth,
                child: _buildStatCard(
                  context,
                  cardWidth: cardWidth,
                  icon: Icons.card_giftcard_outlined,
                  label: 'Gifts Sent',
                  count: c.giftsSentCount.value.toString(),
                  delta: c.giftsSentDelta.value,
                  decoColor: AppColors.profileStatDecoPurple,
                  iconColor: AppColors.profileStatIconPurple,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, ProfileController c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        _kHeaderPaddingH,
        _kHeaderPaddingTop,
        _kHeaderPaddingH,
        _kHeaderPaddingBottom,
      ),
      decoration: const BoxDecoration(
        gradient: AppGradients.profileHeader,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Profile', style: AppTextStyles.profileTitle),
              Obx(() => _buildEditButton(c)),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                _buildAvatar(c),
                const SizedBox(height: 8),
                Obx(() => Text(c.fullName.value, style: AppTextStyles.profileUsername)),
                const SizedBox(height: 4),
                Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: _kMembershipDotSize,
                      height: _kMembershipDotSize,
                      decoration: const BoxDecoration(
                        color: AppColors.profileMembershipDot,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(c.membershipLabel, style: AppTextStyles.profileMembership),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton(ProfileController c) {
    final isEdit = c.isEditMode.value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.toggleEdit,
        borderRadius: BorderRadius.circular(_kEditBtnSize / 2),
        child: Container(
          width: _kEditBtnSize,
          height: _kEditBtnSize,
          decoration: BoxDecoration(
            color: isEdit ? null : AppColors.profileEditBtnBg,
            gradient: isEdit ? AppGradients.profileEditBtnActive : null,
            shape: BoxShape.circle,
            border: isEdit ? null : Border.all(color: AppColors.profileEditBtnBorder, width: _kEditBtnBorderWidth),
            boxShadow: AppShadows.profileEditButton,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.edit_outlined,
            size: _kEditBtnIconSize,
            color: isEdit ? Colors.white : AppColors.profileEditBtnIcon,
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(ProfileController c) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: _kAvatarSize,
          height: _kAvatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.profileAvatarBorder, width: _kAvatarBorderWidth),
            boxShadow: AppShadows.profileAvatar,
            color: AppColors.profileCardBgGradientStart,
          ),
          child: ClipOval(
            child: c.fullName.value.isNotEmpty
                ? Icon(Icons.person, size: _kAvatarSize * 0.6, color: AppColors.profileStatIconPink)
                : const SizedBox.shrink(),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: _kStatusDotSize,
            height: _kStatusDotSize,
            decoration: BoxDecoration(
              color: AppColors.profileStatusDot,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.profileAvatarBorder, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required double cardWidth,
    required IconData icon,
    required String label,
    required String count,
    required String delta,
    required Color decoColor,
    Color? iconColor,
  }) {
    final effectiveIconColor = iconColor ?? AppColors.profileStatIconPink;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          width: cardWidth,
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.profileCardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppShadows.profileCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(icon, size: _kStatIconSize, color: effectiveIconColor),
                  const SizedBox(width: 8),
                  Text(label, style: AppTextStyles.profileStatLabel),
                ],
              ),
              const SizedBox(height: 8),
              Text(count, style: AppTextStyles.profileStatCount),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.trending_up, size: 12, color: AppColors.profileStatDelta),
                  const SizedBox(width: 4),
                  Text(delta, style: AppTextStyles.profileStatDelta),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -_kStatDecoCircleOffset,
          right: -_kStatDecoCircleOffset,
          child: IgnorePointer(
            child: Container(
              width: _kStatDecoCircleSize,
              height: _kStatDecoCircleSize,
              decoration: BoxDecoration(
                color: decoColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfo(BuildContext context, ProfileController c) {
    return Obx(() {
      if (c.isEditMode.value) {
        return _buildPersonalInfoForm(context, c);
      }
      return _buildPersonalInfoView(context, c);
    });
  }

  Widget _buildPersonalInfoView(BuildContext context, ProfileController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.profileCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.profileCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, size: _kInfoRowIconSize, color: AppColors.profileStatIconPink),
              const SizedBox(width: 8),
              Flexible(
                child: Text('Personal Information', style: AppTextStyles.profileInfoSectionTitle, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.email_outlined, 'Email Address', c.email.value),
          SizedBox(height: _kInfoRowGap),
          _buildInfoRow(Icons.phone_outlined, 'Phone Number', c.phone.value.isEmpty ? '—' : c.phone.value),
          SizedBox(height: _kInfoRowGap),
          _buildInfoRow(Icons.location_on_outlined, 'Location', c.locationDisplay.isEmpty ? '—' : c.locationDisplay),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: _kInfoRowIconSize, color: AppColors.profileStatIconPink),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.profileInfoRowLabel),
              const SizedBox(height: 2),
              Text(value, style: AppTextStyles.profileInfoRowValue),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoForm(BuildContext context, ProfileController c) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.profileCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.profileCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, size: _kInfoRowIconSize, color: AppColors.profileStatIconPink),
              const SizedBox(width: 8),
              Flexible(
                child: Text('Personal Information', style: AppTextStyles.profileInfoSectionTitle, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text('Full Name', style: AppTextStyles.profileFormLabel),
          const SizedBox(height: 6),
          _buildFormField(controller: c.nameController, hint: 'Full Name'),
          const SizedBox(height: 16),
          Text('Email', style: AppTextStyles.profileFormLabel),
          const SizedBox(height: 6),
          _buildFormField(controller: c.emailController, hint: 'Email'),
          const SizedBox(height: 16),
          Text('Phone', style: AppTextStyles.profileFormLabel),
          const SizedBox(height: 6),
          _buildFormField(controller: c.phoneController, hint: 'Phone'),
          const SizedBox(height: 16),
          Text('Country', style: AppTextStyles.profileFormLabel),
          const SizedBox(height: 6),
          _buildCountryDropdown(c),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City', style: AppTextStyles.profileFormLabel),
                    const SizedBox(height: 6),
                    _buildFormField(controller: c.cityController, hint: 'City'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Postal Code', style: AppTextStyles.profileFormLabel),
                    const SizedBox(height: 6),
                    _buildFormField(controller: c.postalCodeController, hint: 'Postal Code'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('State / Region (Optional)', style: AppTextStyles.profileFormLabel),
          const SizedBox(height: 6),
          _buildFormField(
            controller: c.stateRegionController,
            hint: 'State, province, or region',
          ),
          const SizedBox(height: 16),
          Text('Street Address (Optional)', style: AppTextStyles.profileFormLabel),
          const SizedBox(height: 6),
          _buildFormField(
            controller: c.streetAddressController,
            hint: '123 Main Street, Apt 4B',
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({required TextEditingController controller, required String hint}) {
    return Container(
      height: _kInputHeight,
      decoration: BoxDecoration(
        color: AppColors.profileInputBg,
        borderRadius: BorderRadius.circular(_kInputRadius),
        border: Border.all(color: AppColors.profileInputBorder),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        style: AppTextStyles.profileFormInput,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.profileFormPlaceholder,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildCountryDropdown(ProfileController c) {
    return Obx(() {
      const baseCountries = ['Czech Republic', 'United States', 'United Kingdom', 'Germany', 'France'];
      final value = c.selectedCountry.value;
      final list = value.isNotEmpty && !baseCountries.contains(value)
          ? [value, ...baseCountries]
          : baseCountries;
      return Container(
        height: _kInputHeight,
        decoration: BoxDecoration(
          color: AppColors.profileInputBg,
          borderRadius: BorderRadius.circular(_kInputRadius),
          border: Border.all(color: AppColors.profileInputBorder),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value.isEmpty ? baseCountries.first : value,
            isExpanded: true,
            style: AppTextStyles.profileFormInput,
            items: list.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (v) {
              if (v != null) c.selectedCountry.value = v;
            },
          ),
        ),
      );
    });
  }

  Widget _buildSaveButton(BuildContext context, ProfileController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onSaveChanges,
        borderRadius: BorderRadius.circular(_kButtonRadius),
        child: Container(
          height: _kButtonHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppGradients.profileSaveBtn,
            borderRadius: BorderRadius.circular(_kButtonRadius),
            boxShadow: AppShadows.profileSaveBtn,
          ),
          child: Text('Save Changes', style: AppTextStyles.profileSaveBtn),
        ),
      ),
    );
  }

  Widget _buildManageSubscriptionButton(BuildContext context, ProfileController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onManageSubscription,
        borderRadius: BorderRadius.circular(_kButtonRadius),
        child: Container(
          height: _kButtonHeight,
          decoration: BoxDecoration(
            gradient: AppGradients.profileManageSubBtn,
            borderRadius: BorderRadius.circular(_kButtonRadius),
            border: Border.all(color: AppColors.profileManageSubBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.credit_card_outlined, size: 20, color: AppColors.profileManageSubText),
              const SizedBox(width: 8),
              Flexible(
                child: Text('Manage Subscription', style: AppTextStyles.profileManageSubBtn, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ProfileController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onLogout,
        borderRadius: BorderRadius.circular(_kButtonRadius),
        child: Container(
          height: _kButtonHeight,
          decoration: BoxDecoration(
            color: AppColors.profileLogoutBtnBg,
            borderRadius: BorderRadius.circular(_kButtonRadius),
            border: Border.all(color: AppColors.profileLogoutBorder),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout_rounded, size: 20, color: AppColors.profileLogoutText),
              const SizedBox(width: 8),
              Flexible(
                child: Text('Log Out', style: AppTextStyles.profileLogoutBtn, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    ProfileController c,
    bool showLabels,
  ) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.only(
        left: _kBottomNavPaddingH,
        right: _kBottomNavPaddingH,
        top: _kBottomNavPaddingV,
        bottom: _kBottomNavPaddingV + bottomPadding,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.homeBottomNavBg,
            borderRadius: BorderRadius.circular(_kBottomNavRadius),
            border: Border.all(color: AppColors.homeBottomNavBorder),
            boxShadow: AppShadows.homeBottomNav,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildNavItem(context, c, 'home', Icons.home_rounded, 'Home', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'search', Icons.search, 'Search', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'loved_ones', Icons.favorite_border, 'Loved Ones', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'alerts', Icons.notifications_outlined, 'Alerts', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'profile', Icons.person_outline, 'Profile', isActive: true, showLabel: showLabels),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    ProfileController c,
    String tab,
    IconData icon,
    String label,
    {required bool isActive, bool showLabel = true}
  ) {
    return GestureDetector(
      onTap: () => c.onTapBottomNav(tab),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: showLabel ? 12 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isActive ? AppGradients.homeBottomNavActivePill : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive ? AppShadows.homeBottomNavActivePill : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? AppColors.homeBottomNavActiveIcon : AppColors.homeBottomNavInactiveIcon,
              ),
              if (showLabel) ...[
                const SizedBox(height: 4),
                Text(
                  label,
                  style: isActive ? AppTextStyles.homeBottomNavLabel : AppTextStyles.homeBottomNavLabelInactive,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
