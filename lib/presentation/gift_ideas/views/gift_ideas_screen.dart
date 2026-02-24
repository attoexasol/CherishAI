// lib/presentation/gift_ideas/views/gift_ideas_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/gift_ideas_controller.dart';

const double _kBackBtnSize = 40;
const double _kBackIconSize = 20;
const double _kPaddingH = 24;
const double _kCardRadius = 24;
const double _kStatCardPadding = 20;
const double _kStatIconSize = 48;
const double _kStatIconRadius = 12;
const double _kViewAllBtnHeight = 48;
const double _kViewAllBtnRadius = 14;
const double _kEventCardPadding = 20;
const double _kEventIconSize = 64;
const double _kEventIconRadius = 16;
const double _kUrgentBadgeRadius = 999;
const double _kViewGiftBtnHeight = 40;
const double _kViewGiftBtnRadius = 12;
const double _kMaxWidth = 480;
const double _kBottomNavPadding = 88;

class GiftIdeasScreen extends StatelessWidget {
  const GiftIdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GiftIdeasController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.giftIdeasPageBgTop, AppColors.giftIdeasPageBgEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, c),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kPaddingH,
                    right: _kPaddingH,
                    bottom: _kBottomNavPadding + bottomPadding,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                      child: Obx(() {
                        final upcomingCount = c.upcomingEventsCount.value;
                        final savedCount = c.savedGiftIdeasCount.value;
                        final userName = c.userName.value;
                        final events = c.upcomingEvents;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Hello, $userName! 👋', style: AppTextStyles.giftIdeasGreeting),
                            const SizedBox(height: 4),
                            Text('Gift Ideas', style: AppTextStyles.giftIdeasTitle),
                            const SizedBox(height: 4),
                            Text(
                              'Find the perfect gift for every special moment',
                              style: AppTextStyles.giftIdeasSubtitle,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    context,
                                    icon: Icons.calendar_today,
                                    gradient: AppGradients.giftIdeasStatIcon1,
                                    number: upcomingCount.toString(),
                                    label: 'Upcoming Events',
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    context,
                                    icon: Icons.favorite_border,
                                    gradient: AppGradients.giftIdeasStatIcon2,
                                    number: savedCount.toString(),
                                    label: 'Saved Gift Ideas',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: c.onViewAllGiftIdeas,
                                borderRadius: BorderRadius.circular(_kViewAllBtnRadius),
                                child: Container(
                                  height: _kViewAllBtnHeight,
                                  decoration: BoxDecoration(
                                    gradient: AppGradients.giftIdeasViewAllBtn,
                                    borderRadius: BorderRadius.circular(_kViewAllBtnRadius),
                                    boxShadow: AppShadows.giftIdeasViewAllBtn,
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('View All Gift Ideas', style: AppTextStyles.giftIdeasViewAllBtn),
                                      const SizedBox(width: 6),
                                      Icon(Icons.chevron_right, size: 22, color: AppColors.giftIdeasUrgentBadgeText),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Row(
                              children: [
                                Text('Upcoming Events', style: AppTextStyles.giftIdeasSectionTitle),
                                const Spacer(),
                                Icon(Icons.show_chart, size: 18, color: AppColors.giftIdeasEventTitle),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ...events.map((event) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildEventCard(context, c, event),
                                )),
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

  Widget _buildHeader(BuildContext context, GiftIdeasController c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_kPaddingH, 16, _kPaddingH, 12),
      child: Row(
        children: [
          Material(
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
                child: Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required LinearGradient gradient,
    required String number,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(_kStatCardPadding),
      decoration: BoxDecoration(
        color: AppColors.giftIdeasStatCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _kStatIconSize,
            height: _kStatIconSize,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(_kStatIconRadius),
            ),
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(number, style: AppTextStyles.giftIdeasStatNumber),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.giftIdeasStatLabel),
        ],
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, GiftIdeasController c, GiftIdeasEventItem event) {
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
        if (event.isUrgent)
          Positioned(
            top: -6,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.giftIdeasUrgentBadgeBg,
                borderRadius: BorderRadius.circular(_kUrgentBadgeRadius),
              ),
              child: Text('Urgent', style: AppTextStyles.giftIdeasUrgentBadge),
            ),
          ),
        Container(
          padding: const EdgeInsets.all(_kEventCardPadding),
          decoration: BoxDecoration(
            color: AppColors.giftIdeasEventCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: AppShadows.giftIdeasCard,
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
                    child: Icon(iconData, size: 28, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.title, style: AppTextStyles.giftIdeasEventTitle),
                        const SizedBox(height: 4),
                        Text(event.date, style: AppTextStyles.giftIdeasEventDate),
                        const SizedBox(height: 4),
                        Text(
                          event.countdown,
                          style: event.isUrgent
                              ? AppTextStyles.giftIdeasCountdownUrgent
                              : AppTextStyles.giftIdeasCountdown,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: AppGradients.giftIdeasViewAllBtn,
                      borderRadius: BorderRadius.circular(_kViewGiftBtnRadius),
                      boxShadow: AppShadows.giftIdeasViewAllBtn,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('View Gift Ideas', style: AppTextStyles.giftIdeasViewGiftBtn),
                        const SizedBox(width: 6),
                        Icon(Icons.chevron_right, size: 18, color: AppColors.giftIdeasUrgentBadgeText),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
