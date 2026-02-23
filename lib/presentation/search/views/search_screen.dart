// lib/presentation/search/views/search_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/search_controller.dart' as search_feature;

const double _kHeaderPaddingH = 20;
const double _kHeaderPaddingTop = 48;
const double _kHeaderPaddingBottom = 32;
const double _kTitleSearchGap = 24;
const double _kSearchBarHeight = 48;
const double _kSearchBarRadius = 16;
const double _kSearchBarIconSize = 20;
const double _kSearchBarPaddingLeft = 48;
const double _kSearchBarPaddingRight = 48;
const double _kContentPaddingH = 20;
const double _kContentPaddingTop = 24;
const double _kSectionSpacing = 24;
const double _kSectionTitleMarginBottom = 12;
const double _kQuickAccessGap = 12;
const double _kQuickAccessTileRadius = 16;
const double _kQuickAccessTilePadding = 16;
const double _kQuickAccessIconSize = 24;
const double _kQuickAccessLabelGap = 8;
const double _kTrendingCardRadius = 20;
const double _kTrendingCardPadding = 24;
const double _kTrendingRowGap = 8;
const double _kTrendingBubbleSize = 40;
const double _kTrendingBubbleRadius = 12;
const double _kTrendingArrowSize = 16;
const double _kRecentChipPaddingH = 16;
const double _kRecentChipPaddingV = 8;
const double _kRecentChipGap = 8;
const double _kRecentChipRadius = 999;
const double _kBottomNavHeight = 72;
const double _kBottomNavRadius = 28;
const double _kBottomNavPaddingH = 16;
const double _kBottomNavPaddingV = 12;
const double _kBottomNavHideLabelWidth = 280;
const double _kScrollBottomPadding = 24;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<search_feature.SearchController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.searchPageBgTop,
              AppColors.searchPageBgEnd,
            ],
          ),
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
                      padding: EdgeInsets.only(
                        left: paddingH,
                        right: paddingH,
                        bottom: _kBottomNavHeight + _kScrollBottomPadding + bottomPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(context, c, paddingH),
                          SizedBox(height: _kContentPaddingTop),
                          Obx(() {
                            if (c.isSearching.value) {
                              return _buildLoading(context);
                            }
                            if (c.query.value.trim().isNotEmpty) {
                              return _buildSearchResultsOrEmpty(context, c);
                            }
                            return _buildDefaultContent(context, c);
                          }),
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

  Widget _buildHeader(BuildContext context, search_feature.SearchController c, double paddingH) {
    return Container(
      padding: EdgeInsets.fromLTRB(paddingH, _kHeaderPaddingTop, paddingH, _kHeaderPaddingBottom),
      decoration: const BoxDecoration(
        gradient: AppGradients.searchHeader,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Search', style: AppTextStyles.searchTitle),
          SizedBox(height: _kTitleSearchGap),
          _buildSearchBar(context, c),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, search_feature.SearchController c) {
    return Obx(() {
      final hasQuery = c.query.value.isNotEmpty;
      return Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            height: _kSearchBarHeight,
            decoration: BoxDecoration(
              color: AppColors.searchBarBg,
              borderRadius: BorderRadius.circular(_kSearchBarRadius),
              boxShadow: AppShadows.searchBar,
            ),
            padding: EdgeInsets.only(
              left: _kSearchBarPaddingLeft,
              right: hasQuery ? 48 : 16,
            ),
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: c.queryController,
              onChanged: c.onQueryChanged,
              style: AppTextStyles.searchBarInput,
              decoration: InputDecoration(
                hintText: 'Search loved ones, gifts, events...',
                hintStyle: AppTextStyles.searchBarPlaceholder,
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Positioned(
            left: 16,
            child: Icon(Icons.search, size: _kSearchBarIconSize, color: AppColors.searchBarIcon),
          ),
          if (hasQuery)
            Positioned(
              right: 12,
              child: GestureDetector(
                onTap: c.clearSearch,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.close, size: 16, color: AppColors.searchSectionTitle),
                ),
              ),
            ),
        ],
      );
    });
  }

  Widget _buildLoading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.searchHeaderMid),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultsOrEmpty(BuildContext context, search_feature.SearchController c) {
    return const SizedBox(height: 1);
  }

  Widget _buildDefaultContent(BuildContext context, search_feature.SearchController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuickAccess(context, c),
        SizedBox(height: _kSectionSpacing),
        _buildTrending(context, c),
        SizedBox(height: _kSectionSpacing),
        _buildRecentSearches(context, c),
      ],
    );
  }

  Widget _buildQuickAccess(BuildContext context, search_feature.SearchController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Access', style: AppTextStyles.searchSectionTitle),
        SizedBox(height: _kSectionTitleMarginBottom),
        LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final gap = _kQuickAccessGap;
            final tileWidth = w > 0 ? (w - gap) / 2 : 0.0;
            if (tileWidth <= 0) return const SizedBox.shrink();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildQuickTile(
                        context,
                        c,
                        label: 'Loved Ones',
                        icon: Icons.favorite_border,
                        gradient: AppGradients.searchQuickLovedOnes,
                        type: 'loved_ones',
                      ),
                    ),
                    SizedBox(width: gap),
                    Expanded(
                      child: _buildQuickTile(
                        context,
                        c,
                        label: 'Gift Ideas',
                        icon: Icons.card_giftcard_outlined,
                        gradient: AppGradients.searchQuickGift,
                        type: 'gift_ideas',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: gap),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildQuickTile(
                        context,
                        c,
                        label: 'Events',
                        icon: Icons.calendar_today_outlined,
                        gradient: AppGradients.searchQuickEvents,
                        type: 'events',
                      ),
                    ),
                    SizedBox(width: gap),
                    Expanded(
                      child: _buildQuickTile(
                        context,
                        c,
                        label: 'Old Messages',
                        icon: Icons.message_outlined,
                        gradient: AppGradients.searchQuickMessages,
                        type: 'old_messages',
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickTile(
    BuildContext context,
    search_feature.SearchController c, {
    required String label,
    required IconData icon,
    required LinearGradient gradient,
    required String type,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => c.onTapQuickAccess(type),
        borderRadius: BorderRadius.circular(_kQuickAccessTileRadius),
        child: Container(
          padding: const EdgeInsets.all(_kQuickAccessTilePadding),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(_kQuickAccessTileRadius),
            boxShadow: AppShadows.searchQuickTile,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: _kQuickAccessIconSize, color: AppColors.searchQuickTileIcon),
              SizedBox(height: _kQuickAccessLabelGap),
              Text(
                label,
                style: AppTextStyles.searchQuickTileLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrending(BuildContext context, search_feature.SearchController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.trending_up, size: 16, color: AppColors.searchBarIcon),
            const SizedBox(width: 8),
            Text('Trending', style: AppTextStyles.searchSectionTitle),
          ],
        ),
        SizedBox(height: _kSectionTitleMarginBottom),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: search_feature.SearchController.trendingItems.length,
          separatorBuilder: (_, __) => SizedBox(height: _kTrendingRowGap),
          itemBuilder: (context, index) {
            final item = search_feature.SearchController.trendingItems[index];
            return _buildTrendingCard(context, c, item);
          },
        ),
      ],
    );
  }

  Widget _buildTrendingCard(BuildContext context, search_feature.SearchController c, search_feature.TrendingSearchItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => c.onTapTrending(item.id),
        borderRadius: BorderRadius.circular(_kTrendingCardRadius),
        child: Container(
          padding: const EdgeInsets.all(_kTrendingCardPadding),
          decoration: BoxDecoration(
            color: AppColors.searchRecentChipBg.withOpacity(0.8),
            borderRadius: BorderRadius.circular(_kTrendingCardRadius),
            boxShadow: AppShadows.searchCard,
          ),
          child: Row(
            children: [
              Container(
                width: _kTrendingBubbleSize,
                height: _kTrendingBubbleSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.searchTrendingBubble,
                  borderRadius: BorderRadius.circular(_kTrendingBubbleRadius),
                ),
                alignment: Alignment.center,
                child: Text(item.icon, style: const TextStyle(fontSize: 20)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.query,
                      style: AppTextStyles.searchTrendingTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.category,
                      style: AppTextStyles.searchTrendingSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: _kTrendingArrowSize, color: AppColors.searchTrendingArrow),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context, search_feature.SearchController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 16, color: AppColors.searchBarIcon),
            const SizedBox(width: 8),
            Text('Recent Searches', style: AppTextStyles.searchSectionTitle),
          ],
        ),
        SizedBox(height: _kSectionTitleMarginBottom),
        Obx(() => Wrap(
          spacing: _kRecentChipGap,
          runSpacing: _kRecentChipGap,
          children: c.recentSearches.map((value) => _buildRecentChip(context, c, value)).toList(),
        )),
      ],
    );
  }

  Widget _buildRecentChip(BuildContext context, search_feature.SearchController c, String value) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => c.onTapRecentSearch(value),
        borderRadius: BorderRadius.circular(_kRecentChipRadius),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _kRecentChipPaddingH, vertical: _kRecentChipPaddingV),
          decoration: BoxDecoration(
            color: AppColors.searchRecentChipBg,
            borderRadius: BorderRadius.circular(_kRecentChipRadius),
            border: Border.all(color: AppColors.searchRecentChipBorder),
            boxShadow: AppShadows.searchRecentChip,
          ),
          child: Text(value, style: AppTextStyles.searchRecentChip),
        ),
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    search_feature.SearchController c,
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
                child: _buildNavItem(context, c, 'search', Icons.search, 'Search', isActive: true, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'loved_ones', Icons.favorite_border, 'Loved Ones', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'alerts', Icons.notifications_outlined, 'Alerts', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'profile', Icons.person_outline, 'Profile', isActive: false, showLabel: showLabels),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    search_feature.SearchController c,
    String tab,
    IconData icon,
    String label, {
    required bool isActive,
    bool showLabel = true,
  }) {
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
