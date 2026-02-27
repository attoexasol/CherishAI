// lib/presentation/events/controllers/all_upcoming_events_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// One event item matching React AllUpcomingEventsScreen allEvents structure.
class AllUpcomingEventItem {
  const AllUpcomingEventItem({
    required this.id,
    required this.lovedOneName,
    required this.lovedOneAvatar,
    required this.relationship,
    required this.eventType,
    required this.eventDate,
    required this.daysUntil,
    required this.eventIcon,
    required this.priority,
  });
  final int id;
  final String lovedOneName;
  final String lovedOneAvatar;
  final String relationship;
  final String eventType;
  final String eventDate;
  final int daysUntil;
  final String eventIcon;
  final String priority; // 'high' | 'medium' | 'low'

  String get countdown => 'In $daysUntil days';
  bool get isUrgent => priority == 'high';
  bool get isSpecialOccasion => eventType == "Mother's Day";
  String titleByDate() => "$lovedOneName's $eventType";
}

/// Controller for All Upcoming Events screen. Sort and data match React exactly.
class AllUpcomingEventsController extends GetxController {
  final RxString sortType = 'date'.obs;

  static final List<AllUpcomingEventItem> allEvents = [
    const AllUpcomingEventItem(
      id: 1,
      lovedOneName: 'Sarah',
      lovedOneAvatar: '👩',
      relationship: 'Partner',
      eventType: 'Birthday',
      eventDate: 'January 23, 2026',
      daysUntil: 6,
      eventIcon: '🎂',
      priority: 'high',
    ),
    const AllUpcomingEventItem(
      id: 4,
      lovedOneName: 'Sarah',
      lovedOneAvatar: '👩',
      relationship: 'Partner',
      eventType: 'Anniversary',
      eventDate: 'June 14, 2026',
      daysUntil: 148,
      eventIcon: '💑',
      priority: 'medium',
    ),
    const AllUpcomingEventItem(
      id: 2,
      lovedOneName: 'Mom',
      lovedOneAvatar: '👩‍🦳',
      relationship: 'Mother',
      eventType: "Mother's Day",
      eventDate: 'May 11, 2026',
      daysUntil: 114,
      eventIcon: '🌸',
      priority: 'medium',
    ),
    const AllUpcomingEventItem(
      id: 5,
      lovedOneName: 'Mom',
      lovedOneAvatar: '👩‍🦳',
      relationship: 'Mother',
      eventType: 'Birthday',
      eventDate: 'August 30, 2026',
      daysUntil: 225,
      eventIcon: '🎂',
      priority: 'low',
    ),
    const AllUpcomingEventItem(
      id: 3,
      lovedOneName: 'Jake',
      lovedOneAvatar: '👨',
      relationship: 'Best Friend',
      eventType: 'Friendship Anniversary',
      eventDate: 'March 15, 2026',
      daysUntil: 57,
      eventIcon: '🤝',
      priority: 'low',
    ),
    const AllUpcomingEventItem(
      id: 6,
      lovedOneName: 'Jake',
      lovedOneAvatar: '👨',
      relationship: 'Best Friend',
      eventType: 'Birthday',
      eventDate: 'October 12, 2026',
      daysUntil: 268,
      eventIcon: '🎂',
      priority: 'low',
    ),
  ];

  List<AllUpcomingEventItem> get sortedEvents {
    final list = List<AllUpcomingEventItem>.from(allEvents);
    if (sortType.value == 'date') {
      list.sort((a, b) => a.daysUntil.compareTo(b.daysUntil));
    } else {
      list.sort((a, b) {
        final nameCompare = a.lovedOneName.compareTo(b.lovedOneName);
        if (nameCompare != 0) return nameCompare;
        return a.daysUntil.compareTo(b.daysUntil);
      });
    }
    return list;
  }

  Map<String, List<AllUpcomingEventItem>> get groupedByLovedOne {
    final map = <String, List<AllUpcomingEventItem>>{};
    for (final event in sortedEvents) {
      map.putIfAbsent(event.lovedOneName, () => []).add(event);
    }
    return map;
  }

  void onBackToDashboard() => Get.back();

  void setSortDate() => sortType.value = 'date';
  void setSortLovedOne() => sortType.value = 'loved_one';

  void onViewGiftIdeas(int eventId) {
    Get.toNamed(AppRoutes.giftIdeasDetail, arguments: {'eventId': eventId.toString()});
  }
}
