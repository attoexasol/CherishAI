// lib/presentation/home/controllers/home_controller.dart
import 'package:get/get.dart';
import '../models/daily_message_item.dart';
import '../models/upcoming_event_item.dart';
import '../../../app/routes/app_routes.dart';
import '../../account_settings/controllers/account_settings_controller.dart';

/// Minimal UI state for Home screen. Mirrors React HomeDashboard behavior.
/// Data is placeholder; wire to existing repositories when integrated.
class HomeController extends GetxController {
  /// Current message index per loved-one id (0, 1, or 2)
  final RxMap<int, int> currentMessageIndexes = <int, int>{}.obs;

  /// Liked message card ids (loved-one id)
  final RxList<int> likedMessages = <int>[].obs;

  /// Disliked message card ids
  final RxList<int> dislikedMessages = <int>[].obs;

  /// Daily inspiration like state
  final RxBool isInspirationLiked = false.obs;

  /// Regenerating state for loading indicator (optional)
  final RxBool isRegenerating = false.obs;

  /// Placeholder data: daily messages per loved one (mirrors React)
  final List<DailyMessageItem> dailyMessages = [
    const DailyMessageItem(
      id: 1,
      lovedOneName: 'Sarah',
      lovedOneAvatar: '👩',
      relationship: 'Partner',
      messages: [
        'Good morning beautiful! I was just thinking about that amazing dinner we had last week. Want to try that new Italian place tonight?',
        'You make every day brighter just by being in it. Looking forward to our weekend together! ❤️',
        "I picked up your favorite coffee on my way home. Can't wait to see your smile when I get there! ☕💕",
      ],
    ),
    const DailyMessageItem(
      id: 2,
      lovedOneName: 'Mom',
      lovedOneAvatar: '👩‍🦳',
      relationship: 'Mother',
      messages: [
        "Hi Mom! Just wanted to let you know I'm thinking of you today. Thank you for always being my biggest supporter. Love you! ❤️",
        'Remember that recipe you taught me? I tried making it today and it turned out great! You\'re the best teacher. 🥘',
        "Hope you're having a wonderful day! Let's plan a lunch date this week - I miss our chats! 💐",
      ],
    ),
    const DailyMessageItem(
      id: 3,
      lovedOneName: 'Jake',
      lovedOneAvatar: '👨',
      relationship: 'Best Friend',
      messages: [
        "Hey buddy! That hiking trip we talked about? Let's make it happen this weekend. I found an awesome trail!",
        'Dude, just saw this meme and immediately thought of you 😂 Sending it your way!',
        "Game night at my place Friday? I'll order the pizza, you bring the competitive spirit! 🎮🍕",
      ],
    ),
  ];

  /// Placeholder: upcoming events
  final List<UpcomingEventItem> upcomingEvents = [
    const UpcomingEventItem(
      id: 1,
      lovedOneName: 'Sarah',
      eventType: 'Birthday',
      eventDate: 'January 23, 2026',
      daysUntil: 6,
      eventIcon: '🎂',
      priority: 'high',
    ),
    const UpcomingEventItem(
      id: 2,
      lovedOneName: 'Mom',
      eventType: "Mother's Day",
      eventDate: 'May 11, 2026',
      daysUntil: 114,
      eventIcon: '🌸',
      priority: 'medium',
    ),
    const UpcomingEventItem(
      id: 3,
      lovedOneName: 'Jake',
      eventType: 'Friendship Anniversary',
      eventDate: 'March 15, 2026',
      daysUntil: 57,
      eventIcon: '🤝',
      priority: 'low',
    ),
  ];

  /// Placeholder: daily inspiration
  static const String dailyInspirationQuote =
      '"Cherish the little moments - they often turn into the most beautiful memories."';
  static const String dailyInspirationAuthor = 'Cherish AI';

  @override
  void onInit() {
    super.onInit();
    for (final m in dailyMessages) {
      currentMessageIndexes[m.id] = 0;
    }
  }

  int currentMessageIndex(int lovedOneId) =>
      currentMessageIndexes[lovedOneId] ?? 0;

  int get lovedOnesCount => dailyMessages.length;
  int get eventsSoonCount => upcomingEvents.length;

  void onTapBell() {
    Get.toNamed(AppRoutes.notificationsList);
  }

  void onTapSettings() {
    Get.find<AccountSettingsController>().openDialog();
  }

  void onPrevMessage(int lovedOneId) {
    final current = currentMessageIndex(lovedOneId);
    final prev = current == 0 ? 2 : current - 1;
    currentMessageIndexes[lovedOneId] = prev;
  }

  void onNextMessage(int lovedOneId) {
    final current = currentMessageIndex(lovedOneId);
    final next = (current + 1) % 3;
    currentMessageIndexes[lovedOneId] = next;
  }

  void onRegenerateMessage(int lovedOneId) {
    onNextMessage(lovedOneId);
  }

  void onLikeMessage(int lovedOneId) {
    if (likedMessages.contains(lovedOneId)) {
      likedMessages.remove(lovedOneId);
    } else {
      likedMessages.add(lovedOneId);
      dislikedMessages.remove(lovedOneId);
    }
  }

  void onDislikeMessage(int lovedOneId) {
    if (dislikedMessages.contains(lovedOneId)) {
      dislikedMessages.remove(lovedOneId);
    } else {
      dislikedMessages.add(lovedOneId);
      likedMessages.remove(lovedOneId);
    }
  }

  void onOpenGiftIdeas(int eventId) {
    Get.toNamed(AppRoutes.giftIdeas, arguments: {'eventId': eventId});
  }

  void onLikeInspiration() {
    isInspirationLiked.toggle();
  }

  void onShareInspiration() {
    // Use share_plus or platform share when available
  }

  void onTapBottomNav(String tab) {
    switch (tab) {
      case 'home':
        break; // already on home
      case 'search':
        Get.toNamed(AppRoutes.search);
        break;
      case 'loved_ones':
        Get.toNamed(AppRoutes.lovedOnesList);
        break;
      case 'alerts':
        Get.toNamed(AppRoutes.notificationsList);
        break;
      case 'profile':
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }

  void onNavigateToLovedOnes() {
    Get.toNamed(AppRoutes.lovedOnesList);
  }

  void onNavigateToAllEvents() {
    Get.toNamed(AppRoutes.allUpcomingEvents);
  }

  void onYourApproach(String lovedOneName) {
    Get.toNamed(AppRoutes.yourApproach, arguments: {'name': lovedOneName});
  }
}
