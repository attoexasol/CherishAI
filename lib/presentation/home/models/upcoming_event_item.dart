// lib/presentation/home/models/upcoming_event_item.dart

/// One upcoming event card. Mirrors React HomeDashboard upcomingEvents.
class UpcomingEventItem {
  const UpcomingEventItem({
    required this.id,
    required this.lovedOneName,
    required this.eventType,
    required this.eventDate,
    required this.daysUntil,
    required this.eventIcon,
    required this.priority,
  });

  final int id;
  final String lovedOneName;
  final String eventType;
  final String eventDate;
  final int daysUntil;
  final String eventIcon;
  final String priority; // 'high' | 'medium' | 'low'
}
