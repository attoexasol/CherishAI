// lib/presentation/gift_ideas_detail/models/gift_ideas_detail_models.dart

/// Event context for the Gift Ideas Detail screen (mirrors React event by id).
class GiftIdeasDetailEvent {
  const GiftIdeasDetailEvent({
    required this.id,
    required this.lovedOneName,
    required this.eventType,
    required this.eventDate,
    required this.daysUntil,
    this.iconType = 'birthday',
  });
  final String id;
  final String lovedOneName;
  final String eventType;
  final String eventDate;
  final int daysUntil;
  final String iconType;

  String get title => "$lovedOneName's $eventType";
}

/// One gift suggestion item (mirrors React gift idea structure).
class GiftDetailItem {
  const GiftDetailItem({
    required this.id,
    required this.title,
    required this.description,
    required this.priceRange,
    required this.priceMin,
    required this.priceMax,
    required this.category,
    required this.whyPerfect,
    this.emoji = '✨',
    this.iconType = 'camera',
    this.vendorUrl,
  });
  final String id;
  final String title;
  final String description;
  final String priceRange;
  final double priceMin;
  final double priceMax;
  final String category;
  final String whyPerfect;
  final String emoji;
  final String iconType;
  final String? vendorUrl;
}
