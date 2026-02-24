// lib/presentation/events/views/all_upcoming_events_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_upcoming_events_controller.dart';

const double _kPaddingH = 24;
const double _kBackIconSize = 20;
const double _kHeaderCardRadius = 20;
const double _kHeaderIconSize = 44;
const double _kHeaderIconRadius = 12;
const double _kSortSegmentHeight = 40;
const double _kSortSegmentRadius = 999;
const double _kCardRadius = 20;
const double _kCardPadding = 20;
/// Badge overlays top-left; negative top so badge extends slightly above card edge (React).
const double _kBadgeTop = -6;
const double _kBadgeLeft = 12;
const double _kBadgeRadius = 8;
const double _kBadgePaddingH = 10;
const double _kBadgePaddingV = 5;
const double _kEventIconSize = 56;
const double _kEventIconRadius = 14;
const double _kViewGiftBtnHeight = 44;
const double _kViewGiftBtnRadius = 12;
const double _kStayPreparedCardRadius = 16;
const double _kMaxWidth = 480;
const double _kBottomPadding = 100;

class AllUpcomingEventsScreen extends StatelessWidget {
  const AllUpcomingEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllUpcomingEventsController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: AppColors.eventsPageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopBar(context, c),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kPaddingH,
                  right: _kPaddingH,
                  top: 14,
                  bottom: _kBottomPadding + bottomPadding,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                    child: Obx(() {
                      final sortMode = c.sortMode.value;
                      final events = c.events;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeaderCard(context),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text('Sort by:', style: AppTextStyles.eventsSortLabel),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildSortSegmented(context, c, sortMode),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ...events.map((event) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _buildEventCard(context, c, event),
                              )),
                          const SizedBox(height: 24),
                          _buildStayPreparedCard(context),
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
    );
  }

  Widget _buildTopBar(BuildContext context, AllUpcomingEventsController c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_kPaddingH, 12, _kPaddingH, 8),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBackToDashboard,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.eventsBackText),
                    const SizedBox(width: 4),
                    Text('Back to Dashboard', style: AppTextStyles.eventsBackText),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.eventsHeaderCardBg,
        borderRadius: BorderRadius.circular(_kHeaderCardRadius),
        boxShadow: AppShadows.eventsCard,
      ),
      child: Row(
        children: [
          Container(
            width: _kHeaderIconSize,
            height: _kHeaderIconSize,
            decoration: BoxDecoration(
              gradient: AppGradients.giftIdeasStatIcon1,
              borderRadius: BorderRadius.circular(_kHeaderIconRadius),
            ),
            child: Icon(Icons.calendar_today, size: 22, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('All Upcoming Events', style: AppTextStyles.eventsTitle),
                const SizedBox(height: 4),
                Text('6 special occasions to celebrate', style: AppTextStyles.eventsSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortSegmented(
    BuildContext context,
    AllUpcomingEventsController c,
    int sortMode,
  ) {
    return Container(
      height: _kSortSegmentHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_kSortSegmentRadius),
        border: Border.all(color: AppColors.eventsSortUnselectedBorder),
        color: AppColors.eventsSortUnselectedBg,
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => c.onSelectSortMode(sortByDate),
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(999)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: sortMode == sortByDate
                        ? AppGradients.eventsSortSelected
                        : null,
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(998)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'By Date',
                    style: sortMode == sortByDate
                        ? AppTextStyles.eventsSortSelected
                        : AppTextStyles.eventsSortUnselected,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => c.onSelectSortMode(sortByLovedOne),
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(999)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: sortMode == sortByLovedOne
                        ? AppGradients.eventsSortSelected
                        : null,
                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(998)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'By Loved One',
                    style: sortMode == sortByLovedOne
                        ? AppTextStyles.eventsSortSelected
                        : AppTextStyles.eventsSortUnselected,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, AllUpcomingEventsController c, AllUpcomingEventItem event) {
    LinearGradient iconGradient = AppGradients.giftIdeasEventIconBirthday;
    IconData iconData = Icons.cake;
    switch (event.iconType) {
      case 'flower':
        iconGradient = AppGradients.giftIdeasEventIconFlower;
        iconData = Icons.local_florist;
        break;
      case 'handshake':
        iconGradient = AppGradients.giftIdeasEventIconHandshake;
        iconData = Icons.waving_hand;
        break;
      case 'gift':
        iconGradient = AppGradients.giftIdeasEventIconGift;
        iconData = Icons.card_giftcard;
        break;
      default:
        break;
    }
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.eventsCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: AppShadows.eventsCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _kEventIconSize,
                    height: _kEventIconSize,
                    decoration: BoxDecoration(
                      gradient: iconGradient,
                      borderRadius: BorderRadius.circular(_kEventIconRadius),
                    ),
                    child: Icon(iconData, size: 26, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: AppTextStyles.eventsCardTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            event.relationship,
                            style: AppTextStyles.eventsCardRelationship,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(event.date, style: AppTextStyles.eventsCardDate),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.eventsCountdownPill.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(event.countdown, style: AppTextStyles.eventsCountdownPill),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => c.onViewGiftIdeas(event.id),
                  borderRadius: BorderRadius.circular(_kViewGiftBtnRadius),
                  child: Container(
                    height: _kViewGiftBtnHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppGradients.eventsViewGiftBtn,
                      borderRadius: BorderRadius.circular(_kViewGiftBtnRadius),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.card_giftcard, size: 18, color: AppColors.eventsBadgeText),
                        const SizedBox(width: 8),
                        Text('View Gift Ideas', style: AppTextStyles.eventsViewGiftBtn),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (event.isUrgent)
          Positioned(
            top: _kBadgeTop,
            left: _kBadgeLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
              decoration: BoxDecoration(
                color: AppColors.eventsUrgentBadgeBg,
                borderRadius: BorderRadius.circular(_kBadgeRadius),
              ),
              child: Text('URGENT', style: AppTextStyles.eventsBadge),
            ),
          ),
        if (event.isSpecialOccasion && !event.isUrgent)
          Positioned(
            top: _kBadgeTop,
            left: _kBadgeLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
              decoration: BoxDecoration(
                color: AppColors.eventsSpecialBadgeBg,
                borderRadius: BorderRadius.circular(_kBadgeRadius),
              ),
              child: Text('✨ Special Occasion', style: AppTextStyles.eventsBadge),
            ),
          ),
      ],
    );
  }

  Widget _buildStayPreparedCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.eventsStayPreparedCardBg,
        borderRadius: BorderRadius.circular(_kStayPreparedCardRadius),
        boxShadow: AppShadows.eventsCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.auto_awesome, size: 24, color: AppColors.eventsBackText),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Stay prepared: Cherish AI will remind you about upcoming events and help you find the perfect gift for each occasion',
              style: AppTextStyles.eventsStayPrepared,
            ),
          ),
        ],
      ),
    );
  }
}
