// lib/presentation/events/controllers/all_upcoming_events_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Sort mode: 0 = By Date, 1 = By Loved One
const int sortByDate = 0;
const int sortByLovedOne = 1;

/// One event for All Upcoming Events list (placeholder; wire to API later).
class AllUpcomingEventItem {
  const AllUpcomingEventItem({
    required this.id,
    required this.title,
    required this.relationship,
    required this.date,
    required this.countdown,
    this.isUrgent = false,
    this.isSpecialOccasion = false,
    this.iconType = 'birthday',
  });
  final String id;
  final String title;
  final String relationship;
  final String date;
  final String countdown;
  final bool isUrgent;
  final bool isSpecialOccasion;
  final String iconType;
}

/// Controller for All Upcoming Events screen.
class AllUpcomingEventsController extends GetxController {
  final RxInt sortMode = sortByDate.obs;

  final RxList<AllUpcomingEventItem> events = <AllUpcomingEventItem>[
    const AllUpcomingEventItem(
      id: '1',
      title: "Sarah's Birthday",
      relationship: '😊 Partner',
      date: 'January 23, 2026',
      countdown: 'In 6 days',
      isUrgent: true,
      iconType: 'birthday',
    ),
    const AllUpcomingEventItem(
      id: '2',
      title: "Jake's Friendship Anniversary",
      relationship: '🥳 Best Friend',
      date: 'March 20, 2026',
      countdown: 'In 57 days',
      iconType: 'handshake',
    ),
    const AllUpcomingEventItem(
      id: '3',
      title: "Mom's Mother's Day",
      relationship: '👩‍👧 Mother',
      date: 'May 11, 2026',
      countdown: 'In 114 days',
      isSpecialOccasion: true,
      iconType: 'flower',
    ),
    const AllUpcomingEventItem(
      id: '4',
      title: "Dad's Father's Day",
      relationship: '👨‍👧 Father',
      date: 'June 21, 2026',
      countdown: 'In 149 days',
      iconType: 'gift',
    ),
    const AllUpcomingEventItem(
      id: '5',
      title: "Anniversary",
      relationship: '😊 Partner',
      date: 'July 15, 2026',
      countdown: 'In 173 days',
      iconType: 'birthday',
    ),
    const AllUpcomingEventItem(
      id: '6',
      title: "Sister's Birthday",
      relationship: '👩 Sister',
      date: 'September 8, 2026',
      countdown: 'In 228 days',
      iconType: 'birthday',
    ),
  ].obs;

  void onBackToDashboard() {
    Get.back();
  }

  void onSelectSortMode(int mode) {
    sortMode.value = mode;
  }

  void onViewGiftIdeas(String eventId) {
    Get.toNamed(AppRoutes.giftIdeas, arguments: {'eventId': eventId});
  }
}
