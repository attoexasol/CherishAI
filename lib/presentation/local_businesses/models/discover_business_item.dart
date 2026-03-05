// lib/presentation/local_businesses/models/discover_business_item.dart
import 'local_business_item.dart';

/// One business card for the Local Businesses Discover (listing) screen.
class DiscoverBusinessItem {
  const DiscoverBusinessItem({
    required this.id,
    required this.name,
    required this.logoIcon,
    required this.city,
    required this.region,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.specialties,
    this.phone,
    this.websiteUrl,
    this.locationUrl,
    this.socialLinks,
  });

  final String id;
  final String name;
  /// Icon/category key for placeholder logo (e.g. 'gift', 'flower', 'camera').
  final String logoIcon;
  final String city;
  final String region;
  final String category;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> specialties;
  final String? phone;
  final String? websiteUrl;
  final String? locationUrl;
  final List<SocialLink>? socialLinks;

  String get locationLine => '$city, $region';
}
