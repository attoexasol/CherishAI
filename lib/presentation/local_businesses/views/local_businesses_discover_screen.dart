// lib/presentation/local_businesses/views/local_businesses_discover_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../../business_products/views/business_products_screen.dart';
import '../controllers/local_businesses_discover_controller.dart';
import '../models/discover_business_item.dart';
import '../models/local_business_item.dart';

const double _kPaddingH = 24;
const double _kCardRadius = 20;
const double _kBottomNavPadding = 88;
const double _kBreakpointNarrow = 360;

const Color _kTelBg = Color(0xFF22C55E);
const Color _kWebsiteBg = Color(0xFF3B82F6);
const Color _kLocationBg = Color(0xFFE11D48);
const Color _kSocialBg = Color(0xFFA855F7);

class LocalBusinessesDiscoverScreen extends StatelessWidget {
  const LocalBusinessesDiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LocalBusinessesDiscoverController>();
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < _kBreakpointNarrow;
    final paddingH = isNarrow ? 16.0 : _kPaddingH;

    return Scaffold(
      backgroundColor: AppColors.giftIdeasDetailPageBgStart,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, c, paddingH),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: paddingH,
                  right: paddingH,
                  bottom: _kBottomNavPadding + bottomPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    _buildLocationPill(context, c),
                    const SizedBox(height: 16),
                    _buildSearchField(c),
                    const SizedBox(height: 12),
                    _buildCategoryFilter(c, isNarrow),
                    const SizedBox(height: 16),
                    _buildCountLine(c),
                    const SizedBox(height: 16),
                    Obx(() {
                      final list = c.filteredBusinesses;
                      return Column(
                        children: list
                            .map((b) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: _buildBusinessCard(context, c, b, isNarrow),
                                ))
                            .toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    LocalBusinessesDiscoverController c,
    double paddingH,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(paddingH, 16, paddingH, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.giftIdeasDetailWhyPerfectBgStart.withAlpha(((0.6 * 255).toInt())),
            Colors.white,
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: c.onBack,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.giftIdeasDetailCountdownDays),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.giftIdeasDetailCountdownDays,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.store_outlined, size: 22, color: AppColors.giftIdeasDetailFilterLabel),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Local Businesses',
                    style: AppTextStyles.giftIdeasDetailEventTitle.copyWith(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onDiscover,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: AppGradients.giftIdeasViewAllBtn,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppShadows.giftIdeasViewAllBtn,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 18, color: Colors.white),
                    const SizedBox(width: 6),
                    Text('Discover', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPill(BuildContext context, LocalBusinessesDiscoverController c) {
    return Obx(() => Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.giftIdeasDetailFilterBorder),
                boxShadow: AppShadows.giftIdeasCard,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 18, color: AppColors.giftIdeasDetailCountdownDays),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      c.locationPillText.value,
                      style: AppTextStyles.giftIdeasDetailGiftDesc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildSearchField(LocalBusinessesDiscoverController c) {
    return TextField(
      onChanged: c.setSearchQuery,
      decoration: InputDecoration(
        hintText: 'Search businesses...',
        hintStyle: TextStyle(color: AppColors.giftIdeasDetailFilterLabel.withAlpha(((0.7 * 255).toInt())), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.giftIdeasDetailFilterBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.giftIdeasDetailFilterBorder),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: AppTextStyles.giftIdeasDetailGiftDesc,
      maxLines: 1,
    );
  }

  Widget _buildCategoryFilter(LocalBusinessesDiscoverController c, bool isNarrow) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.giftIdeasDetailWhyPerfectBgStart.withAlpha(((0.5 * 255).toInt())),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: c.selectedCategory.value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.giftIdeasDetailCountdownDays),
              items: c.categories.map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTextStyles.giftIdeasDetailGiftDesc))).toList(),
              onChanged: (v) {
                if (v != null) c.setCategory(v);
              },
            ),
          ),
        ));
  }

  Widget _buildCountLine(LocalBusinessesDiscoverController c) {
    return Obx(() => Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 14, color: AppColors.giftIdeasDetailTitle),
              children: [
                const TextSpan(text: 'Found '),
                TextSpan(text: '${c.filteredCount}', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.giftIdeasDetailCountdownDays)),
                const TextSpan(text: ' businesses'),
              ],
            ),
          ),
        ));
  }

  Widget _buildBusinessCard(
    BuildContext context,
    LocalBusinessesDiscoverController c,
    DiscoverBusinessItem b,
    bool isNarrow,
  ) {
    final isFav = c.isFavorite(b.id);
    return Container(
      padding: EdgeInsets.all(isNarrow ? 14 : 18),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _logoPlaceholder(b.logoIcon, isNarrow),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            b.name,
                            style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(fontSize: isNarrow ? 15 : 17),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => c.toggleFavorite(b.id),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            size: 22,
                            color: isFav ? AppColors.giftIdeasDetailCountdownDays : AppColors.giftIdeasDetailFilterLabel,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '📍 ${b.locationLine}',
                      style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.giftIdeasDetailWhyPerfectBgStart.withAlpha(((0.5 * 255).toInt())),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
                      ),
                      child: Text(
                        b.category,
                        style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text('${b.rating}', style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(fontSize: 13)),
                        Text(' (${b.reviewCount})', style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            b.description,
            style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: isNarrow ? 12 : 13),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text('Specialties:', style: AppTextStyles.giftIdeasDetailWhyPerfectTitle.copyWith(fontSize: 12)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: b.specialties.map((s) => _buildSpecialtyChip(s, isNarrow)).toList(),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final btnFontSize = isNarrow ? 10.0 : 11.0;
              final btnIconSize = isNarrow ? 16.0 : 18.0;
              return Row(
                children: [
                  Expanded(
                    child: _actionBtn(
                      icon: Icons.phone,
                      label: 'Tel',
                      color: _kTelBg,
                      onTap: () => c.onTapTel(b),
                      iconSize: btnIconSize,
                      fontSize: btnFontSize,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _actionBtn(
                      icon: Icons.language,
                      label: 'Website',
                      color: _kWebsiteBg,
                      onTap: () => c.onTapWebsite(b),
                      iconSize: btnIconSize,
                      fontSize: btnFontSize,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _actionBtn(
                      icon: Icons.location_on,
                      label: 'Location',
                      color: _kLocationBg,
                      onTap: () => c.onTapLocation(b),
                      iconSize: btnIconSize,
                      fontSize: btnFontSize,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _actionBtn(
                      icon: Icons.chat_bubble_outline,
                      label: 'Social',
                      color: _kSocialBg,
                      onTap: () => c.onTapSocial(b),
                      iconSize: btnIconSize,
                      fontSize: btnFontSize,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.shopping_bag, size: 20, color: Colors.white),
              label: Text('Products'),
              onPressed: () {
                Get.to(BusinessProductsScreen(businessId: b.id));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD97706),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          Obx(() {
            if (c.expandedSocialBusinessId.value != b.id) return const SizedBox.shrink();
            final links = b.socialLinks;
            if (links == null || links.isEmpty) return const SizedBox.shrink();
            return _buildConnectWithUsCard(context, c, links, isNarrow);
          }),
        ],
      ),
    );
  }

  Widget _logoPlaceholder(String iconKey, bool isNarrow) {
    IconData icon = Icons.card_giftcard;
    switch (iconKey) {
      case 'flower':
        icon = Icons.local_florist;
        break;
      case 'camera':
        icon = Icons.camera_alt;
        break;
      case 'cake':
        icon = Icons.cake;
        break;
      case 'jewelry':
        icon = Icons.diamond;
        break;
      case 'stationery':
        icon = Icons.description;
        break;
      default:
        break;
    }
    final size = isNarrow ? 52.0 : 56.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailWhyPerfectBgStart.withAlpha(((0.6 * 255).toInt())),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
      ),
      child: Icon(icon, size: size * 0.5, color: AppColors.giftIdeasDetailEventTitleGradientMid),
    );
  }

  Widget _buildSpecialtyChip(String label, bool isNarrow) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isNarrow ? 8 : 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailSecondaryBtnBg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.giftIdeasDetailFilterBorder),
      ),
      child: Text(
        label,
        style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 11),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    double iconSize = 18,
    double fontSize = 11,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color, color.withAlpha(((0.8 * 255).toInt()))],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: AppShadows.homeCard,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: iconSize, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectWithUsCard(
    BuildContext context,
    LocalBusinessesDiscoverController c,
    List<SocialLink> links,
    bool isNarrow,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(isNarrow ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.chat_bubble_outline, size: 22, color: _kSocialBg),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Connect with us',
                  style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(fontSize: isNarrow ? 15 : 17),
                ),
              ),
              GestureDetector(
                onTap: c.closeSocialExpanded,
                child: Icon(Icons.close, size: 22, color: AppColors.giftIdeasDetailFilterLabel),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: links.map((link) => _buildSocialChip(link, isNarrow)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialChip(SocialLink link, bool isNarrow) {
    final color = _colorForPlatform(link.platform);
    return SizedBox(
      width: isNarrow ? 130 : 150,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: isNarrow ? 10 : 12, vertical: 10),
            decoration: BoxDecoration(
              color: color.withAlpha(((0.12 * 255).toInt())),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withAlpha(((0.4 * 255).toInt()))),
            ),
            child: Row(
              children: [
                Icon(_iconForPlatform(link.platform), size: 20, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        link.label,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.giftIdeasDetailFilterLabel),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        link.value,
                        style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _colorForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return const Color(0xFFE4405F);
      case 'facebook':
        return const Color(0xFF1877F2);
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'telegram':
        return const Color(0xFF0088CC);
      case 'tiktok':
        return const Color(0xFF000000);
      default:
        return _kSocialBg;
    }
  }

  IconData _iconForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'facebook':
        return Icons.facebook;
      case 'whatsapp':
        return Icons.chat;
      case 'telegram':
        return Icons.send;
      case 'tiktok':
        return Icons.music_note;
      default:
        return Icons.link;
    }
  }
}
