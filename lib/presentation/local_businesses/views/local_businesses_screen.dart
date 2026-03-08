// lib/presentation/local_businesses/views/local_businesses_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/local_businesses_controller.dart';
import '../models/local_business_item.dart';

const double _kPaddingH = 24;
const double _kCardRadius = 20;
const double _kBottomNavPadding = 88;
const double _kBreakpointNarrow = 360;

// Action button colors (Tel=green, Website=blue, Location=pink, Social=purple)
const Color _kTelBg = Color(0xFF22C55E);
const Color _kWebsiteBg = Color(0xFF3B82F6);
const Color _kLocationBg = Color(0xFFE11D48);
const Color _kSocialBg = Color(0xFFA855F7);

class LocalBusinessesScreen extends StatefulWidget {
  const LocalBusinessesScreen({Key? key}) : super(key: key);

  @override
  State<LocalBusinessesScreen> createState() => _LocalBusinessesScreenState();
}

class _LocalBusinessesScreenState extends State<LocalBusinessesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Get.find<LocalBusinessesController>().applyArguments(Get.arguments as Map<String, dynamic>?);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LocalBusinessesController>();
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
                    const SizedBox(height: 16),
                    _buildResultCount(context, c),
                    const SizedBox(height: 20),
                    Obx(() {
                      return Column(
                        children: c.businesses
                            .map((b) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: _buildBusinessCard(context, c, b, isNarrow),
                                ))
                            .toList(),
                      );
                    }),
                    _buildTipCard(context, isNarrow),
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
    LocalBusinessesController c,
    double paddingH,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(paddingH, 16, paddingH, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          'Back to Gift Ideas',
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
                        Icon(Icons.explore, size: 18, color: Colors.white),
                        const SizedBox(width: 6),
                        Text('Discover', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Local Businesses',
            style: AppTextStyles.giftIdeasDetailEventTitle.copyWith(fontSize: 24),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Obx(() {
            final title = c.giftTitle.value;
            return RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: AppColors.giftIdeasDetailFilterLabel, height: 1.3),
                children: [
                  const TextSpan(text: 'Offering '),
                  TextSpan(
                    text: title.isEmpty ? 'Gift' : title,
                    style: TextStyle(
                      color: AppColors.giftIdeasDetailCountdownDays,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResultCount(BuildContext context, LocalBusinessesController c) {
    return Obx(() => Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 15, color: AppColors.giftIdeasDetailTitle, height: 1.3),
              children: [
                TextSpan(text: 'Found ${c.businessCount} '),
                const TextSpan(
                  text: 'trusted businesses',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' near you'),
              ],
            ),
          ),
        ));
  }

  Widget _buildBusinessCard(
    BuildContext context,
    LocalBusinessesController c,
    LocalBusinessItem b,
    bool isNarrow,
  ) {
    final isFav = c.isFavorite(b.id);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(isNarrow ? 12 : 16),
            decoration: BoxDecoration(
              color: AppColors.giftIdeasDetailWhyPerfectBgStart.withAlpha(((0.5 * 255).toInt())),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(_kCardRadius)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: isNarrow ? 56 : 64,
                      height: isNarrow ? 56 : 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: AppShadows.homeCard,
                      ),
                      child: Icon(Icons.spa, size: isNarrow ? 28 : 32, color: AppColors.giftIdeasDetailEventTitleGradientMid),
                    ),
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
                                  style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(
                                    fontSize: isNarrow ? 15 : 17,
                                  ),
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
                            b.type,
                            style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: isNarrow ? 12 : 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${b.rating}',
                                style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(fontSize: 13),
                              ),
                              Flexible(
                                child: Text(
                                  ' (${b.reviewCount})',
                                  style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.location_on, size: 14, color: AppColors.giftIdeasDetailFilterLabel),
                              const SizedBox(width: 2),
                              Flexible(
                                child: Text(
                                  b.distance,
                                  style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: 12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 2,
                            children: List.generate(5, (i) {
                              final filled = i < b.priceLevel;
                              return Text(
                                '\$',
                                style: TextStyle(
                                  fontSize: isNarrow ? 10 : 12,
                                  fontWeight: FontWeight.bold,
                                  color: filled ? const Color(0xFF16A34A) : const Color(0xFF86EFAC),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isNarrow ? 12 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.giftIdeasDetailSecondaryBtnBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.giftIdeasDetailFilterBorder),
                  ),
                  child: Text(
                    'Specialty: ${b.specialty}',
                    style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: isNarrow ? 12 : 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 14),
                Divider(height: 1, color: AppColors.giftIdeasDetailFilterBorder),
                const SizedBox(height: 14),
                _buildInfoBlock(Icons.location_on, 'ADDRESS', b.address, isNarrow),
                const SizedBox(height: 10),
                _buildInfoBlock(Icons.access_time, 'HOURS', b.hours, isNarrow),
                const SizedBox(height: 16),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final btnFontSize = isNarrow ? 11.0 : 12.0;
                    final btnIconSize = isNarrow ? 16.0 : 18.0;
                    return Row(
                      children: [
                        Expanded(
                          child: _buildActionBtn(
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
                          child: _buildActionBtn(
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
                          child: _buildActionBtn(
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
                          child: _buildActionBtn(
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
                Obx(() {
                  if (c.expandedSocialBusinessId.value != b.id) return const SizedBox.shrink();
                  final links = b.socialLinks;
                  if (links == null || links.isEmpty) return const SizedBox.shrink();
                  return _buildConnectWithUsCard(context, c, b, links, isNarrow);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectWithUsCard(
    BuildContext context,
    LocalBusinessesController c,
    LocalBusinessItem b,
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
          if ((b.phoneNumber != null && b.phoneNumber!.isNotEmpty) ||
              (b.websiteUrl != null && b.websiteUrl!.isNotEmpty) ||
              (b.addressLine != null && b.addressLine!.isNotEmpty) ||
              b.address.isNotEmpty) ...[
            const SizedBox(height: 12),
            if (b.phoneNumber != null && b.phoneNumber!.isNotEmpty)
              _buildConnectInfoRow(Icons.phone, 'Phone', b.phoneNumber!, isNarrow),
            if (b.websiteUrl != null && b.websiteUrl!.isNotEmpty)
              _buildConnectInfoRow(Icons.language, 'Website', _domainFromUrl(b.websiteUrl!), isNarrow),
            _buildConnectInfoRow(Icons.location_on, 'Address', b.addressLine ?? b.address, isNarrow),
          ],
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: links.map((link) => _buildSocialChip(context, c, link, isNarrow)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialChip(BuildContext context, LocalBusinessesController c, SocialLink link, bool isNarrow) {
    final color = _colorForSocialPlatform(link.platform);
    return SizedBox(
      width: isNarrow ? 130 : 150,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => c.onTapSocialLink(link),
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
                Icon(_iconForSocialPlatform(link.platform), size: 20, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        link.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.giftIdeasDetailFilterLabel,
                        ),
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

  Color _colorForSocialPlatform(String platform) {
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

  IconData _iconForSocialPlatform(String platform) {
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

  String _domainFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.isNotEmpty ? uri.host : url;
    } catch (_) {
      return url;
    }
  }

  Widget _buildConnectInfoRow(IconData icon, String label, String value, bool isNarrow) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: isNarrow ? 14 : 16, color: AppColors.giftIdeasDetailFilterLabel),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.giftIdeasDetailWhyPerfectTitle.copyWith(fontSize: isNarrow ? 9 : 10),
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: isNarrow ? 11 : 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBlock(IconData icon, String label, String value, bool isNarrow) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: isNarrow ? 16 : 18, color: AppColors.giftIdeasDetailFilterLabel),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.giftIdeasDetailWhyPerfectTitle.copyWith(fontSize: isNarrow ? 10 : 11),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: isNarrow ? 12 : 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    double iconSize = 18,
    double fontSize = 12,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color.withAlpha(((0.15 * 255).toInt())),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withAlpha(((0.5 * 255).toInt()))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: iconSize, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, bool isNarrow) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 14 : 18),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        children: [
          Icon(Icons.lightbulb_outline, size: isNarrow ? 22 : 26, color: Colors.amber),
          SizedBox(height: isNarrow ? 8 : 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.giftIdeasDetailTipText.copyWith(fontSize: isNarrow ? 12 : 14),
              children: [
                const TextSpan(
                  text: '💡 Tip: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: 'Call ahead to check availability and place your order'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
