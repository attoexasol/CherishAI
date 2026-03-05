// lib/presentation/local_businesses/controllers/local_businesses_discover_controller.dart
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/discover_business_item.dart';
import '../models/local_business_item.dart';

/// Controller for Local Businesses Discover (listing) screen.
class LocalBusinessesDiscoverController extends GetxController {
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'All Categories'.obs;
  final RxString locationPillText = 'Showing businesses in United States'.obs;
  final RxList<DiscoverBusinessItem> allBusinesses = <DiscoverBusinessItem>[].obs;
  final RxSet<String> favoriteIds = <String>{}.obs;
  final Rx<String?> expandedSocialBusinessId = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    allBusinesses.value = _mockBusinesses();
  }

  List<String> get categories {
    final cats = <String>{};
    for (final b in allBusinesses) {
      cats.add(b.category);
    }
    final list = cats.toList()..sort();
    return ['All Categories', ...list];
  }

  List<DiscoverBusinessItem> get filteredBusinesses {
    var list = allBusinesses.toList();
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((b) {
        return b.name.toLowerCase().contains(q) ||
            b.category.toLowerCase().contains(q) ||
            b.city.toLowerCase().contains(q) ||
            b.description.toLowerCase().contains(q) ||
            b.specialties.any((s) => s.toLowerCase().contains(q));
      }).toList();
    }
    if (selectedCategory.value != 'All Categories') {
      list = list.where((b) => b.category == selectedCategory.value).toList();
    }
    return list;
  }

  int get filteredCount => filteredBusinesses.length;

  List<DiscoverBusinessItem> _mockBusinesses() {
    const List<SocialLink> socials1 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@romanticgestures', url: 'https://instagram.com/romanticgestures'),
      SocialLink(platform: 'Facebook', label: 'FACEBOOK', value: 'RomanticGesturesCo', url: 'https://facebook.com/RomanticGesturesCo'),
      SocialLink(platform: 'WhatsApp', label: 'WHATSAPP', value: '+1-555-111-2222', url: 'https://wa.me/15551112222'),
    ];
    const List<SocialLink> socials2 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@eternalflowers', url: 'https://instagram.com/eternalflowers'),
      SocialLink(platform: 'Facebook', label: 'FACEBOOK', value: 'EternalFlowersStudio', url: 'https://facebook.com/EternalFlowersStudio'),
    ];
    const List<SocialLink> socials3 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@memoriesphotostudio', url: 'https://instagram.com/memoriesphotostudio'),
    ];
    const List<SocialLink> socials4 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@sweetsentiments', url: 'https://instagram.com/sweetsentiments'),
      SocialLink(platform: 'Facebook', label: 'FACEBOOK', value: 'SweetSentimentsBakery', url: 'https://facebook.com/SweetSentimentsBakery'),
    ];
    const List<SocialLink> socials5 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@heartfeltjewelry', url: 'https://instagram.com/heartfeltjewelry'),
    ];
    const List<SocialLink> socials6 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@lovenotesstationery', url: 'https://instagram.com/lovenotesstationery'),
    ];

    return [
      DiscoverBusinessItem(
        id: 'd1',
        name: 'Romantic Gestures Co.',
        logoIcon: 'gift',
        city: 'New York',
        region: 'United States',
        category: 'Gift Planning',
        rating: 4.8,
        reviewCount: 127,
        description: 'Specializing in romantic surprise planning and custom gift experiences for couples.',
        specialties: ['Anniversary Planning', 'Surprise Dates', 'Custom Gifts'],
        phone: 'tel:+15551112222',
        websiteUrl: 'https://example.com',
        locationUrl: 'https://www.google.com/maps/search/?api=1&query=New+York+United+States',
        socialLinks: socials1,
      ),
      DiscoverBusinessItem(
        id: 'd2',
        name: 'Eternal Flowers Studio',
        logoIcon: 'flower',
        city: 'Los Angeles',
        region: 'United States',
        category: 'Flowers & Arrangements',
        rating: 4.9,
        reviewCount: 201,
        description: 'Premium flower arrangements and preserved flowers that last forever.',
        specialties: ['Preserved Roses', 'Luxury Bouquets', 'Same Day Delivery'],
        phone: 'tel:+15552223333',
        websiteUrl: 'https://example.com',
        locationUrl: 'https://www.google.com/maps/search/?api=1&query=Los+Angeles+United+States',
        socialLinks: socials2,
      ),
      DiscoverBusinessItem(
        id: 'd3',
        name: 'Memories Photo Studio',
        logoIcon: 'camera',
        city: 'Chicago',
        region: 'United States',
        category: 'Photography',
        rating: 4.7,
        reviewCount: 79,
        description: 'Professional couple and family photography for your special moments.',
        specialties: ['Couple Shoots', 'Anniversary Sessions', 'Photo Albums'],
        phone: 'tel:+15553334444',
        websiteUrl: 'https://example.com',
        locationUrl: 'https://www.google.com/maps/search/?api=1&query=Chicago+United+States',
        socialLinks: socials3,
      ),
      DiscoverBusinessItem(
        id: 'd4',
        name: 'Sweet Sentiments Bakery',
        logoIcon: 'cake',
        city: 'San Francisco',
        region: 'United States',
        category: 'Bakery & Desserts',
        rating: 4.6,
        reviewCount: 150,
        description: 'Custom cakes and desserts for every special occasion.',
        specialties: ['Custom Cakes', 'Dessert Tables', 'Personalized Treats'],
        phone: 'tel:+15554445555',
        websiteUrl: 'https://example.com',
        locationUrl: 'https://www.google.com/maps/search/?api=1&query=San+Francisco+United+States',
        socialLinks: socials4,
      ),
      DiscoverBusinessItem(
        id: 'd5',
        name: 'Heartfelt Jewelry',
        logoIcon: 'jewelry',
        city: 'Boston',
        region: 'United States',
        category: 'Jewelry & Accessories',
        rating: 4.5,
        reviewCount: 241,
        description: 'Handcrafted jewelry with personalization options for that special someone.',
        specialties: ['Custom Engraving', 'Couple Jewelry', 'Birthstone Pieces'],
        phone: 'tel:+15555556666',
        websiteUrl: 'https://example.com',
        locationUrl: 'https://www.google.com/maps/search/?api=1&query=Boston+United+States',
        socialLinks: socials5,
      ),
      DiscoverBusinessItem(
        id: 'd6',
        name: 'Love Notes Stationery',
        logoIcon: 'stationery',
        city: 'Seattle',
        region: 'United States',
        category: 'Cards & Stationery',
        rating: 4.5,
        reviewCount: 79,
        description: 'Beautiful handmade cards and stationery for expressing your feelings.',
        specialties: ['Custom Cards', 'Love Letters', 'Gift Wrapping'],
        phone: 'tel:+15556667777',
        websiteUrl: 'https://example.com',
        locationUrl: 'https://www.google.com/maps/search/?api=1&query=Seattle+United+States',
        socialLinks: socials6,
      ),
    ];
  }

  void onBack() => Get.back();

  void onDiscover() {
    // Already on discover screen; could refresh or open filters.
  }

  void setSearchQuery(String value) => searchQuery.value = value;

  void setCategory(String value) => selectedCategory.value = value;

  bool isFavorite(String id) => favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
  }

  void toggleSocialExpanded(String? id) {
    if (expandedSocialBusinessId.value == id) {
      expandedSocialBusinessId.value = null;
    } else {
      expandedSocialBusinessId.value = id;
    }
  }

  void closeSocialExpanded() => expandedSocialBusinessId.value = null;

  Future<void> onTapTel(DiscoverBusinessItem b) async {
    final uri = b.phone;
    if (uri == null || uri.isEmpty) {
      Get.snackbar('Tel', 'Phone not available.');
      return;
    }
    try {
      final parsed = Uri.parse(uri);
      if (await canLaunchUrl(parsed)) {
        await launchUrl(parsed, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Tel', 'Could not open dialer.');
      }
    } catch (_) {
      Get.snackbar('Tel', 'Could not open dialer.');
    }
  }

  Future<void> onTapWebsite(DiscoverBusinessItem b) async {
    final url = b.websiteUrl;
    if (url == null || url.isEmpty) {
      Get.snackbar('Website', 'Website not available.');
      return;
    }
    try {
      final uri = url.startsWith('http') ? Uri.parse(url) : Uri.parse('https://$url');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar('Website', 'Could not open link.');
      }
    } catch (_) {
      Get.snackbar('Website', 'Could not open link.');
    }
  }

  Future<void> onTapLocation(DiscoverBusinessItem b) async {
    final url = b.locationUrl;
    if (url != null && url.isNotEmpty) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar('Location', b.locationLine);
        }
      } catch (_) {
        Get.snackbar('Location', b.locationLine);
      }
    } else {
      Get.snackbar('Location', b.locationLine);
    }
  }

  void onTapSocial(DiscoverBusinessItem b) => toggleSocialExpanded(b.id);
}
