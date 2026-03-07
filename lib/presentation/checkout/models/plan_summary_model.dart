// lib/presentation/checkout/models/plan_summary_model.dart

/// Minimal plan data passed from Choose Plan to Checkout (matches React location.state.plan).
class PlanSummaryModel {
  const PlanSummaryModel({
    required this.id,
    required this.name,
    required this.priceDisplay,
    required this.period,
    this.tagline,
    this.isTrialActive = false,
    this.planPrice,
  });

  final String id;
  final String name;
  /// e.g. "\$9", "\$16", "\$26" - or "\$0" when trial is active
  final String priceDisplay;
  /// e.g. "month"
  final String period;
  final String? tagline;
  /// Whether the 4-day free trial is active
  final bool isTrialActive;
  /// Original plan price (e.g. "\$9", "\$16", "\$26") for "Then $X/month" display
  final String? planPrice;

  /// "/ month" for UI
  String get periodSlash => '/ $period';
  /// "\$26/month" for line item - shows plan price when trial is active
  String get pricePerPeriod {
    if (isTrialActive && planPrice != null) {
      return '$planPrice/$period';
    }
    return '$priceDisplay/$period';
  }
  
  /// Get the price to display in the header (e.g. "\$0 today" or "\$16 / month")
  String get headerPriceDisplay {
    if (isTrialActive) {
      return '\$0 today';
    }
    return priceDisplay;
  }
  
  /// Get the "Then $X/month" text for trial display
  String? get thenPriceText {
    if (isTrialActive && planPrice != null) {
      return 'Then $planPrice/month after trial';
    }
    return null;
  }
}
