// lib/presentation/checkout/models/plan_summary_model.dart

/// Minimal plan data passed from Choose Plan to Checkout (matches React location.state.plan).
class PlanSummaryModel {
  const PlanSummaryModel({
    required this.id,
    required this.name,
    required this.priceDisplay,
    required this.period,
    this.tagline,
  });

  final String id;
  final String name;
  /// e.g. "\$9", "\$16", "\$26"
  final String priceDisplay;
  /// e.g. "month"
  final String period;
  final String? tagline;

  /// "/ month" for UI
  String get periodSlash => '/ $period';
  /// "\$26/month" for line item
  String get pricePerPeriod => '$priceDisplay/$period';
}
