// lib/presentation/local_businesses/models/local_business_item.dart

/// One social platform link for "Connect with us" card.
/// Icon is derived from platform in UI.
class SocialLink {
  const SocialLink({
    required this.platform,
    required this.label,
    required this.value,
    required this.url,
  });
  final String platform; // 'Instagram', 'Facebook', etc.
  final String label;   // uppercase label
  final String value;   // handle, number, or page name (e.g. @handle)
  final String url;     // deep link or web URL to open when tapped
}

/// One local business card for the Local Businesses screen.
class LocalBusinessItem {
  const LocalBusinessItem({
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    required this.specialty,
    required this.address,
    required this.hours,
    this.phoneNumber,
    this.websiteUrl,
    this.addressLine,
    this.city,
    this.stateOrCountry,
    this.latitude,
    this.longitude,
    this.mapUrl,
    this.socialLinks,
    this.priceLevel = 4, // 1-5 for $ display
  });

  final String id;
  final String name;
  final String type;
  final double rating;
  final int reviewCount;
  final String distance;
  final String specialty;
  final String address;
  final String hours;
  /// E.g. +1-555-123-4567 for display and tel: launch.
  final String? phoneNumber;
  final String? websiteUrl;
  final String? addressLine;
  final String? city;
  final String? stateOrCountry;
  final double? latitude;
  final double? longitude;
  /// Preferred Google Maps URL; fallback from address if null.
  final String? mapUrl;
  /// Links shown in expanded "Connect with us" card (Instagram, Facebook, etc.).
  final List<SocialLink>? socialLinks;
  final int priceLevel;
}
