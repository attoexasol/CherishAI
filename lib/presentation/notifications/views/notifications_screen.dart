// lib/presentation/notifications/views/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/notifications_controller.dart';
import '../models/notification_item.dart';

const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 16;
const double _kBellIconSize = 48;
const double _kBellIconIconSize = 24;
const double _kMarkAllReadPaddingH = 16;
const double _kMarkAllReadPaddingV = 8;
const double _kTabPaddingH = 20;
const double _kTabPaddingV = 10;
const double _kCardRadius = 24;
const double _kCardPadding = 20;
const double _kUnreadBarWidth = 6;
const double _kCardIconSize = 56;
const double _kCardIconIconSize = 28;
const double _kBottomNavRadius = 28;
const double _kBottomNavPaddingH = 16;
const double _kBottomNavPaddingV = 12;
const double _kBottomNavHeight = 72;
const double _kBottomNavHideLabelWidth = 280;
const double _kEmptyIconSize = 96;
const double _kMaxContentWidthNotif = 896; // React max-w-4xl

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<NotificationsController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.notifPageBg,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final showBottomNavLabels = screenWidth >= _kBottomNavHideLabelWidth;
              final contentMaxWidth = screenWidth < (_kMaxContentWidthNotif + _kHeaderPaddingH * 2)
                  ? screenWidth
                  : _kMaxContentWidthNotif;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, c),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: _kHeaderPaddingH,
                        right: _kHeaderPaddingH,
                        top: 24,
                        bottom: _kBottomNavHeight + 24 + bottomPadding,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: contentMaxWidth),
                          child: Obx(() {
                            final list = c.filteredItems;
                            if (list.isEmpty) {
                              return _buildEmptyState(context, c);
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                list.length,
                                (i) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildNotificationCard(context, c, list[i]),
                                ),
                              ),
                            );
                          }),
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

  Widget _buildHeader(BuildContext context, NotificationsController c) {
    return Container(
      padding: const EdgeInsets.fromLTRB(_kHeaderPaddingH, _kHeaderPaddingV, _kHeaderPaddingH, 16),
      decoration: BoxDecoration(
        color: AppColors.notifHeaderBg,
        border: Border(
          bottom: BorderSide(color: AppColors.notifHeaderBorder),
        ),
      ),
      child: Obx(() {
        final unread = c.unreadCount;
        final all = c.allCount;
        final tabIndex = c.selectedTabIndex.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: c.onBack,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.notifBackText),
                        const SizedBox(width: 8),
                        Text('Back', style: AppTextStyles.notifBack),
                      ],
                    ),
                  ),
                ),
                if (unread > 0)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: c.onMarkAllRead,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: _kMarkAllReadPaddingH,
                          vertical: _kMarkAllReadPaddingV,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppGradients.notifPrimaryBtn,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: AppShadows.notifPrimaryBtn,
                        ),
                        child: Text('Mark All Read', style: AppTextStyles.notifMarkAllRead),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: _kBellIconSize,
                  height: _kBellIconSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.notifPrimaryBtn,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: AppShadows.notifBellIcon,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.notifications, size: _kBellIconIconSize, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => AppGradients.notifTitleGradient.createShader(bounds),
                        child: Text('Notifications', style: AppTextStyles.notifTitle),
                      ),
                      if (unread > 0) ...[
                        const SizedBox(height: 4),
                        Text(
                          '$unread unread ${unread == 1 ? 'notification' : 'notifications'}',
                          style: AppTextStyles.notifSubtitle,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTab(
                    context,
                    label: 'All ($all)',
                    isSelected: tabIndex == 0,
                    onTap: () => c.onSelectTab(0),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTab(
                    context,
                    label: 'Unread ($unread)',
                    isSelected: tabIndex == 1,
                    onTap: () => c.onSelectTab(1),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTab(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: _kTabPaddingH, vertical: _kTabPaddingV),
          decoration: BoxDecoration(
            gradient: isSelected ? AppGradients.notifPrimaryBtn : null,
            color: isSelected ? null : AppColors.notifTabInactiveBg,
            borderRadius: BorderRadius.circular(12),
            border: isSelected ? null : Border.all(color: AppColors.notifTabInactiveBorder, width: 2),
            boxShadow: isSelected ? AppShadows.notifPrimaryBtn : AppShadows.notifTabInactive,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTextStyles.notifTab.copyWith(
              color: isSelected ? AppColors.notifTabActiveText : AppColors.notifTabInactiveText,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    NotificationsController c,
    NotificationItem n,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.notifCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(
          color: n.isRead ? AppColors.notifCardBorderRead : AppColors.notifCardBorderUnread,
          width: n.isRead ? 1 : 2,
        ),
        boxShadow: n.isRead ? AppShadows.notifCardRead : AppShadows.notifCardUnread,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: Stack(
          children: [
            if (!n.isRead)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: _kUnreadBarWidth,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.notifUnreadBar,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(_kCardPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _kCardIconSize,
                    height: _kCardIconSize,
                    decoration: BoxDecoration(
                      gradient: n.gradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppShadows.notifCardIcon,
                    ),
                    alignment: Alignment.center,
                    child: Icon(_iconForNotification(n), size: _kCardIconIconSize, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                n.title,
                                style: AppTextStyles.notifCardTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              n.timestamp,
                              style: AppTextStyles.notifCardTime,
                              maxLines: 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          n.message,
                          style: AppTextStyles.notifCardBody,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (n.lovedOne != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: AppGradients.notifTagPillBg,
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: AppColors.notifTagPillBorder),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.favorite, size: 12, color: AppColors.notifTagPillText),
                                const SizedBox(width: 6),
                                Text(
                                  n.lovedOne!,
                                  style: AppTextStyles.notifTagPill,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            if (!n.isRead)
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => c.onMarkRead(n.id),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      gradient: AppGradients.notifPrimaryBtn,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: AppShadows.notifPrimaryBtn,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.check, size: 16, color: Colors.white),
                                        const SizedBox(width: 6),
                                        Text('Mark as Read', style: AppTextStyles.notifMarkReadBtn),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => c.onDeleteNotification(n.id),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppColors.notifDeleteBtnBg,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.notifDeleteBtnBorder),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.close, size: 16, color: AppColors.notifDeleteBtnText),
                                      const SizedBox(width: 6),
                                      Text('Delete', style: AppTextStyles.notifDeleteBtn),
                                    ],
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }

  IconData _iconForNotification(NotificationItem n) {
    if (n.iconKey != null) {
      switch (n.iconKey) {
        case 'gift':
          return Icons.card_giftcard;
        case 'message':
          return Icons.message;
        case 'calendar':
          return Icons.calendar_today;
        case 'sparkles':
          return Icons.auto_awesome;
        case 'award':
          return Icons.emoji_events;
        case 'heart':
          return Icons.favorite;
        case 'star':
          return Icons.star_outline;
      }
    }
    return _iconForType(n.type);
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'reminder':
        return Icons.calendar_today;
      case 'inspiration':
        return Icons.auto_awesome;
      case 'suggestion':
        return Icons.card_giftcard;
      case 'achievement':
        return Icons.emoji_events;
      case 'event':
        return Icons.favorite;
      default:
        return Icons.star_outline;
    }
  }

  Widget _buildEmptyState(BuildContext context, NotificationsController c) {
    final isUnreadTab = c.selectedTabIndex.value == 1;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        children: [
          Container(
            width: _kEmptyIconSize,
            height: _kEmptyIconSize,
            decoration: BoxDecoration(
              gradient: AppGradients.notifEmptyIconBg,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.notifEmptyIcon,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.notifications, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            'All Caught Up!',
            style: AppTextStyles.notifEmptyTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isUnreadTab
                ? "You don't have any unread notifications"
                : "You don't have any notifications yet",
            style: AppTextStyles.notifEmptyBody,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    NotificationsController c,
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
                child: _buildNavItem(context, c, 'search', Icons.search, 'Search', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'loved_ones', Icons.favorite_border, 'Loved Ones', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'alerts', Icons.notifications_outlined, 'Alerts', isActive: true, showLabel: showLabels),
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
    NotificationsController c,
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
