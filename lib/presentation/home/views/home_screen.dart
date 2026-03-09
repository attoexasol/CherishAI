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
const double _kGreetingCardPadding = 16;
const double _kGreetingTitleSubtitleGap = 6;
const double _kGreetingSubtitleChipsGap = 10;
const double _kPillPaddingH = 12;
const double _kPillPaddingV = 6;
const double _kPillIconSize = 16;
const double _kPillRadius = 12;
const double _kPillGap = 10;
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

// Responsive breakpoints for home (small phones)
const double _kBreakpointVeryNarrow = 360;
const double _kBreakpointNarrow = 390;

/// Resolves a value by screen width for home screen (message/event cards).
double _responsive(double width, double veryNarrow, double narrow, double normal) {
  if (width < _kBreakpointVeryNarrow) return veryNarrow;
  if (width < _kBreakpointNarrow) return narrow;
  return normal;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final bottomPadding = MediaQuery.of(context).padding.bottom;
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
                                screenWidth: screenWidth,
                                messageCardWidth: messageCardWidth,
                                cardGap: cardGap,
                                contentWidth: contentMaxWidth + horizontalPadding * 2,
                              ),
                              const SizedBox(height: _kSectionTitleGap),
                              _buildUpcomingEventsSection(
                                context,
                                c,
                                screenWidth: screenWidth,
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
          bottom: BorderSide(color: AppColors.homeIconButtonBorder.withAlpha(((0.5 * 255).toInt()))),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: _kGreetingCardPadding,
        vertical: _kGreetingCardPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.homeGreetingCardBg,
        borderRadius: BorderRadius.circular(_kGreetingCardRadius),
        border: Border.all(color: AppColors.homeGreetingCardBorder),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hello Sarah! 👋',
            style: AppTextStyles.homeGreetingTitle.copyWith(
              fontSize: 28,
              height: 1.25,
            ),
          ),
          SizedBox(height: _kGreetingTitleSubtitleGap),
          Text(
            "Let's make today meaningful for those you cherish",
            style: AppTextStyles.homeGreetingSubtitle.copyWith(
              fontSize: 16,
              height: 1.4,
            ),
          ),
          SizedBox(height: _kGreetingSubtitleChipsGap),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPill(
                  icon: Icons.favorite,
                  iconColor: AppColors.homeBellIcon,
                  label: '${c.lovedOnesCount} Loved Ones',
                  bgColor: AppColors.homePillRoseBg,
                  borderColor: AppColors.homePillRoseBorder,
                  onTap: c.onNavigateToLovedOnes,
                ),
                const SizedBox(width: _kPillGap),
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
          Icon(icon, size: _kPillIconSize, color: iconColor),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles.homePill.copyWith(fontSize: 13),
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
    required double screenWidth,
    required double messageCardWidth,
    required double cardGap,
    required double contentWidth,
  }) {
    final isNarrow = messageCardWidth < 320;
    final innerPadding = isNarrow ? 12.0 : 20.0;
    final bubblePadding = isNarrow ? 16.0 : _kMessageBubblePadding;
    final sectionHeight = _responsive(screenWidth, 520.0, 560.0, 600.0);

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
                text: '• SWIPE HORIZONTALLY to see all loved ones',
                style: AppTextStyles.homeSwipeHint.copyWith(color: AppColors.homeSwipeHint),
              ),
            ],
          ),
        ),
        // const SizedBox(height: 4),
        // GestureDetector(
        //   onTap: c.onNavigateToLovedOnes,
        //   child: Text(
        //     'to see all loved ones',
        //     style: TextStyle(
        //       fontSize: 11,
        //       fontWeight: FontWeight.w400,
        //       height: 1.3,
        //       color: AppColors.homeSwipeHint.withAlpha(((0.75 * 255).toInt())),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 20),
        SizedBox(
          height: sectionHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: c.dailyMessages.length,
            separatorBuilder: (_, __) => SizedBox(width: cardGap),
            itemBuilder: (context, index) {
              final msg = c.dailyMessages[index];
              return SizedBox(
                width: messageCardWidth,
                height: sectionHeight,
                child: _buildMessageCard(
                  context,
                  c,
                  msg,
                  screenWidth: screenWidth,
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
    required double screenWidth,
    double innerPadding = 20,
    double bubblePadding = 32,
  }) {
    final msgIconSize = _responsive(screenWidth, 12.0, 14.0, 16.0).round();
    final msgBtnPaddingV = _responsive(screenWidth, 10.0, 12.0, 14.0);
    final msgBtnPaddingH = _responsive(screenWidth, 6.0, 7.0, 8.0);
    final msgBodyFontSize = _responsive(screenWidth, 13.0, 14.0, 15.0);
    final msgGapAfterBubble = _responsive(screenWidth, 12.0, 18.0, 24.0);
    final msgGapBetweenRows = _responsive(screenWidth, 8.0, 12.0, 16.0);
    final likeDislikeIconSize = _responsive(screenWidth, 10.0, 11.0, 12.0).round();
    final likeDislikePaddingV = _responsive(screenWidth, 6.0, 7.0, 8.0);
    final regeneratePaddingV = _responsive(screenWidth, 10.0, 11.0, 12.0);
    final regenerateIconSize = _responsive(screenWidth, 14.0, 15.0, 16.0).round();
    final avatarSize = _responsive(screenWidth, 40.0, 44.0, _kAvatarSize);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(_responsive(screenWidth, 12.0, 14.0, _kMessageHeaderPadding)),
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
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppShadows.homeCard,
                      border: Border.all(color: AppColors.homeMessageBubbleBorder),
                    ),
                    alignment: Alignment.center,
                    child: Text(msg.lovedOneAvatar, style: TextStyle(fontSize: avatarSize * 0.5)),
                  ),
                  SizedBox(width: _responsive(screenWidth, 8.0, 10.0, 12.0)),
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
                        const SizedBox(height: 6),
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
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward, size: msgIconSize.toDouble(), color: AppColors.homeSwipeHint),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(innerPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
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
                          style: AppTextStyles.homeMessageBody.copyWith(fontSize: msgBodyFontSize, height: 1.35),
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(height: msgGapAfterBubble),
                    Row(
                      children: [
                        Expanded(
                          child: _buildPrevNextButton(
                            icon: Icons.arrow_back_ios_new,
                            label: 'Previous',
                            onTap: () => c.onPrevMessage(msg.id),
                            iconSize: msgIconSize.toDouble(),
                            paddingV: msgBtnPaddingV,
                            paddingH: msgBtnPaddingH,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _buildPrevNextButton(
                            icon: Icons.arrow_forward_ios,
                            label: 'Next',
                            onTap: () => c.onNextMessage(msg.id),
                            iconSize: msgIconSize.toDouble(),
                            paddingV: msgBtnPaddingV,
                            paddingH: msgBtnPaddingH,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: msgGapBetweenRows),
                    Obx(() {
                      final remaining = c.regenerateMessageRemaining.value;
                      final enabled = remaining > 0;
                      return _buildGradientButton(
                        icon: Icons.refresh,
                        label: 'Regenerate Message (Max 2/day)',
                        onTap: enabled ? () => c.onRegenerateMessage(msg.id) : null,
                        iconSize: regenerateIconSize.toDouble(),
                        paddingV: regeneratePaddingV,
                        screenWidth: screenWidth,
                        enabled: enabled,
                      );
                    }),
                    SizedBox(height: msgGapBetweenRows - 2),
                    Row(
                      children: [
                        Expanded(
                          child: _buildLikeDislikeButton(
                            icon: Icons.copy_outlined,
                            label: 'Copy',
                            isActive: false,
                            activeBgColor: AppColors.homeLikeGreenBg,
                            activeBorderColor: AppColors.homeLikeGreenBorder,
                            activeTextColor: AppColors.homeLikeGreenText,
                            onTap: () => c.onCopyMessage(msg.id),
                            iconSize: likeDislikeIconSize.toDouble(),
                            paddingV: likeDislikePaddingV,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildLikeDislikeButton(
                            icon: Icons.share_outlined,
                            label: 'Share',
                            isActive: false,
                            activeBgColor: AppColors.homeDislikeRedBg,
                            activeBorderColor: AppColors.homeDislikeRedBorder,
                            activeTextColor: AppColors.homeDislikeRedText,
                            onTap: () => c.onShareMessage(msg.id),
                            iconSize: likeDislikeIconSize.toDouble(),
                            paddingV: likeDislikePaddingV,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: msgGapBetweenRows - 2),
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
                            iconSize: likeDislikeIconSize.toDouble(),
                            paddingV: likeDislikePaddingV,
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
                            iconSize: likeDislikeIconSize.toDouble(),
                            paddingV: likeDislikePaddingV,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPrevNextButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    double iconSize = 16,
    double paddingV = 14,
    double paddingH = 8,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: paddingH),
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
              Icon(icon, size: iconSize, color: AppColors.homePrevNextText),
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
    VoidCallback? onTap,
    double iconSize = 16,
    double paddingV = 12,
    double screenWidth = 400,
    bool enabled = true,
  }) {
    final fontSize = _responsive(screenWidth, 11.0, 12.0, 14.0);
    final iconColor = enabled ? Colors.white : AppColors.giftIdeasDetailRegenerateDisabledText;
    final textColor = enabled ? Colors.white : AppColors.giftIdeasDetailRegenerateDisabledText;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: 12),
          decoration: BoxDecoration(
            gradient: enabled ? AppGradients.homeRegenerateBtn : null,
            color: enabled ? null : AppColors.giftIdeasDetailRegenerateDisabledBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: enabled ? AppShadows.homeRegenerateBtn : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: iconSize, color: iconColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: AppTextStyles.homeRegenerateBtn.copyWith(fontSize: fontSize, color: textColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
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
    double iconSize = 12,
    double paddingV = 8,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: 8),
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
                size: iconSize,
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
    required double screenWidth,
    required double eventCardWidth,
    required double cardGap,
    required double contentWidth,
  }) {
    final isNarrow = eventCardWidth < 300;
    final cardPadding = isNarrow ? 16.0 : _kEventCardPadding;
    final eventSectionHeight = _responsive(screenWidth, 240.0, 250.0, 260.0);
    final subtitleWrap = screenWidth < _kBreakpointVeryNarrow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Events', style: AppTextStyles.homeSectionTitle),
        const SizedBox(height: 4),
        if (subtitleWrap) ...[
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
          const SizedBox(height: 2),
          GestureDetector(
            onTap: c.onNavigateToAllEvents,
            child: Text(
              'to see all events',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: AppColors.homeSwipeHint,
              ),
            ),
          ),
        ] else
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 4,
            runSpacing: 2,
            children: [
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
              GestureDetector(
                onTap: c.onNavigateToAllEvents,
                child: Text(
                  'to see all events',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: AppColors.homeSwipeHint,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 20),
        SizedBox(
          height: eventSectionHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: 8),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: c.upcomingEvents.length,
            separatorBuilder: (_, __) => SizedBox(width: cardGap),
            itemBuilder: (context, index) {
              final event = c.upcomingEvents[index];
              return SizedBox(
                width: eventCardWidth,
                height: eventSectionHeight,
                child: _buildEventCard(
                  context,
                  c,
                  event,
                  screenWidth: screenWidth,
                  cardPadding: cardPadding,
                ),
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
    required double screenWidth,
    double cardPadding = 24,
  }) {
    final isUrgent = event.priority == 'high';
    final isSpecial = event.eventType == "Mother's Day";
    final eventIconSize = _responsive(screenWidth, 48.0, 56.0, _kEventIconSize);
    final badgePaddingH = _responsive(screenWidth, 8.0, 10.0, 12.0);
    final badgePaddingV = _responsive(screenWidth, 2.0, 3.0, 4.0);
    final badgeFontSize = _responsive(screenWidth, 9.0, 10.0, 11.0);
    final titleFontSize = _responsive(screenWidth, 14.0, 15.0, 16.0);
    final dateFontSize = _responsive(screenWidth, 12.0, 13.0, 14.0);
    final daysFontSize = _responsive(screenWidth, 11.0, 12.0, 13.0);
    final ctaGap = _responsive(screenWidth, 12.0, 16.0, 20.0);
    final eventCtaPaddingV = _responsive(screenWidth, 8.0, 10.0, 12.0);
    final eventCtaIconSize = _responsive(screenWidth, 14.0, 15.0, 16.0).round();

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
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isUrgent) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: badgePaddingH, vertical: badgePaddingV),
              decoration: BoxDecoration(
                gradient: AppGradients.homeUrgentBadge,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('URGENT', style: AppTextStyles.homeUrgentBadge.copyWith(fontSize: badgeFontSize)),
            ),
            SizedBox(height: _responsive(screenWidth, 6.0, 8.0, 12.0)),
          ],
          if (isSpecial && !isUrgent) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: badgePaddingH, vertical: badgePaddingV),
              decoration: BoxDecoration(
                gradient: AppGradients.homeRegenerateBtn,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('✨ Special Occasion', style: AppTextStyles.homeUrgentBadge.copyWith(fontSize: badgeFontSize), maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: _responsive(screenWidth, 6.0, 8.0, 12.0)),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: eventIconSize,
                height: eventIconSize,
                decoration: BoxDecoration(
                  gradient: isSpecial
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                        )
                      : AppGradients.homeEventIconSquare,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: AppShadows.homeRegenerateBtn,
                ),
                alignment: Alignment.center,
                child: Text(event.eventIcon, style: TextStyle(fontSize: eventIconSize * 0.44)),
              ),
              SizedBox(width: _responsive(screenWidth, 10.0, 12.0, 16.0)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${event.lovedOneName}'s ${event.eventType}",
                      style: AppTextStyles.homeEventTitle.copyWith(fontSize: titleFontSize),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      event.eventDate,
                      style: AppTextStyles.homeEventDate.copyWith(fontSize: dateFontSize),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'In ${event.daysUntil} days',
                      style: AppTextStyles.homeEventDays.copyWith(fontSize: daysFontSize),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ctaGap),
          const Spacer(),
          _buildGradientButton(
            icon: Icons.card_giftcard,
            label: isSpecial ? 'Special Gift Ideas' : 'Gift Ideas',
            onTap: () => c.onOpenGiftIdeas(event),
            iconSize: eventCtaIconSize.toDouble(),
            paddingV: eventCtaPaddingV,
            screenWidth: screenWidth,
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
    final bottomPadding = MediaQuery.of(context).padding.bottom;
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
