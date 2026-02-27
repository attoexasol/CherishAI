// lib/presentation/events/widgets/loved_one_group_card.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_upcoming_events_controller.dart';
import 'event_card.dart';

const double _kHeaderRadius = 16;
const double _kHeaderPadding = 16;
const double _kHeaderGap = 12;
const double _kAvatarSize = 48;
const double _kAvatarRadius = 12;
const double _kHeaderToEventsSpacing = 12;
const double _kDividerWidth = 2;
const double _kDividerTopMargin = 8;
const double _kDividerToContentGap = 16;
const double _kEventsSpacing = 16;
const Color _kBorderRose200 = Color(0x80FECDD3);
const Color _kDividerColor = Color(0x80FBCFE8);

class LovedOneGroupCard extends StatelessWidget {
  const LovedOneGroupCard({
    super.key,
    required this.lovedOneName,
    required this.avatar,
    required this.relationship,
    required this.events,
    required this.onViewGiftIdeas,
  });

  final String lovedOneName;
  final String avatar;
  final String relationship;
  final List<AllUpcomingEventItem> events;
  final void Function(int eventId) onViewGiftIdeas;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(_kHeaderPadding),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFFFE4E6), Color(0xFFFCE7F3)],
            ),
            borderRadius: BorderRadius.circular(_kHeaderRadius),
            border: Border.all(color: _kBorderRose200, width: 2),
            boxShadow: AppShadows.eventsCard,
          ),
          child: Row(
            children: [
              Container(
                width: _kAvatarSize,
                height: _kAvatarSize,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_kAvatarRadius),
                  boxShadow: AppShadows.eventsCard,
                  border: Border.all(color: _kBorderRose200, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(avatar, style: const TextStyle(fontSize: 22), textAlign: TextAlign.center),
              ),
              SizedBox(width: _kHeaderGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(lovedOneName, style: AppTextStyles.eventsCardTitle.copyWith(fontSize: 20)),
                    const SizedBox(height: 4),
                    Text(
                      '$relationship · ${events.length} upcoming event${events.length != 1 ? 's' : ''}',
                      style: AppTextStyles.eventsCardRelationship,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: _kHeaderToEventsSpacing),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: _kDividerWidth,
                margin: const EdgeInsets.only(top: _kDividerTopMargin),
                color: _kDividerColor,
              ),
              const SizedBox(width: _kDividerToContentGap),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < events.length; i++) ...[
                      if (i > 0) const SizedBox(height: _kEventsSpacing),
                      EventCard(
                        event: events[i],
                        showLovedOneInTitle: false,
                        onViewGiftIdeas: () => onViewGiftIdeas(events[i].id),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
