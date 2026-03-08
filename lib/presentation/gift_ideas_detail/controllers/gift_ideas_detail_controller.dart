// lib/presentation/gift_ideas_detail/controllers/gift_ideas_detail_controller.dart
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../app/routes/app_routes.dart';
import '../models/gift_ideas_detail_models.dart';

/// Static filter options (mirror React).
const String kPriceAll = 'All Prices';
const String kCategoryAll = 'All Gifts';

/// Maps event icon emoji from home to detail screen iconType.
String _iconTypeFromEventIcon(String? eventIcon) {
  if (eventIcon == null || eventIcon.isEmpty) return 'birthday';
  if (eventIcon.contains('🎂') || eventIcon.contains('cake')) return 'birthday';
  if (eventIcon.contains('🌸') || eventIcon.contains('flower')) return 'flower';
  if (eventIcon.contains('🤝') || eventIcon.contains('hand')) return 'handshake';
  return 'gift';
}

/// Controller for event-specific Gift Ideas Detail screen. Mirrors React behavior.
class GiftIdeasDetailController extends GetxController {
  final RxString selectedPriceRange = kPriceAll.obs;
  final RxString selectedCategory = kCategoryAll.obs;
  final RxList<GiftDetailItem> gifts = <GiftDetailItem>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isRegenerating = false.obs;
  final RxInt regenerationsLeft = 3.obs;
  final Rx<GiftIdeasDetailEvent?> event = Rx<GiftIdeasDetailEvent?>(null);

  /// Saved gift ids (toggle like React).
  final RxSet<String> savedGiftIds = <String>{}.obs;

  static const List<String> priceRanges = [
    kPriceAll,
    '\$0 - \$25',
    '\$25 - \$50',
    '\$50 - \$100',
    '\$100 - \$250',
    '\$250+',
  ];

  static const List<String> categories = [
    kCategoryAll,
    'Experiences',
    'Personalized',
    'Subscription',
    'Luxury',
    'Handmade',
  ];

  String? _eventId;

  @override
  void onInit() {
    super.onInit();
    applyArguments(Get.arguments as Map<String, dynamic>?);
  }

  /// Call when screen is shown so args from Home (or others) are applied. Safe to call multiple times.
  void applyArguments(Map<String, dynamic>? args) {
    _eventId = args?['eventId']?.toString();
    final lovedOneName = args?['lovedOneName'] as String?;
    final eventType = args?['eventType'] as String?;
    final eventDate = args?['eventDate'] as String?;
    final daysUntil = args?['daysUntil'];
    final eventIcon = args?['eventIcon'] as String?;
    if (lovedOneName != null && eventType != null) {
      final days = daysUntil is int ? daysUntil : (int.tryParse(daysUntil?.toString() ?? '0') ?? 0);
      event.value = GiftIdeasDetailEvent(
        id: _eventId ?? '0',
        lovedOneName: lovedOneName,
        eventType: eventType,
        eventDate: eventDate ?? '',
        daysUntil: days,
        iconType: _iconTypeFromEventIcon(eventIcon),
      );
    } else {
      event.value = _getEventById(_eventId ?? '1');
    }
    loadEventAndGifts();
  }

  void loadEventAndGifts() {
    isLoading.value = true;
    _eventId ??= Get.parameters['eventId'];
    final id = _eventId ?? '1';
    if (event.value == null) {
      event.value = _getEventById(id);
    }
    final allGifts = _getGiftIdeasForEvent(id);
    gifts.value = _applyFilters(allGifts);
    isLoading.value = false;
  }

  GiftIdeasDetailEvent? _getEventById(String? eventId) {
    if (eventId == null) return null;
    const events = [
      GiftIdeasDetailEvent(
        id: '1',
        lovedOneName: 'Sarah',
        eventType: 'Birthday',
        eventDate: 'January 23, 2026',
        daysUntil: 6,
        iconType: 'birthday',
      ),
      GiftIdeasDetailEvent(
        id: '2',
        lovedOneName: "Mom",
        eventType: "Mother's Day",
        eventDate: 'May 11, 2026',
        daysUntil: 114,
        iconType: 'flower',
      ),
      GiftIdeasDetailEvent(
        id: '3',
        lovedOneName: 'Jake',
        eventType: 'Friendship Anniversary',
        eventDate: 'March 20, 2026',
        daysUntil: 57,
        iconType: 'handshake',
      ),
      GiftIdeasDetailEvent(
        id: '4',
        lovedOneName: 'Dad',
        eventType: "Father's Day",
        eventDate: 'June 21, 2026',
        daysUntil: 149,
        iconType: 'gift',
      ),
    ];
    final found = events.where((e) => e.id == eventId).toList();
    if (found.isNotEmpty) {
      return found.first;
    }
    return events.isNotEmpty ? events.first : null;
  }

  /// Sample gift ideas matching the Gift Ideas detail UI (same 3 for all events when no backend).
  static const List<GiftDetailItem> sampleGifts = [
    GiftDetailItem(
      id: 'g1',
      title: 'Personalized Photo Album',
      description:
          'A beautifully crafted photo album with your favorite moments together. Premium leather cover with custom embossing.',
      priceRange: '\$45 - \$85',
      priceMin: 45,
      priceMax: 85,
      category: 'Personalized',
      whyPerfect:
          "Sarah loves looking back at old memories and cherishes thoughtful, personal gifts.",
      emoji: '❤️',
      iconType: 'camera',
    ),
    GiftDetailItem(
      id: 'g2',
      title: 'Artisan Coffee Subscription',
      description:
          'Monthly delivery of specialty coffees from around the world. Includes tasting notes and brewing tips.',
      priceRange: '\$12 - \$18/month',
      priceMin: 12,
      priceMax: 18,
      category: 'Subscription',
      whyPerfect:
          "She mentioned loving that new cafe on Main Street and trying different coffee blends.",
      emoji: '✨',
      iconType: 'coffee',
    ),
    GiftDetailItem(
      id: 'g3',
      title: 'Weekend Spa Getaway',
      description:
          'A relaxing weekend at a luxury spa resort. Includes massage, facials, and gourmet dining.',
      priceRange: '\$250 - \$500',
      priceMin: 250,
      priceMax: 500,
      category: 'Experiences',
      whyPerfect:
          "Sarah has been working hard and mentioned needing some relaxation time.",
      emoji: '✨',
      iconType: 'spa',
    ),
  ];

  List<GiftDetailItem> _getGiftIdeasForEvent(String eventId) {
    return List<GiftDetailItem>.from(sampleGifts);
  }

  List<GiftDetailItem> _applyFilters(List<GiftDetailItem> list) {
    var out = list;
    if (selectedCategory.value != kCategoryAll) {
      out = out.where((g) => g.category == selectedCategory.value).toList();
    }
    if (selectedPriceRange.value != kPriceAll) {
      final range = selectedPriceRange.value;
      if (range == '\$0 - \$25') {
        out = out.where((g) => g.priceMax <= 25).toList();
      } else if (range == '\$25 - \$50') {
        out = out.where((g) => g.priceMin >= 25 && g.priceMax <= 50).toList();
      } else if (range == '\$50 - \$100') {
        out = out.where((g) => g.priceMin >= 50 && g.priceMax <= 100).toList();
      } else if (range == '\$100 - \$250') {
        out = out.where((g) => g.priceMin >= 100 && g.priceMax <= 250).toList();
      } else if (range == '\$250+') {
        out = out.where((g) => g.priceMin >= 250).toList();
      }
    }
    return out;
  }

  void _refreshFilteredGifts() {
    final id = _eventId ?? '1';
    final all = _getGiftIdeasForEvent(id);
    gifts.value = _applyFilters(all);
  }

  void onBack() {
    Get.back();
  }

  void onSelectPriceRange(String value) {
    selectedPriceRange.value = value;
    _refreshFilteredGifts();
  }

  void onSelectCategory(String value) {
    selectedCategory.value = value;
    _refreshFilteredGifts();
  }

  void onFindNearYou(String giftId) {
    final item = gifts.firstWhereOrNull((g) => g.id == giftId);
    final ev = event.value;
    Get.toNamed(
      AppRoutes.businessSuggestions,
      arguments: {
        'giftTitle': item?.title ?? 'Gift',
        'lovedOneName': ev?.lovedOneName ?? '',
        'eventTitle': ev?.eventType ?? '',
        'category': item?.category ?? '',
        'priceRange': item?.priceRange ?? '',
        'source': 'gift_ideas_detail',
      },
    );
  }

  void onSaveGift(String giftId) {
    if (savedGiftIds.contains(giftId)) {
      savedGiftIds.remove(giftId);
    } else {
      savedGiftIds.add(giftId);
    }
  }

  void onShareGift(String giftId) {
    final item = gifts.firstWhereOrNull((g) => g.id == giftId);
    if (item == null) return;
    Share.share(
      '${item.title}\n\n${item.description}\n\nWhy it\'s perfect: ${item.whyPerfect}',
      subject: item.title,
    );
  }

  void onVisitGift(String giftId) {
    final item = gifts.firstWhereOrNull((g) => g.id == giftId);
    final url = item?.vendorUrl;
    if (url != null && url.isNotEmpty) {
      // TODO: url_launcher when integrated.
    } else {
      Get.snackbar('Visit', 'Link not available for this gift yet.');
    }
  }

  void onRegenerateAll() {
    if (regenerationsLeft.value <= 0 || isRegenerating.value) return;
    isRegenerating.value = true;
    regenerationsLeft.value = regenerationsLeft.value - 1;
    loadEventAndGifts();
    isRegenerating.value = false;
  }

  void onViewGiftHistory() {
    Get.toNamed(AppRoutes.allGiftIdeas);
  }

  bool isSaved(String giftId) => savedGiftIds.contains(giftId);
}
