// lib/presentation/gift_ideas/controllers/gift_ideas_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// One upcoming event item for Gift Ideas list (placeholder; wire to API later).
class GiftIdeasEventItem {
  const GiftIdeasEventItem({
    required this.id,
    required this.title,
    required this.date,
    required this.countdown,
    required this.isUrgent,
    this.iconType = 'birthday',
  });
  final String id;
  final String title;
  final String date;
  final String countdown;
  final bool isUrgent;
  final String iconType;
}

/// Controller for Gift Ideas screen. UI state only; wire to existing services when integrated.
class GiftIdeasController extends GetxController {
  final RxInt upcomingEventsCount = 4.obs;
  final RxInt savedGiftIdeasCount = 8.obs;
  final RxString userName = 'gjkjkjk'.obs;

  final RxList<GiftIdeasEventItem> upcomingEvents = <GiftIdeasEventItem>[
    const GiftIdeasEventItem(
      id: '1',
      title: "Sarah's Birthday",
      date: 'January 23, 2026',
      countdown: '6 days until the big day',
      isUrgent: true,
      iconType: 'birthday',
    ),
    const GiftIdeasEventItem(
      id: '2',
      title: "Mom's Mother's Day",
      date: 'May 11, 2026',
      countdown: '114 days until the big day',
      isUrgent: false,
      iconType: 'flower',
    ),
    const GiftIdeasEventItem(
      id: '3',
      title: "Jake's Friendship Anniversary",
      date: 'March 20, 2026',
      countdown: '57 days until the big day',
      isUrgent: false,
      iconType: 'handshake',
    ),
    const GiftIdeasEventItem(
      id: '4',
      title: "Dad's Father's Day",
      date: 'June 21, 2026',
      countdown: '149 days until the big day',
      isUrgent: false,
      iconType: 'gift',
    ),
  ].obs;

  void onBack() {
    Get.back();
  }

  void onViewAllGiftIdeas() {
    Get.toNamed(AppRoutes.giftIdeas);
  }

  void onViewGiftIdeas(String eventId) {
    Get.toNamed(AppRoutes.giftIdeas, arguments: {'eventId': eventId});
  }
}
