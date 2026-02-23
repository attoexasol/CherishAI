// lib/presentation/notifications/models/notification_item.dart
import 'package:flutter/material.dart';

/// Single notification item. Mirrors React NotificationsListScreen Notification.
/// id is String for controller API (onMarkRead(String id), onDelete(String id)).
class NotificationItem {
  const NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.gradient,
    this.lovedOne,
    this.iconKey,
  });

  final String id;
  final String type; // reminder | inspiration | achievement | suggestion | event
  final String title;
  final String message;
  final String timestamp;
  final bool isRead;
  final LinearGradient gradient;
  final String? lovedOne;
  /// Optional: 'gift' | 'message' | 'calendar' | 'sparkles' | 'award' | 'heart' | 'star' to override icon from type.
  final String? iconKey;
}
