// lib/presentation/search/controllers/search_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Search screen state: query, recent searches, trending list, quick access navigation.
/// Mirrors React SearchScreen behavior; no business logic changes.
class SearchController extends GetxController {
  final queryController = TextEditingController();
  final RxString query = ''.obs;
  final RxList<String> recentSearches = <String>[
    'Gift ideas for Sarah',
    'Birthday reminders',
    'Anniversary gifts',
    'Romantic messages',
  ].obs;
  final RxBool isSearching = false.obs;

  static const List<TrendingSearchItem> trendingItems = [
    TrendingSearchItem(id: 1, query: "Valentine's Day gifts", icon: '💝', category: 'Gifts'),
    TrendingSearchItem(id: 2, query: 'Birthday planning', icon: '🎂', category: 'Events'),
    TrendingSearchItem(id: 3, query: 'Romantic messages', icon: '💌', category: 'Messages'),
    TrendingSearchItem(id: 4, query: 'Anniversary ideas', icon: '💕', category: 'Events'),
  ];

  @override
  void onInit() {
    super.onInit();
    queryController.addListener(_onQueryControllerChanged);
  }

  void _onQueryControllerChanged() {
    query.value = queryController.text;
  }

  void onQueryChanged(String value) {
    queryController.text = value;
    queryController.selection = TextSelection.collapsed(offset: value.length);
    query.value = value;
    if (value.trim().isEmpty) {
      return;
    }
    _performSearch();
  }

  void _performSearch() {
    isSearching.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      isSearching.value = false;
    });
  }

  void clearSearch() {
    queryController.clear();
    query.value = '';
  }

  void onTapQuickAccess(String type) {
    switch (type) {
      case 'loved_ones':
        Get.toNamed(AppRoutes.lovedOnesList);
        break;
      case 'gift_ideas':
        Get.toNamed(AppRoutes.giftIdeas);
        break;
      case 'events':
        Get.toNamed(AppRoutes.allUpcomingEvents);
        break;
      case 'old_messages':
        Get.toNamed(AppRoutes.oldMessages);
        break;
      default:
        break;
    }
  }

  void onTapTrending(int itemId) {
    TrendingSearchItem? item;
    for (final e in trendingItems) {
      if (e.id == itemId) {
        item = e;
        break;
      }
    }
    if (item != null) {
      onQueryChanged(item.query);
    }
  }

  void onTapRecentSearch(String value) {
    onQueryChanged(value);
  }

  void onTapBottomNav(String tab) {
    if (tab == 'search') return;
    switch (tab) {
      case 'home':
        Get.offNamed(AppRoutes.home);
        break;
      case 'loved_ones':
        Get.offNamed(AppRoutes.lovedOnesList);
        break;
      case 'alerts':
        Get.offNamed(AppRoutes.notificationsList);
        break;
      case 'profile':
        Get.offNamed(AppRoutes.profile);
        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    queryController.removeListener(_onQueryControllerChanged);
    queryController.dispose();
    super.onClose();
  }
}

/// One trending search row (id, query, icon emoji, category label).
class TrendingSearchItem {
  const TrendingSearchItem({
    required this.id,
    required this.query,
    required this.icon,
    required this.category,
  });
  final int id;
  final String query;
  final String icon;
  final String category;
}
