// lib/presentation/home/models/daily_message_item.dart

/// One loved-one message card with 3 cyclable messages. Mirrors React HomeDashboard dailyMessages.
class DailyMessageItem {
  const DailyMessageItem({
    required this.id,
    required this.lovedOneName,
    required this.lovedOneAvatar,
    required this.relationship,
    required this.messages,
  });

  final int id;
  final String lovedOneName;
  final String lovedOneAvatar;
  final String relationship;
  final List<String> messages;
}
