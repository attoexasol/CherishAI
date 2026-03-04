// lib/presentation/business_onboarding/products_services/models/business_location_model.dart

/// Data collected from the Add Business Location dialog.
class BusinessLocationModel {
  const BusinessLocationModel({
    required this.locationName,
    required this.country,
    required this.city,
    required this.postalCode,
    this.stateRegion = '',
    this.streetAddress = '',
    required this.contactPerson,
    this.email = '',
    this.tel = '',
    required this.category,
    this.description = '',
    required this.priceRangeValue,
    this.operatingHours = '',
    required this.deliveryTypes,
    this.logoPath,
  });

  final String locationName;
  final String country;
  final String city;
  final String postalCode;
  final String stateRegion;
  final String streetAddress;
  final String contactPerson;
  final String email;
  final String tel;
  final String category;
  final String description;
  final double priceRangeValue;
  final String operatingHours;
  final List<String> deliveryTypes;
  final String? logoPath;
}
