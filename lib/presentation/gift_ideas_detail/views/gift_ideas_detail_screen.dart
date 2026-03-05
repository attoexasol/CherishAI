// lib/presentation/gift_ideas_detail/views/gift_ideas_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/gift_ideas_detail_controller.dart';
import '../models/gift_ideas_detail_models.dart';

const double _kBackBtnSize = 40;
const double _kBackIconSize = 20;
const double _kPaddingH = 24;
const double _kCardRadius = 24;
const double _kEventIconSize = 64;
const double _kEventIconRadius = 16;
const double _kGiftIconSize = 56;
const double _kGiftIconRadius = 14;
const double _kDropdownHeight = 48;
const double _kDropdownRadius = 12;
const double _kFindNearYouHeight = 48;
const double _kFindNearYouRadius = 14;
const double _kSecondaryBtnRadius = 12;
const double _kMaxWidth = 480;
const double _kBottomNavPadding = 88;
const double _kBreakpointNarrow = 360;

class GiftIdeasDetailScreen extends StatefulWidget {
  const GiftIdeasDetailScreen({super.key});

  @override
  State<GiftIdeasDetailScreen> createState() => _GiftIdeasDetailScreenState();
}

class _GiftIdeasDetailScreenState extends State<GiftIdeasDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final c = Get.find<GiftIdeasDetailController>();
      c.applyArguments(Get.arguments as Map<String, dynamic>?);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GiftIdeasDetailController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isNarrow = screenWidth < _kBreakpointNarrow;
    final paddingH = isNarrow ? 16.0 : _kPaddingH;
    final bottomPaddingTotal = _kBottomNavPadding + bottomPadding;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.giftIdeasDetailPageBgStart,
              AppColors.giftIdeasDetailPageBgMid,
              AppColors.giftIdeasDetailPageBgEnd,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAppBar(context, c, paddingH),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: paddingH,
                    right: paddingH,
                    bottom: bottomPaddingTotal,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                      child: Obx(() {
                        if (c.isLoading.value) {
                          return const Padding(
                            padding: EdgeInsets.all(48),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final ev = c.event.value;
                        if (ev == null) {
                          return const SizedBox.shrink();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildEventCard(context, ev, isNarrow),
                            const SizedBox(height: 20),
                            _buildFilterCard(context, c, isNarrow),
                            const SizedBox(height: 24),
                            Text(
                              'Perfect Gift Ideas',
                              style: AppTextStyles.giftIdeasDetailSectionTitle,
                            ),
                            const SizedBox(height: 12),
                            ...c.gifts.map((g) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: _buildGiftCard(context, c, g, isNarrow),
                                )),
                            _buildTipCard(context, isNarrow),
                            const SizedBox(height: 24),
                            _buildRegenerateButton(context, c),
                            const SizedBox(height: 12),
                            _buildViewHistoryButton(context, c, isNarrow),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, GiftIdeasDetailController c, [double paddingH = _kPaddingH]) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingH, 16, paddingH, 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onBack,
                borderRadius: BorderRadius.circular(_kBackBtnSize / 2),
                child: Container(
                  width: _kBackBtnSize,
                  height: _kBackBtnSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.giftIdeasBackBtn,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.giftIdeasBackBtn,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: _kBackIconSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Gift Ideas',
            style: AppTextStyles.giftIdeasDetailAppBarTitle,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, GiftIdeasDetailEvent ev, [bool isNarrow = false]) {
    IconData iconData = Icons.cake;
    switch (ev.iconType) {
      case 'flower':
        iconData = Icons.local_florist;
        break;
      case 'handshake':
        iconData = Icons.waving_hand;
        break;
      case 'gift':
        iconData = Icons.card_giftcard;
        break;
      default:
        break;
    }
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        children: [
          Container(
            width: _kEventIconSize,
            height: _kEventIconSize,
            decoration: BoxDecoration(
              gradient: AppGradients.giftIdeasDetailEventIcon,
              borderRadius: BorderRadius.circular(_kEventIconRadius),
            ),
            child: Icon(iconData, size: 28, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            ev.title,
            style: AppTextStyles.giftIdeasDetailEventTitle.copyWith(
              fontSize: isNarrow ? 18 : 20,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.giftIdeasDetailCountdown,
              children: [
                const TextSpan(text: 'Coming up in '),
                TextSpan(
                  text: '${ev.daysUntil} days',
                  style: AppTextStyles.giftIdeasDetailCountdownDays,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Carefully selected by Cherish AI, with your loved one's interests in mind.",
            style: AppTextStyles.giftIdeasDetailEventDesc,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterCard(BuildContext context, GiftIdeasDetailController c, [bool isNarrow = false]) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 14 : 20),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.giftIdeasDetailEventTitleGradientMid,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.attach_money, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                'Price Range',
                style: AppTextStyles.giftIdeasDetailFilterLabel.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: _kDropdownHeight,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_kDropdownRadius),
              border: Border.all(color: AppColors.giftIdeasDetailFilterBorder),
            ),
            child: Obx(
              () {
                final dropdownStyle = TextStyle(
                  fontSize: isNarrow ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.giftIdeasDetailFilterLabel,
                );
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: c.selectedPriceRange.value,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.giftIdeasDetailFilterLabel),
                    style: dropdownStyle,
                    items: GiftIdeasDetailController.priceRanges
                        .map((s) => DropdownMenuItem<String>(
                              value: s,
                              child: Text(
                                s,
                                style: dropdownStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) c.onSelectPriceRange(v);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.giftIdeasDetailEventTitleGradientMid,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.card_giftcard, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                'Category',
                style: AppTextStyles.giftIdeasDetailFilterLabel.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: _kDropdownHeight,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_kDropdownRadius),
              border: Border.all(color: AppColors.giftIdeasDetailFilterBorder),
            ),
            child: Obx(
              () {
                final dropdownStyle = TextStyle(
                  fontSize: isNarrow ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.giftIdeasDetailFilterLabel,
                );
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: c.selectedCategory.value,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.giftIdeasDetailFilterLabel),
                    style: dropdownStyle,
                    items: GiftIdeasDetailController.categories
                        .map((s) => DropdownMenuItem<String>(
                              value: s,
                              child: Text(
                                s,
                                style: dropdownStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) c.onSelectCategory(v);
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Obx(
              () => RichText(
                text: TextSpan(
                  style: AppTextStyles.giftIdeasDetailShowing,
                  children: [
                    const TextSpan(text: 'Showing '),
                    TextSpan(
                      text: '${c.gifts.length} gifts',
                      style: AppTextStyles.giftIdeasDetailShowingCount,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGiftCard(BuildContext context, GiftIdeasDetailController c, GiftDetailItem g, [bool isNarrow = false]) {
    IconData iconData = Icons.camera_alt;
    switch (g.iconType) {
      case 'coffee':
        iconData = Icons.coffee;
        break;
      case 'spa':
        iconData = Icons.spa;
        break;
      case 'flower':
        iconData = Icons.local_florist;
        break;
      default:
        break;
    }
    final saved = c.isSaved(g.id);
    final iconSize = isNarrow ? 44.0 : _kGiftIconSize;
    final cardPadding = isNarrow ? 14.0 : 20.0;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: isNarrow ? 14 : 18, horizontal: cardPadding),
            decoration: BoxDecoration(
              color: AppColors.giftIdeasDetailWhyPerfectBgStart.withValues(alpha: 0.6),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(_kCardRadius)),
            ),
            child: Column(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.giftIdeasDetailEventIcon,
                    borderRadius: BorderRadius.circular(_kGiftIconRadius),
                  ),
                  child: Icon(iconData, size: iconSize * 0.46, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isNarrow ? 8 : 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.giftIdeasDetailCardBg,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppColors.giftIdeasDetailSecondaryBtnBorder),
                  ),
                  child: Text(
                    g.priceRange,
                    style: AppTextStyles.giftIdeasDetailPricePill.copyWith(fontSize: isNarrow ? 11 : 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          Text(
            g.title,
            style: AppTextStyles.giftIdeasDetailGiftTitle.copyWith(fontSize: isNarrow ? 15 : 17),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            g.description,
            style: AppTextStyles.giftIdeasDetailGiftDesc.copyWith(fontSize: isNarrow ? 12 : 14),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isNarrow ? 10 : 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.giftIdeasDetailWhyPerfectBgStart,
                  AppColors.giftIdeasDetailWhyPerfectBgEnd,
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, size: isNarrow ? 14 : 16, color: AppColors.giftIdeasDetailTipIcon),
                    const SizedBox(width: 6),
                    Text('WHY IT\'S PERFECT', style: AppTextStyles.giftIdeasDetailWhyPerfectTitle.copyWith(fontSize: isNarrow ? 11 : 12)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  g.whyPerfect,
                  style: AppTextStyles.giftIdeasDetailWhyPerfectBody.copyWith(fontSize: isNarrow ? 12 : 13),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => c.onFindNearYou(g.id),
              borderRadius: BorderRadius.circular(_kFindNearYouRadius),
              child: Container(
                width: double.infinity,
                height: isNarrow ? 44 : _kFindNearYouHeight,
                decoration: BoxDecoration(
                  gradient: AppGradients.giftIdeasDetailFindNearYou,
                  borderRadius: BorderRadius.circular(_kFindNearYouRadius),
                  boxShadow: AppShadows.giftIdeasViewAllBtn,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: isNarrow ? 18 : 20, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('Find Near You', style: AppTextStyles.giftIdeasDetailFindNearYouBtn.copyWith(fontSize: isNarrow ? 13 : 14)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSecondaryAction(
                icon: saved ? Icons.favorite : Icons.favorite_border,
                label: 'Save',
                isSaved: saved,
                onTap: () => c.onSaveGift(g.id),
                isNarrow: isNarrow,
              ),
              _buildSecondaryAction(
                icon: Icons.share,
                label: 'Share',
                isSaved: false,
                onTap: () => c.onShareGift(g.id),
                isNarrow: isNarrow,
              ),
              _buildSecondaryAction(
                icon: Icons.visibility_outlined,
                label: 'Visit',
                isSaved: false,
                onTap: () => c.onVisitGift(g.id),
                isNarrow: isNarrow,
              ),
            ],
          ),
        ],
      ),
    ),
        ],
      ),
    );
  }

  Widget _buildSecondaryAction({
    required IconData icon,
    required String label,
    required bool isSaved,
    required VoidCallback onTap,
    bool isNarrow = false,
  }) {
    final bg = isSaved ? AppColors.giftIdeasDetailSavedBtnBg : AppColors.giftIdeasDetailSecondaryBtnBg;
    final border = isSaved ? AppColors.giftIdeasDetailSavedBtnBorder : AppColors.giftIdeasDetailSecondaryBtnBorder;
    final textStyle = isSaved
        ? AppTextStyles.giftIdeasDetailSecondaryBtn.copyWith(color: AppColors.giftIdeasDetailSavedBtnText)
        : AppTextStyles.giftIdeasDetailSecondaryBtn;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kSecondaryBtnRadius),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: isNarrow ? 10 : 16, vertical: isNarrow ? 8 : 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(_kSecondaryBtnRadius),
            border: Border.all(color: border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: isNarrow ? 18 : 20, color: textStyle.color ?? AppColors.giftIdeasDetailSecondaryBtnText),
              const SizedBox(height: 4),
              Text(label, style: textStyle.copyWith(fontSize: isNarrow ? 11 : 13), maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, [bool isNarrow = false]) {
    return Container(
      padding: EdgeInsets.all(isNarrow ? 12 : 16),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasDetailCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.giftIdeasDetailCardBorder),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, size: isNarrow ? 20 : 24, color: AppColors.giftIdeasDetailTipIcon),
          SizedBox(height: isNarrow ? 8 : 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.giftIdeasDetailTipText.copyWith(fontSize: isNarrow ? 12 : 14),
              children: [
                const TextSpan(text: 'Tip: Click '),
                TextSpan(
                  text: '"Find Near You"',
                  style: AppTextStyles.giftIdeasDetailTipBold,
                ),
                const TextSpan(text: ' to see local businesses offering each gift.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegenerateButton(BuildContext context, GiftIdeasDetailController c) {
    return Obx(() {
      final disabled = c.regenerationsLeft.value <= 0 || c.isRegenerating.value;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : c.onRegenerateAll,
          borderRadius: BorderRadius.circular(_kFindNearYouRadius),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: disabled ? null : AppGradients.giftIdeasDetailRegenerateAll,
              color: disabled ? AppColors.giftIdeasDetailRegenerateDisabledBg : null,
              borderRadius: BorderRadius.circular(_kFindNearYouRadius),
              boxShadow: disabled ? null : AppShadows.giftIdeasViewAllBtn,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 22,
                      color: disabled ? AppColors.giftIdeasDetailRegenerateDisabledText : Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Regenerate All',
                      style: AppTextStyles.giftIdeasDetailRegenerateTitle.copyWith(
                        color: disabled ? AppColors.giftIdeasDetailRegenerateDisabledText : Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${c.regenerationsLeft.value} regenerations left this month',
                  style: AppTextStyles.giftIdeasDetailRegenerateCaption.copyWith(
                    color: disabled ? AppColors.giftIdeasDetailRegenerateDisabledText : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildViewHistoryButton(BuildContext context, GiftIdeasDetailController c, [bool isNarrow = false]) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onViewGiftHistory,
        borderRadius: BorderRadius.circular(_kFindNearYouRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_kFindNearYouRadius),
            border: Border.all(color: AppColors.giftIdeasDetailViewHistoryBorder),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 22, color: AppColors.giftIdeasDetailTitle),
                  const SizedBox(width: 8),
                  Text(
                    'View Gift History',
                    style: AppTextStyles.giftIdeasDetailViewHistoryTitle,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'See all past suggestions',
                style: AppTextStyles.giftIdeasDetailViewHistoryCaption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
