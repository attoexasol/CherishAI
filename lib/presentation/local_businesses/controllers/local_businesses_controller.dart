// lib/presentation/local_businesses/controllers/local_businesses_controller.dart
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/routes/app_routes.dart';
import '../models/local_business_item.dart';

/// Controller for Local Businesses screen (from Gift Ideas "Find Near You").
class LocalBusinessesController extends GetxController {
  final RxString giftTitle = ''.obs;
  final RxString lovedOneName = ''.obs;
  final RxString eventTitle = ''.obs;
  final RxString category = ''.obs;
  final RxString priceRange = ''.obs;
  final RxList<LocalBusinessItem> businesses = <LocalBusinessItem>[].obs;
  final RxSet<String> favoriteIds = <String>{}.obs;
  /// Business id whose "Connect with us" social card is expanded, or null.
  final Rx<String?> expandedSocialBusinessId = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    applyArguments(Get.arguments as Map<String, dynamic>?);
  }

  /// Call when screen is shown so args from Find Near You are applied.
  void applyArguments(Map<String, dynamic>? args) {
    giftTitle.value = args?['giftTitle'] as String? ?? 'Gift';
    lovedOneName.value = args?['lovedOneName'] as String? ?? '';
    eventTitle.value = args?['eventTitle'] as String? ?? '';
    category.value = args?['category'] as String? ?? '';
    priceRange.value = args?['priceRange'] as String? ?? '';
    businesses.value = _mockBusinesses();
  }

  List<LocalBusinessItem> _mockBusinesses() {
    const socialLinks1 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@serenitysparesort', url: 'https://instagram.com/serenitysparesort'),
      SocialLink(platform: 'Facebook', label: 'FACEBOOK', value: 'SerenitySpaResort', url: 'https://facebook.com/SerenitySpaResort'),
      SocialLink(platform: 'WhatsApp', label: 'WHATSAPP', value: '+1-555-123-4567', url: 'https://wa.me/15551234567'),
      SocialLink(platform: 'Telegram', label: 'TELEGRAM', value: '@serenityspa', url: 'https://t.me/serenityspa'),
      SocialLink(platform: 'TikTok', label: 'TIKTOK', value: '@serenityspa', url: 'https://www.tiktok.com/@serenityspa'),
    ];
    const socialLinks2 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@blissfulretreat', url: 'https://instagram.com/blissfulretreat'),
      SocialLink(platform: 'Facebook', label: 'FACEBOOK', value: 'BlissfulRetreat', url: 'https://facebook.com/BlissfulRetreat'),
      SocialLink(platform: 'WhatsApp', label: 'WHATSAPP', value: '+1-555-890-1234', url: 'https://wa.me/15558901234'),
      SocialLink(platform: 'Telegram', label: 'TELEGRAM', value: '@blissfulretreat', url: 'https://t.me/blissfulretreat'),
      SocialLink(platform: 'TikTok', label: 'TIKTOK', value: '@blissfulretreat', url: 'https://www.tiktok.com/@blissfulretreat'),
    ];
    const socialLinks3 = [
      SocialLink(platform: 'Instagram', label: 'INSTAGRAM', value: '@rejuvenatewellness', url: 'https://instagram.com/rejuvenatewellness'),
      SocialLink(platform: 'Facebook', label: 'FACEBOOK', value: 'RejuvenateWellnessSpa', url: 'https://facebook.com/RejuvenateWellnessSpa'),
      SocialLink(platform: 'WhatsApp', label: 'WHATSAPP', value: '+1-555-555-1234', url: 'https://wa.me/15555551234'),
      SocialLink(platform: 'Telegram', label: 'TELEGRAM', value: '@rejuvenatespa', url: 'https://t.me/rejuvenatespa'),
      SocialLink(platform: 'TikTok', label: 'TIKTOK', value: '@rejuvenatespa', url: 'https://www.tiktok.com/@rejuvenatespa'),
    ];
    return [
      const LocalBusinessItem(
        id: 'b1',
        name: 'Serenity Spa Resort',
        type: 'Luxury Spa & Wellness',
        rating: 5.0,
        reviewCount: 567,
        distance: '12 mi',
        specialty: 'Weekend packages with couples massage',
        address: '111 Tranquil Way, Resort Area',
        hours: 'Open 24 hours',
        phoneNumber: '+1-555-123-4567',
        websiteUrl: 'https://serenitysparesort.example.com',
        addressLine: '111 Tranquil Way',
        city: 'Resort Area',
        stateOrCountry: 'CA, USA',
        mapUrl: 'https://www.google.com/maps/search/?api=1&query=111+Tranquil+Way%2C+Resort+Area',
        priceLevel: 5,
        socialLinks: socialLinks1,
      ),
      const LocalBusinessItem(
        id: 'b2',
        name: 'Blissful Retreat',
        type: 'Day Spa & Resort',
        rating: 4.9,
        reviewCount: 423,
        distance: '15 mi',
        specialty: 'All-inclusive spa weekend getaways',
        address: '222 Harmony Lane, Countryside',
        hours: '8:00 AM - 10:00 PM',
        phoneNumber: '+1-555-890-7654',
        websiteUrl: 'https://blissfulretreat.example.com',
        addressLine: '222 Harmony Lane',
        city: 'Countryside',
        stateOrCountry: 'NY, USA',
        mapUrl: 'https://www.google.com/maps/search/?api=1&query=222+Harmony+Lane%2C+Countryside',
        priceLevel: 4,
        socialLinks: socialLinks2,
      ),
      const LocalBusinessItem(
        id: 'b3',
        name: 'Rejuvenate Wellness Spa',
        type: 'Holistic Spa Center',
        rating: 4.8,
        reviewCount: 391,
        distance: '18 mi',
        specialty: 'Customized spa packages with yoga',
        address: '333 Zen Circle, Mountain View',
        hours: '9:00 AM - 9:00 PM',
        phoneNumber: '+1-555-555-1234',
        websiteUrl: 'https://rejuvenatewellness.example.com',
        addressLine: '333 Zen Circle',
        city: 'Mountain View',
        stateOrCountry: 'CA, USA',
        mapUrl: 'https://www.google.com/maps/search/?api=1&query=333+Zen+Circle%2C+Mountain+View',
        priceLevel: 4,
        socialLinks: socialLinks3,
      ),
    ];
  }

  String get offeringSubtitle => giftTitle.value.isEmpty ? 'Offering gifts' : 'Offering $giftTitle';

  int get businessCount => businesses.length;

  bool isFavorite(String id) => favoriteIds.contains(id);

  void toggleFavorite(String id) {
    if (favoriteIds.contains(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }
  }

  void onBack() {
    Get.back();
  }

  void onDiscover() {
    Get.toNamed(AppRoutes.localBusinessesDiscover);
  }

  void onTapTel(LocalBusinessItem b) {
    final raw = b.phoneNumber?.trim();
    if (raw == null || raw.isEmpty) {
      Get.snackbar('Tel', 'Phone number not available.');
      return;
    }
    final telUri = Uri.parse('tel:${raw.replaceAll(RegExp(r'[^\d+]'), '')}');
    _launchUrl(telUri, onFail: () => Get.snackbar('Tel', 'Unable to open phone dialer'));
  }

  void onTapWebsite(LocalBusinessItem b) {
    final url = b.websiteUrl?.trim();
    if (url == null || url.isEmpty) {
      Get.snackbar('Website', 'Website not available.');
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      Get.snackbar('Website', 'Unable to open website');
      return;
    }
    _launchUrl(uri, mode: LaunchMode.externalApplication, onFail: () => Get.snackbar('Website', 'Unable to open website'));
  }

  void onTapLocation(LocalBusinessItem b) {
    String? mapUrl = b.mapUrl?.trim();
    if (mapUrl == null || mapUrl.isEmpty) {
      final addr = [b.addressLine, b.city, b.stateOrCountry, b.address].where((e) => e != null && e.toString().isNotEmpty).join(', ');
      if (addr.isEmpty) {
        Get.snackbar('Location', 'Address not available.');
        return;
      }
      mapUrl = 'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(addr)}';
    }
    final uri = Uri.tryParse(mapUrl);
    if (uri == null) {
      Get.snackbar('Location', 'Unable to open maps');
      return;
    }
    _launchUrl(uri, mode: LaunchMode.externalApplication, onFail: () => Get.snackbar('Location', 'Unable to open maps'));
  }

  Future<void> _launchUrl(Uri uri, {LaunchMode? mode, void Function()? onFail}) async {
    try {
      final launched = mode != null
          ? await launchUrl(uri, mode: mode)
          : await launchUrl(uri);
      if (!launched && onFail != null) onFail();
    } catch (_) {
      onFail?.call();
    }
  }

  void onTapSocialLink(SocialLink link) {
    final url = link.url.trim();
    if (url.isEmpty) {
      Get.snackbar('Social', 'Unable to open social link');
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      Get.snackbar('Social', 'Unable to open social link');
      return;
    }
    _launchUrl(uri, mode: LaunchMode.externalApplication, onFail: () => Get.snackbar('Social', 'Unable to open social link'));
  }

  void onTapSocial(LocalBusinessItem b) {
    if (expandedSocialBusinessId.value == b.id) {
      expandedSocialBusinessId.value = null;
    } else {
      expandedSocialBusinessId.value = b.id;
    }
  }

  void closeSocialExpanded() {
    expandedSocialBusinessId.value = null;
  }
}
