// lib/presentation/events/widgets/event_card.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_upcoming_events_controller.dart';

/// React: rounded-3xl (24) p-6 (24), border-2, shadow-lg. Badge: mb-3, px-3 py-1 rounded-full text-xs. Icon w-16 h-16 (64) rounded-2xl (16). gap-4 (16) mb-5 (20). Button py-3 px-6 rounded-2xl.
const double _kCardRadius = 24;
const double _kCardPadding = 24;
const double _kBadgeMb = 12;
const double _kBadgePaddingH = 12;
const double _kBadgePaddingV = 4;
const double _kIconSize = 64;
const double _kIconRadius = 16;
const double _kRowGap = 16;
const double _kContentMb = 20;
const double _kBtnPaddingV = 12;
const double _kBtnPaddingH = 24;
const double _kBtnRadius = 16;
const Color _kBorderRose300 = Color(0xFFFDA4AF);
const Color _kBorderPink200 = Color(0x80FBCFE8);

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.showLovedOneInTitle,
    required this.onViewGiftIdeas,
  });

  final AllUpcomingEventItem event;
  final bool showLovedOneInTitle;
  final VoidCallback onViewGiftIdeas;

  @override
  Widget build(BuildContext context) {
    final borderColor = event.isUrgent ? _kBorderRose300 : _kBorderPink200;
    final isSpecial = event.isSpecialOccasion;
    final cardBg = isSpecial
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)],
          )
        : null;

    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: cardBg == null ? AppColors.eventsCardBg : null,
        gradient: cardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: AppShadows.eventsCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (event.isUrgent) ...[
            Container(
              margin: const EdgeInsets.only(bottom: _kBadgeMb),
              padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFF43F5E), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('URGENT', style: AppTextStyles.eventsBadge),
            ),
          ],
          if (event.isSpecialOccasion && !event.isUrgent) ...[
            Container(
              margin: const EdgeInsets.only(bottom: _kBadgeMb),
              padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('✨ ', style: AppTextStyles.eventsBadge),
                  Text('Special Occasion', style: AppTextStyles.eventsBadge),
                ],
              ),
            ),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _kIconSize,
                height: _kIconSize,
                decoration: BoxDecoration(
                  gradient: isSpecial
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFA78BFA), Color(0xFFF472B6)],
                        )
                      : const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFB7185), Color(0xFFA855F7)],
                        ),
                  borderRadius: BorderRadius.circular(_kIconRadius),
                  boxShadow: AppShadows.eventsCard,
                ),
                alignment: Alignment.center,
                child: Text(event.eventIcon, style: const TextStyle(fontSize: 28), textAlign: TextAlign.center),
              ),
              SizedBox(width: _kRowGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      showLovedOneInTitle ? event.titleByDate() : event.eventType,
                      style: AppTextStyles.eventsCardTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (showLovedOneInTitle)
                      Row(
                        children: [
                          Text(event.lovedOneAvatar, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(event.relationship, style: AppTextStyles.eventsCardRelationship),
                        ],
                      ),
                    if (showLovedOneInTitle) const SizedBox(height: 4),
                    Text(event.eventDate, style: AppTextStyles.eventsCardDate),
                    const SizedBox(height: 4),
                    Text(
                      event.countdown,
                      style: AppTextStyles.eventsCountdownPill.copyWith(
                        fontWeight: FontWeight.w600,
                        color: event.isUrgent ? const Color(0xFFE11D48) : const Color(0xFF9333EA),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: _kContentMb),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onViewGiftIdeas,
              borderRadius: BorderRadius.circular(_kBtnRadius),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: _kBtnPaddingV, horizontal: _kBtnPaddingH),
                decoration: BoxDecoration(
                  gradient: isSpecial
                      ? const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFFF43F5E)],
                          stops: [0.0, 0.5, 1.0],
                        )
                      : const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFF43F5E), Color(0xFFEC4899), Color(0xFFA855F7)],
                          stops: [0.0, 0.5, 1.0],
                        ),
                  borderRadius: BorderRadius.circular(_kBtnRadius),
                  boxShadow: AppShadows.eventsCard,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.card_giftcard, size: 20, color: AppColors.eventsBadgeText),
                    const SizedBox(width: 8),
                    Text('View Gift Ideas', style: AppTextStyles.eventsViewGiftBtn),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
