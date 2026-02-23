// lib/presentation/notifications/controllers/notifications_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_gradients.dart';
import '../models/notification_item.dart';

/// Minimal UI state for Notifications list. Mirrors React NotificationsListScreen.
/// Placeholder data; wire to existing repo when integrated.
class NotificationsController extends GetxController {
  final RxInt selectedTabIndex = 0.obs; // 0 = All, 1 = Unread

  final RxList<NotificationItem> items = <NotificationItem>[].obs;

  int get unreadCount => items.where((n) => n.isRead == false).length;
  int get allCount => items.length;

  List<NotificationItem> get filteredItems {
    if (selectedTabIndex.value == 1) {
      return items.where((n) => !n.isRead).toList();
    }
    return items.toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadPlaceholderNotifications();
  }

  void _loadPlaceholderNotifications() {
    items.assignAll([
      NotificationItem(
        id: '1',
        type: 'reminder',
        title: "Sarah's Birthday Coming Up!",
        message: "Sarah's birthday is in 5 days. Time to find the perfect gift!",
        timestamp: '2 hours ago',
        isRead: false,
        gradient: AppGradients.notifIconReminder,
        lovedOne: 'Sarah',
      ),
      NotificationItem(
        id: '2',
        type: 'inspiration',
        title: 'Daily Love Inspiration',
        message: "Small gestures of kindness can make someone's entire day brighter.",
        timestamp: '5 hours ago',
        isRead: false,
        gradient: AppGradients.notifIconInspiration,
      ),
      NotificationItem(
        id: '3',
        type: 'suggestion',
        title: 'Perfect Gift Idea for Mom',
        message: 'Based on her preferences, we found a beautiful handmade ceramic vase she might love!',
        timestamp: '1 day ago',
        isRead: true,
        gradient: AppGradients.notifIconSuggestionPink,
        lovedOne: 'Mom',
      ),
      NotificationItem(
        id: '4',
        type: 'achievement',
        title: '7-Day Streak! 🎉',
        message: "Amazing! You've stayed connected with your loved ones for 7 days straight!",
        timestamp: '1 day ago',
        isRead: true,
        gradient: AppGradients.notifIconAchievement,
      ),
      NotificationItem(
        id: '5',
        type: 'event',
        title: 'Anniversary Reminder',
        message: 'Your anniversary with Jake is coming up on June 1st.',
        timestamp: '2 days ago',
        isRead: true,
        gradient: AppGradients.notifIconEvent,
        lovedOne: 'Jake',
      ),
      NotificationItem(
        id: '6',
        type: 'suggestion',
        title: 'New Message Suggestion',
        message: 'We created a thoughtful message you can send to Sarah today.',
        timestamp: '3 days ago',
        isRead: true,
        gradient: AppGradients.notifIconSuggestionBlue,
        lovedOne: 'Sarah',
        iconKey: 'message',
      ),
      NotificationItem(
        id: '7',
        type: 'inspiration',
        title: 'Weekly Relationship Tip',
        message: "Quality time doesn't always mean grand gestures. Even a 5-minute phone call can strengthen bonds.",
        timestamp: '4 days ago',
        isRead: true,
        gradient: AppGradients.notifIconTip,
      ),
    ]);
  }

  void onBack() {
    Get.back();
  }

  void onMarkAllRead() {
    items.assignAll(items.map((n) => NotificationItem(
      id: n.id,
      type: n.type,
      title: n.title,
      message: n.message,
      timestamp: n.timestamp,
      isRead: true,
      gradient: n.gradient,
      lovedOne: n.lovedOne,
      iconKey: n.iconKey,
    )).toList());
  }

  void onSelectTab(int index) {
    selectedTabIndex.value = index;
  }

  void onMarkRead(String id) {
    items.assignAll(items.map((n) {
      if (n.id != id) return n;
      return NotificationItem(
        id: n.id,
        type: n.type,
        title: n.title,
        message: n.message,
        timestamp: n.timestamp,
        isRead: true,
        gradient: n.gradient,
        lovedOne: n.lovedOne,
        iconKey: n.iconKey,
      );
    }).toList());
  }

  void onDeleteNotification(String id) {
    items.removeWhere((n) => n.id == id);
  }

  void onTapBottomNav(String tab) {
    switch (tab) {
      case 'home':
        Get.offAllNamed(AppRoutes.home);
        break;
      case 'search':
        Get.toNamed(AppRoutes.search);
        break;
      case 'loved_ones':
        Get.toNamed(AppRoutes.lovedOnesList);
        break;
      case 'alerts':
        break; // already on notifications
      case 'profile':
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }
}
