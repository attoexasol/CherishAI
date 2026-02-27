// lib/presentation/events/views/all_upcoming_events_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_upcoming_events_controller.dart';
import '../widgets/event_card.dart';
import '../widgets/loved_one_group_card.dart';

/// React: px-6 (24), py-6 (24) header, py-8 (32) content. Back mb-4 (16). Icon row gap-3 (12) mb-3 (12). Sort mb-6 (24) gap-3. Toggle rounded-2xl (16) p-1.5 (6), buttons px-4 py-2 rounded-xl (12). space-y-4 (16) cards. mt-8 (32) bottom card.
const double _kPaddingH = 24;
const double _kHeaderPaddingV = 24;
const double _kContentPaddingTop = 32;
const double _kBackMb = 16;
const double _kHeaderIconRowGap = 12;
const double _kHeaderIconRowMb = 12;
const double _kHeaderIconSize = 56;
const double _kHeaderIconRadius = 16;
const double _kSortMb = 24;
const double _kSortGap = 12;
const double _kToggleRadius = 16;
const double _kTogglePadding = 6;
const double _kToggleBtnPaddingH = 16;
const double _kToggleBtnPaddingV = 8;
const double _kToggleBtnRadius = 12;
const double _kCardsSpacing = 16;
const double _kGroupSpacing = 24;
const double _kBottomCardMt = 32;
const double _kBottomCardPadding = 24;
const double _kBottomCardRadius = 24;
const double _kBackIconSize = 20;
const double _kBottomPadding = 96;

class AllUpcomingEventsScreen extends StatelessWidget {
  const AllUpcomingEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllUpcomingEventsController>();
    final bottomSafe = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      backgroundColor: AppColors.eventsPageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context, c),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: _kPaddingH,
                  right: _kPaddingH,
                  top: _kContentPaddingTop,
                  bottom: _kBottomPadding + bottomSafe,
                ),
                child: Obx(() {
                  final sortBy = c.sortType.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSortToggle(context, c, sortBy),
                      SizedBox(height: _kSortMb),
                      if (sortBy == 'date') ...[
                        ...c.sortedEvents.map((event) => Padding(
                              padding: const EdgeInsets.only(bottom: _kCardsSpacing),
                              child: EventCard(
                                event: event,
                                showLovedOneInTitle: true,
                                onViewGiftIdeas: () => c.onViewGiftIdeas(event.id),
                              ),
                            )),
                      ] else ...[
                        ...c.groupedByLovedOne.entries.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: _kGroupSpacing),
                              child: LovedOneGroupCard(
                                lovedOneName: e.key,
                                avatar: e.value.first.lovedOneAvatar,
                                relationship: e.value.first.relationship,
                                events: e.value,
                                onViewGiftIdeas: c.onViewGiftIdeas,
                              ),
                            )),
                      ],
                      SizedBox(height: _kBottomCardMt),
                      _buildStayPreparedCard(context),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AllUpcomingEventsController c) {
    return Container(
      padding: EdgeInsets.fromLTRB(_kPaddingH, _kHeaderPaddingV, _kPaddingH, _kHeaderPaddingV),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFE4E6), Color(0xFFFCE7F3), Color(0xFFF3E8FF)],
          stops: [0.0, 0.5, 1.0],
        ),
        border: Border(bottom: BorderSide(color: _kBorderRose200, width: 4)),
        boxShadow: AppShadows.eventsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBackToDashboard,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.eventsBackText),
                    const SizedBox(width: 8),
                    Text('Back to Dashboard', style: AppTextStyles.eventsBackText),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: _kBackMb),
          Row(
            children: [
              Container(
                width: _kHeaderIconSize,
                height: _kHeaderIconSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.giftIdeasStatIcon1,
                  borderRadius: BorderRadius.circular(_kHeaderIconRadius),
                  boxShadow: AppShadows.eventsCard,
                ),
                child: Icon(Icons.calendar_today, size: 28, color: Colors.white),
              ),
              SizedBox(width: _kHeaderIconRowGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('All Upcoming Events', style: AppTextStyles.eventsTitle.copyWith(fontSize: 30)),
                    SizedBox(height: _kHeaderIconRowMb),
                    Text(
                      '${AllUpcomingEventsController.allEvents.length} special occasions to celebrate',
                      style: AppTextStyles.eventsSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const Color _kBorderRose200 = Color(0x80FECDD3);

  Widget _buildSortToggle(BuildContext context, AllUpcomingEventsController c, String sortBy) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sort by:', style: AppTextStyles.eventsSortLabel.copyWith(fontSize: 14)),
        SizedBox(width: _kSortGap),
        Container(
          padding: const EdgeInsets.all(_kTogglePadding),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(_kToggleRadius),
            border: Border.all(color: _kBorderPink200, width: 2),
            boxShadow: AppShadows.eventsCard,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _sortButton(c, 'date', 'By Date', sortBy),
              const SizedBox(width: 8),
              _sortButton(c, 'loved_one', 'By Loved One', sortBy),
            ],
          ),
        ),
      ],
    );
  }

  static const Color _kBorderPink200 = Color(0x80FBCFE8);

  Widget _sortButton(AllUpcomingEventsController c, String value, String label, String current) {
    final isActive = current == value;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: value == 'date' ? c.setSortDate : c.setSortLovedOne,
        borderRadius: BorderRadius.circular(_kToggleBtnRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: _kToggleBtnPaddingH, vertical: _kToggleBtnPaddingV),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF43F5E), Color(0xFFEC4899)],
                  )
                : null,
            color: isActive ? null : Colors.white,
            borderRadius: BorderRadius.circular(_kToggleBtnRadius),
          ),
          child: Text(
            label,
            style: isActive ? AppTextStyles.eventsSortSelected : AppTextStyles.eventsSortUnselected,
          ),
        ),
      ),
    );
  }

  Widget _buildStayPreparedCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kBottomCardPadding),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)],
        ),
        borderRadius: BorderRadius.circular(_kBottomCardRadius),
        border: Border.all(color: const Color(0x80C4B5FD), width: 2),
        boxShadow: AppShadows.eventsCard,
      ),
      child: Column(
        children: [
          Icon(Icons.auto_awesome, size: 40, color: AppColors.eventsBackText),
          const SizedBox(height: 12),
          Text(
            'Stay prepared: Cherish AI will remind you about upcoming events and help you find the perfect gift for each occasion',
            style: AppTextStyles.eventsStayPrepared,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
