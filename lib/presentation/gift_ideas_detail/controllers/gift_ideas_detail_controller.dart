// lib/presentation/gift_ideas_detail/controllers/gift_ideas_detail_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../models/gift_ideas_detail_models.dart';

/// Static filter options (mirror React).
const String kPriceAll = 'All Prices';
const String kCategoryAll = 'All Gifts';

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
    final args = Get.arguments as Map<String, dynamic>?;
    _eventId = args?['eventId']?.toString();
    loadEventAndGifts();
  }

  void loadEventAndGifts() {
    isLoading.value = true;
    _eventId ??= Get.parameters['eventId'];
    final id = _eventId ?? '1';
    event.value = _getEventById(id);
    final allGifts = _getGiftIdeasForEvent(id);
    gifts.value = _applyFilters(allGifts);
    isLoading.value = false;
  }

  GiftIdeasDetailEvent? _getEventById(String eventId) {
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
    return events.where((e) => e.id == eventId).firstOrNull ??
        events.first;
  }

  List<GiftDetailItem> _getGiftIdeasForEvent(String eventId) {
    const sarahGifts = [
      GiftDetailItem(
        id: 'g1',
        title: 'Perfect Gift Ideas',
        description:
            'Premium leather cover with custom embossing. Holds 200+ photos with acid-free pages.',
        priceRange: '\$40 - \$80',
        priceMin: 40,
        priceMax: 80,
        category: 'Personalized',
        whyPerfect:
            "Sarah loves photographs and cherishes memories from your travels together.",
        emoji: '❤️',
        iconType: 'camera',
      ),
      GiftDetailItem(
        id: 'g2',
        title: 'Artisan Coffee Subscription',
        description:
            'Monthly delivery of specialty coffee from around the world. Includes tasting notes and brewing tips.',
        priceRange: '\$25 - \$40/month',
        priceMin: 25,
        priceMax: 40,
        category: 'Subscription',
        whyPerfect:
            "She mentioned loving her own café on Main Street and trying different coffee blends.",
        emoji: '✨',
        iconType: 'coffee',
      ),
      GiftDetailItem(
        id: 'g3',
        title: 'Weekend Spa Getaway',
        description:
            'A relaxing weekend at a luxury spa resort, includes massage, facials, and gourmet dining.',
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
    if (eventId == '1') return List.from(sarahGifts);
    if (eventId == '2') {
      return [
        const GiftDetailItem(
          id: 'm1',
          title: 'Floral Bouquet Subscription',
          description: 'Monthly fresh flowers delivered.',
          priceRange: '\$30 - \$60/month',
          priceMin: 30,
          priceMax: 60,
          category: 'Subscription',
          whyPerfect: "Mom loves fresh flowers in the house.",
          iconType: 'flower',
        ),
        ...sarahGifts.take(2),
      ];
    }
    return List.from(sarahGifts);
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
    Get.toNamed(
      AppRoutes.businessSuggestions,
      arguments: {'giftId': giftId},
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
    // Mirror React: navigator.share when available; fallback copy/link.
    // Flutter: use Share.share from share_plus if added, else no-op or copy.
    // Per rules: no new packages unless needed; keep behavior same → no-op for now.
  }

  void onVisitGift(String giftId) {
    final item = gifts.firstWhereOrNull((g) => g.id == giftId);
    final url = item?.vendorUrl;
    if (url != null && url.isNotEmpty) {
      // Launch URL: url_launcher if in project; else no-op.
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
