// lib/presentation/all_gift_ideas/controllers/all_gift_ideas_controller.dart
import 'package:get/get.dart';
import '../models/gift_idea_item.dart';

enum SortMode { dateProposed, occasion, lovedOne }

class AllGiftIdeasController extends GetxController {
  final Rx<SortMode> sortMode = SortMode.dateProposed.obs;
  final RxBool isSortPanelOpen = false.obs;
  final RxList<String> expandedGroupKeys = <String>[].obs;

  final RxList<GiftIdeaItem> _allGiftIdeas = <GiftIdeaItem>[].obs;

  List<GiftIdeaItem> get allGiftIdeas => _allGiftIdeas;

  int get totalCount => _allGiftIdeas.length;
  int get savedCount => _allGiftIdeas.where((g) => g.isSaved).length;
  int get lovedOnesCount =>
      _allGiftIdeas.map((g) => g.lovedOneName).toSet().length;

  Map<String, List<GiftIdeaItem>> get organizedGifts {
    final list = _allGiftIdeas;
    if (sortMode.value == SortMode.dateProposed) {
      final sorted = List<GiftIdeaItem>.from(list)
        ..sort((a, b) => _parseDate(b.dateProposed).compareTo(_parseDate(a.dateProposed)));
      final grouped = <String, List<GiftIdeaItem>>{};
      for (final g in sorted) {
        final monthYear = _monthYearFromDate(g.dateProposed);
        grouped.putIfAbsent(monthYear, () => []).add(g);
      }
      return grouped;
    }
    if (sortMode.value == SortMode.occasion) {
      final sorted = List<GiftIdeaItem>.from(list)
        ..sort((a, b) => _parseDate(a.occasionDate).compareTo(_parseDate(b.occasionDate)));
      final grouped = <String, List<GiftIdeaItem>>{};
      for (final g in sorted) {
        final key = '${g.occasion} - ${g.occasionDate}';
        grouped.putIfAbsent(key, () => []).add(g);
      }
      return grouped;
    }
    final grouped = <String, List<GiftIdeaItem>>{};
    for (final g in list) {
      grouped.putIfAbsent(g.lovedOneName, () => []).add(g);
    }
    return grouped;
  }

  static final _monthNames = {
    'January': 1, 'February': 2, 'March': 3, 'April': 4, 'May': 5, 'June': 6,
    'July': 7, 'August': 8, 'September': 9, 'October': 10, 'November': 11, 'December': 12,
  };

  DateTime _parseDate(String s) {
    try {
      final parts = s.replaceAll(',', '').split(' ');
      if (parts.length >= 3) {
        final month = _monthNames[parts[0]] ?? 1;
        final day = int.tryParse(parts[1]) ?? 1;
        final year = int.tryParse(parts[2]) ?? DateTime.now().year;
        return DateTime(year, month, day);
      }
      return DateTime.parse(s);
    } catch (_) {
      return DateTime.now();
    }
  }

  String _monthYearFromDate(String dateStr) {
    final d = _parseDate(dateStr);
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[d.month - 1]} ${d.year}';
  }

  @override
  void onInit() {
    super.onInit();
    loadGiftIdeas();
  }

  void loadGiftIdeas() {
    _allGiftIdeas.assignAll(_mockGiftIdeas());
  }

  List<GiftIdeaItem> _mockGiftIdeas() {
    return [
      GiftIdeaItem(
        id: 1,
        name: 'Custom Star Map',
        description: 'Beautiful constellation map of your special night',
        price: '\$79',
        priceValue: 79,
        category: 'Personalized',
        lovedOneName: 'Sarah',
        lovedOneId: 1,
        occasion: 'Birthday',
        occasionDate: 'January 23, 2026',
        dateProposed: 'January 10, 2026',
        isSaved: true,
        tags: ['romantic', 'personalized', 'wall art'],
      ),
      GiftIdeaItem(
        id: 2,
        name: 'Spa Day Package',
        description: 'Luxury spa experience with massage and facial',
        price: '\$250',
        priceValue: 250,
        category: 'Experience',
        lovedOneName: 'Sarah',
        lovedOneId: 1,
        occasion: 'Birthday',
        occasionDate: 'January 23, 2026',
        dateProposed: 'January 12, 2026',
        isSaved: true,
        tags: ['experience', 'relaxation', 'wellness'],
      ),
      GiftIdeaItem(
        id: 3,
        name: 'Designer Handbag',
        description: 'Elegant leather handbag in her favorite color',
        price: '\$420',
        priceValue: 420,
        category: 'Luxury',
        lovedOneName: 'Sarah',
        lovedOneId: 1,
        occasion: 'Birthday',
        occasionDate: 'January 23, 2026',
        dateProposed: 'January 8, 2026',
        isSaved: false,
        tags: ['fashion', 'luxury', 'accessories'],
      ),
      GiftIdeaItem(
        id: 4,
        name: 'Jewelry Box',
        description: 'Handcrafted wooden jewelry organizer',
        price: '\$95',
        priceValue: 95,
        category: 'Personalized',
        lovedOneName: 'Mom',
        lovedOneId: 2,
        occasion: "Mother's Day",
        occasionDate: 'May 11, 2026',
        dateProposed: 'January 15, 2026',
        isSaved: true,
        tags: ['practical', 'handcrafted', 'storage'],
      ),
      GiftIdeaItem(
        id: 5,
        name: 'Garden Tool Set',
        description: 'Premium gardening tools with personalized engraving',
        price: '\$145',
        priceValue: 145,
        category: 'Practical',
        lovedOneName: 'Mom',
        lovedOneId: 2,
        occasion: "Mother's Day",
        occasionDate: 'May 11, 2026',
        dateProposed: 'January 20, 2026',
        isSaved: false,
        tags: ['hobby', 'outdoor', 'tools'],
      ),
      GiftIdeaItem(
        id: 6,
        name: 'Cooking Class Experience',
        description: 'Italian cooking class for two',
        price: '\$180',
        priceValue: 180,
        category: 'Experience',
        lovedOneName: 'Mom',
        lovedOneId: 2,
        occasion: "Mother's Day",
        occasionDate: 'May 11, 2026',
        dateProposed: 'January 18, 2026',
        isSaved: true,
        tags: ['experience', 'food', 'quality time'],
      ),
      GiftIdeaItem(
        id: 7,
        name: 'Gaming Headset',
        description: 'Wireless gaming headset with noise cancellation',
        price: '\$199',
        priceValue: 199,
        category: 'Tech',
        lovedOneName: 'Jake',
        lovedOneId: 3,
        occasion: 'Friendship Anniversary',
        occasionDate: 'March 15, 2026',
        dateProposed: 'January 22, 2026',
        isSaved: true,
        tags: ['gaming', 'tech', 'audio'],
      ),
      GiftIdeaItem(
        id: 8,
        name: 'Concert Tickets',
        description: 'VIP tickets to his favorite band',
        price: '\$320',
        priceValue: 320,
        category: 'Experience',
        lovedOneName: 'Jake',
        lovedOneId: 3,
        occasion: 'Friendship Anniversary',
        occasionDate: 'March 15, 2026',
        dateProposed: 'January 14, 2026',
        isSaved: false,
        tags: ['experience', 'music', 'entertainment'],
      ),
      GiftIdeaItem(
        id: 9,
        name: 'Smart Watch',
        description: 'Fitness tracker with health monitoring',
        price: '\$299',
        priceValue: 299,
        category: 'Tech',
        lovedOneName: 'Dad',
        lovedOneId: 4,
        occasion: "Father's Day",
        occasionDate: 'June 21, 2026',
        dateProposed: 'January 25, 2026',
        isSaved: true,
        tags: ['tech', 'fitness', 'health'],
      ),
      GiftIdeaItem(
        id: 10,
        name: 'Golf Club Set',
        description: 'Professional grade golf clubs',
        price: '\$850',
        priceValue: 850,
        category: 'Sport',
        lovedOneName: 'Dad',
        lovedOneId: 4,
        occasion: "Father's Day",
        occasionDate: 'June 21, 2026',
        dateProposed: 'January 16, 2026',
        isSaved: false,
        tags: ['sport', 'hobby', 'outdoor'],
      ),
      GiftIdeaItem(
        id: 11,
        name: 'Whiskey Tasting Set',
        description: 'Premium whiskey collection from around the world',
        price: '\$165',
        priceValue: 165,
        category: 'Luxury',
        lovedOneName: 'Dad',
        lovedOneId: 4,
        occasion: "Father's Day",
        occasionDate: 'June 21, 2026',
        dateProposed: 'January 24, 2026',
        isSaved: true,
        tags: ['luxury', 'spirits', 'collection'],
      ),
    ];
  }

  void onBack() => Get.back();

  void toggleSortPanel() {
    isSortPanelOpen.value = !isSortPanelOpen.value;
  }

  void setSortModeAndClose(SortMode mode) {
    sortMode.value = mode;
    isSortPanelOpen.value = false;
    expandedGroupKeys.clear();
  }

  void toggleSection(String key) {
    if (expandedGroupKeys.contains(key)) {
      expandedGroupKeys.remove(key);
    } else {
      expandedGroupKeys.add(key);
    }
  }

  void toggleSaved(int giftId) {
    final idx = _allGiftIdeas.indexWhere((g) => g.id == giftId);
    if (idx < 0) return;
    final g = _allGiftIdeas[idx];
    _allGiftIdeas[idx] = g.copyWith(isSaved: !g.isSaved);
  }
}
