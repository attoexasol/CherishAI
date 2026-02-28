// lib/presentation/home/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/home_controller.dart';
import '../models/daily_message_item.dart';
import '../models/upcoming_event_item.dart';

const double _kTopBarPaddingH = 16;
const double _kTopBarPaddingV = 16;
const double _kHeartSize = 40;
const double _kHeartIconSize = 20;
const double _kIconButtonSize = 44;
const double _kIconButtonIconSize = 20;
const double _kGreetingCardRadius = 24;
const double _kGreetingCardPadding = 24;
const double _kPillPaddingH = 16;
const double _kPillPaddingV = 8;
const double _kPillRadius = 12;
const double _kSectionTitleGap = 20;
const double _kMessageCardWidthMax = 360;
const double _kMessageCardGap = 20;
const double _kMessageCardRadius = 24;
const double _kMessageHeaderPadding = 16;
const double _kAvatarSize = 48;
const double _kMessageBubbleRadius = 16;
const double _kMessageBubblePadding = 32;
const double _kEventCardWidthMax = 340;
const double _kEventCardRadius = 24;
const double _kEventCardPadding = 24;
const double _kEventIconSize = 64;
const double _kInspirationCardRadius = 24;
const double _kInspirationCardPadding = 32;
const double _kInspirationIconSize = 64;
const double _kBottomNavRadius = 28;
const double _kBottomNavPaddingH = 16;
const double _kBottomNavPaddingV = 12;
const double _kBottomNavHeight = 72;
const double _kHorizontalPadding = 24;
const double _kMinTapTarget = 44;
const double _kBottomNavHideLabelWidth = 280;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
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
              final contentMaxWidth = screenWidth < (kMaxContentWidth + _kHorizontalPadding * 2)
                  ? screenWidth - _kHorizontalPadding * 2
                  : kMaxContentWidth;
              final horizontalPadding = screenWidth < Breakpoints.sm
                  ? 16.0
                  : _kHorizontalPadding;
              final messageCardWidth = (contentMaxWidth + horizontalPadding * 2) < _kMessageCardWidthMax + _kMessageCardGap
                  ? (screenWidth - horizontalPadding * 2).clamp(200.0, double.infinity)
                  : _kMessageCardWidthMax;
              final eventCardWidth = (contentMaxWidth + horizontalPadding * 2) < _kEventCardWidthMax + _kMessageCardGap
                  ? (screenWidth - horizontalPadding * 2).clamp(200.0, double.infinity)
                  : _kEventCardWidthMax;
              final cardGap = screenWidth < Breakpoints.sm ? 12.0 : _kMessageCardGap;
              final showBottomNavLabels = screenWidth >= _kBottomNavHideLabelWidth;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopBar(context, c),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: horizontalPadding,
                        right: horizontalPadding,
                        top: 24,
                        bottom: _kBottomNavHeight + 24 + bottomPadding,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: contentMaxWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildGreetingCard(context, c, screenWidth),
                              const SizedBox(height: _kSectionTitleGap),
                              _buildDailyMessagesSection(
                                context,
                                c,
                                messageCardWidth: messageCardWidth,
                                cardGap: cardGap,
                                contentWidth: contentMaxWidth + horizontalPadding * 2,
                              ),
                              const SizedBox(height: _kSectionTitleGap),
                              _buildUpcomingEventsSection(
                                context,
                                c,
                                eventCardWidth: eventCardWidth,
                                cardGap: cardGap,
                                contentWidth: contentMaxWidth + horizontalPadding * 2,
                              ),
                              const SizedBox(height: _kSectionTitleGap),
                              _buildDailyInspirationSection(context, c),
                            ],
                          ),
                        ),
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

  Widget _buildTopBar(BuildContext context, HomeController c) {
    return Container(
      padding: EdgeInsets.fromLTRB(_kTopBarPaddingH, _kTopBarPaddingV, _kTopBarPaddingH, 16),
      decoration: BoxDecoration(
        color: AppColors.homeTopBarBg,
        border: Border(
          bottom: BorderSide(color: AppColors.homeIconButtonBorder.withValues(alpha: 0.5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: _kHeartSize,
            height: _kHeartSize,
            decoration: BoxDecoration(
              color: AppColors.homeHeartIconBg,
              shape: BoxShape.circle,
              boxShadow: AppShadows.homeCard,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.favorite, size: _kHeartIconSize, color: Colors.white),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                context,
                icon: Icons.notifications_outlined,
                hasDot: true,
                onTap: c.onTapBell,
              ),
              const SizedBox(width: 8),
              _buildIconButton(
                context,
                icon: Icons.settings_outlined,
                onTap: c.onTapSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    bool hasDot = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _kIconButtonSize,
        height: _kIconButtonSize,
        decoration: BoxDecoration(
          color: AppColors.homeIconButtonBg,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.homeIconButtonBorder),
          boxShadow: AppShadows.homeCard,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(icon, size: _kIconButtonIconSize, color: AppColors.homeBellIcon),
            ),
            if (hasDot)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.homeNotificationDot,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingCard(BuildContext context, HomeController c, double screenWidth) {
    final useWrap = screenWidth < Breakpoints.sm;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kGreetingCardPadding),
      decoration: BoxDecoration(
        color: AppColors.homeGreetingCardBg,
        borderRadius: BorderRadius.circular(_kGreetingCardRadius),
        border: Border.all(color: AppColors.homeGreetingCardBorder),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello Sarah! 👋',
            style: AppTextStyles.homeGreetingTitle,
          ),
          const SizedBox(height: 8),
          Text(
            "Let's make today meaningful for those you cherish",
            style: AppTextStyles.homeGreetingSubtitle,
          ),
          const SizedBox(height: 16),
          useWrap
              ? Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildPill(
                      icon: Icons.favorite,
                      iconColor: AppColors.homeBellIcon,
                      label: '${c.lovedOnesCount} Loved Ones',
                      bgColor: AppColors.homePillRoseBg,
                      borderColor: AppColors.homePillRoseBorder,
                      onTap: c.onNavigateToLovedOnes,
                    ),
                    _buildPill(
                      icon: Icons.calendar_today,
                      iconColor: AppColors.homeSwipeHint,
                      label: '${c.eventsSoonCount} Events Soon',
                      bgColor: AppColors.homePillPurpleBg,
                      borderColor: AppColors.homePillPurpleBorder,
                      onTap: c.onNavigateToAllEvents,
                    ),
                  ],
                )
              : Row(
                  children: [
                    _buildPill(
                      icon: Icons.favorite,
                      iconColor: AppColors.homeBellIcon,
                      label: '${c.lovedOnesCount} Loved Ones',
                      bgColor: AppColors.homePillRoseBg,
                      borderColor: AppColors.homePillRoseBorder,
                      onTap: c.onNavigateToLovedOnes,
                    ),
                    const SizedBox(width: 16),
                    _buildPill(
                      icon: Icons.calendar_today,
                      iconColor: AppColors.homeSwipeHint,
                      label: '${c.eventsSoonCount} Events Soon',
                      bgColor: AppColors.homePillPurpleBg,
                      borderColor: AppColors.homePillPurpleBorder,
                      onTap: c.onNavigateToAllEvents,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildPill({
    required IconData icon,
    required Color iconColor,
    required String label,
    required Color bgColor,
    required Color borderColor,
    VoidCallback? onTap,
  }) {
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: _kPillPaddingH, vertical: _kPillPaddingV),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_kPillRadius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.homePill,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: child);
    }
    return child;
  }

  Widget _buildDailyMessagesSection(
    BuildContext context,
    HomeController c, {
    required double messageCardWidth,
    required double cardGap,
    required double contentWidth,
  }) {
    final isNarrow = messageCardWidth < 320;
    final innerPadding = isNarrow ? 12.0 : 20.0;
    final bubblePadding = isNarrow ? 16.0 : _kMessageBubblePadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Messages', style: AppTextStyles.homeSectionTitle),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: AppTextStyles.homeSectionSubtitle.copyWith(color: AppColors.homeSectionSubtitle),
            children: [
              const TextSpan(text: 'Personalized for each loved one. '),
              TextSpan(
                text: '• SWIPE HORIZONTALLY',
                style: AppTextStyles.homeSwipeHint.copyWith(color: AppColors.homeSwipeHint),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: isNarrow ? 600 : 600,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: c.dailyMessages.length,
            separatorBuilder: (_, __) => SizedBox(width: cardGap),
            itemBuilder: (context, index) {
              final msg = c.dailyMessages[index];
              return SizedBox(
                width: messageCardWidth,
                child: _buildMessageCard(
                  context,
                  c,
                  msg,
                  innerPadding: innerPadding,
                  bubblePadding: bubblePadding,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageCard(
    BuildContext context,
    HomeController c,
    DailyMessageItem msg, {
    double innerPadding = 20,
    double bubblePadding = 32,
  }) {
    return Obx(() {
      final currentIdx = c.currentMessageIndex(msg.id);
      final text = msg.messages[currentIdx.clamp(0, msg.messages.length - 1)];
      final isLiked = c.likedMessages.contains(msg.id);
      final isDisliked = c.dislikedMessages.contains(msg.id);
      return Container(
        decoration: BoxDecoration(
          color: AppColors.homeMessageCardBg,
          borderRadius: BorderRadius.circular(_kMessageCardRadius),
          border: Border.all(color: AppColors.homeMessageCardBorder, width: 2),
          boxShadow: AppShadows.homeMessageCard,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(_kMessageHeaderPadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.homeMessageBubbleBgStart,
                      AppColors.homeMessageBubbleBgEnd,
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(_kMessageCardRadius - 2)),
                  border: Border(
                    bottom: BorderSide(color: AppColors.homeMessageBubbleBorder, width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: _kAvatarSize,
                      height: _kAvatarSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: AppShadows.homeCard,
                        border: Border.all(color: AppColors.homeMessageBubbleBorder),
                      ),
                      alignment: Alignment.center,
                      child: Text(msg.lovedOneAvatar, style: const TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'For ${msg.lovedOneName}',
                            style: AppTextStyles.homeMessageCardTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            msg.relationship,
                            style: AppTextStyles.homeMessageCardRelation,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => c.onYourApproach(msg.lovedOneName),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Your approach with ${msg.lovedOneName}',
                                    style: AppTextStyles.homeMessageLink,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(Icons.arrow_forward, size: 16, color: AppColors.homeSwipeHint),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(innerPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(bubblePadding),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.homeMessageBubbleBgStart,
                            AppColors.homeMessageBubbleBgEnd,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(_kMessageBubbleRadius),
                        border: Border.all(color: AppColors.homeMessageBubbleBorder, width: 2),
                        boxShadow: AppShadows.homeCard,
                      ),
                      child: Text(
                        text,
                        style: AppTextStyles.homeMessageBody,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPrevNextButton(
                            icon: Icons.arrow_back_ios_new,
                            label: 'Previous',
                            onTap: () => c.onPrevMessage(msg.id),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildPrevNextButton(
                            icon: Icons.arrow_forward_ios,
                            label: 'Next',
                            onTap: () => c.onNextMessage(msg.id),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildGradientButton(
                      icon: Icons.refresh,
                      label: 'Regenerate Message',
                      onTap: () => c.onRegenerateMessage(msg.id),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildLikeDislikeButton(
                            icon: Icons.thumb_up_outlined,
                            label: 'Like',
                            isActive: isLiked,
                            activeBgColor: AppColors.homeLikeGreenBg,
                            activeBorderColor: AppColors.homeLikeGreenBorder,
                            activeTextColor: AppColors.homeLikeGreenText,
                            onTap: () => c.onLikeMessage(msg.id),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildLikeDislikeButton(
                            icon: Icons.thumb_down_outlined,
                            label: 'Dislike',
                            isActive: isDisliked,
                            activeBgColor: AppColors.homeDislikeRedBg,
                            activeBorderColor: AppColors.homeDislikeRedBorder,
                            activeTextColor: AppColors.homeDislikeRedText,
                            onTap: () => c.onDislikeMessage(msg.id),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPrevNextButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: _kMinTapTarget),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.homePrevNextBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.homePrevNextBorder, width: 2),
            boxShadow: AppShadows.homeCard,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: AppColors.homePrevNextText),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.homePrevNext,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: _kMinTapTarget),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient: AppGradients.homeRegenerateBtn,
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppShadows.homeRegenerateBtn,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.homeRegenerateBtn,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLikeDislikeButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeBgColor,
    required Color activeBorderColor,
    required Color activeTextColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: const BoxConstraints(minHeight: _kMinTapTarget),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: isActive ? activeBgColor : AppColors.homePrevNextBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? activeBorderColor : AppColors.homeMessageBubbleBorder,
              width: isActive ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 12,
                color: isActive ? activeTextColor : AppColors.homeSectionSubtitle,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.homeLikeDislike.copyWith(
                    color: isActive ? activeTextColor : AppColors.homeSectionSubtitle,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventsSection(
    BuildContext context,
    HomeController c, {
    required double eventCardWidth,
    required double cardGap,
    required double contentWidth,
  }) {
    final isNarrow = eventCardWidth < 300;
    final cardPadding = isNarrow ? 16.0 : _kEventCardPadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Events', style: AppTextStyles.homeSectionTitle),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: AppTextStyles.homeSectionSubtitle.copyWith(color: AppColors.homeSectionSubtitle),
            children: [
              const TextSpan(
                text: 'Never miss a meaningful moment meant to celebrate the people you love • ',
              ),
              TextSpan(
                text: 'SWIPE HORIZONTALLY',
                style: AppTextStyles.homeSwipeHint.copyWith(color: AppColors.homeSwipeHint),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: c.upcomingEvents.length,
            separatorBuilder: (_, __) => SizedBox(width: cardGap),
            itemBuilder: (context, index) {
              final event = c.upcomingEvents[index];
              return SizedBox(
                width: eventCardWidth,
                child: _buildEventCard(context, c, event, cardPadding: cardPadding),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context,
    HomeController c,
    UpcomingEventItem event, {
    double cardPadding = 24,
  }) {
    final isUrgent = event.priority == 'high';
    final isSpecial = event.eventType == "Mother's Day";
    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: isSpecial
            ? AppColors.homePillPurpleBg
            : AppColors.homeGreetingCardBg,
        borderRadius: BorderRadius.circular(_kEventCardRadius),
        border: Border.all(
          color: isUrgent ? AppColors.homeEventCardBorderUrgent : AppColors.homeEventCardBorder,
          width: 2,
        ),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isUrgent) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppGradients.homeUrgentBadge,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('URGENT', style: AppTextStyles.homeUrgentBadge),
            ),
            const SizedBox(height: 12),
          ],
          if (isSpecial && !isUrgent) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppGradients.homeRegenerateBtn,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('✨ Special Occasion', style: AppTextStyles.homeUrgentBadge),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: _kEventIconSize,
                height: _kEventIconSize,
                decoration: BoxDecoration(
                  gradient: isSpecial
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                        )
                      : AppGradients.homeEventIconSquare,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppShadows.homeRegenerateBtn,
                ),
                alignment: Alignment.center,
                child: Text(event.eventIcon, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${event.lovedOneName}'s ${event.eventType}",
                      style: AppTextStyles.homeEventTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.eventDate,
                      style: AppTextStyles.homeEventDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'In ${event.daysUntil} days',
                      style: AppTextStyles.homeEventDays,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildGradientButton(
            icon: Icons.card_giftcard,
            label: isSpecial ? 'Special Gift Ideas' : 'Gift Ideas',
            onTap: () => c.onOpenGiftIdeas(event.id),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyInspirationSection(BuildContext context, HomeController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Inspiration', style: AppTextStyles.homeSectionTitle),
        const SizedBox(height: 4),
        Text('A moment of reflection', style: AppTextStyles.homeSectionSubtitle),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(_kInspirationCardPadding),
          decoration: BoxDecoration(
            gradient: AppGradients.homeInspirationCardBg,
            borderRadius: BorderRadius.circular(_kInspirationCardRadius),
            border: Border.all(color: AppColors.homeInspirationCardBorder, width: 2),
            boxShadow: AppShadows.homeInspirationCard,
          ),
          child: Column(
            children: [
              Container(
                width: _kInspirationIconSize,
                height: _kInspirationIconSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.homeInspirationIcon,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppShadows.homeRegenerateBtn,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.auto_awesome, size: 32, color: Colors.white),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.homeInspirationQuoteBg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppShadows.homeCard,
                ),
                child: Column(
                  children: [
                    Text(
                      HomeController.dailyInspirationQuote,
                      style: AppTextStyles.homeInspirationQuote,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '– ${HomeController.dailyInspirationAuthor}',
                      style: AppTextStyles.homeInspirationAuthor,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Obx(() {
                final liked = c.isInspirationLiked.value;
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: c.onLikeInspiration,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: liked ? AppGradients.homeInspirationLikeActive : null,
                            color: liked ? null : AppColors.homeInspirationQuoteBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: liked ? Colors.transparent : AppColors.homeMessageBubbleBorder,
                            ),
                            boxShadow: AppShadows.homeCard,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 20,
                                color: liked ? Colors.white : AppColors.homeInspirationLikeInactive,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                liked ? 'Liked' : 'Like',
                                style: AppTextStyles.homeInspirationLikeShare.copyWith(
                                  color: liked ? Colors.white : AppColors.homeInspirationLikeInactive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => c.onShareText(
                              text: HomeController.dailyInspirationQuote,
                              subject: 'CherishAI',
                            ),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.homeInspirationQuoteBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.homeMessageBubbleBorder),
                            boxShadow: AppShadows.homeCard,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.share, size: 20, color: AppColors.homeInspirationLikeInactive),
                              const SizedBox(width: 8),
                              Text(
                                'Share',
                                style: AppTextStyles.homeInspirationLikeShare.copyWith(
                                  color: AppColors.homeInspirationLikeInactive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav(BuildContext context, HomeController c, bool showLabels) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.only(
        left: _kBottomNavPaddingH,
        right: _kBottomNavPaddingH,
        top: _kBottomNavPaddingV,
        bottom: _kBottomNavPaddingV + bottomPadding,
      ),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
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
                child: _buildNavItem(context, c, 'home', Icons.home_rounded, 'Home', isActive: true, showLabel: showLabels),
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
    HomeController c,
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
    );
  }
}
