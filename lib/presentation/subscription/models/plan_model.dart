// lib/presentation/subscription/models/plan_model.dart

/// Single include line: main text and optional detail line below.
class PlanIncludeItem {
  const PlanIncludeItem(this.text, {this.detail});
  final String text;
  final String? detail;
}

/// Plan display model for Choose your plan screen.
class PlanModel {
  const PlanModel({
    required this.id,
    required this.name,
    this.subtitle,
    required this.price,
    required this.period,
    required this.includes,
    required this.bestFor,
    this.isRecommended = false,
    required this.ctaDisplayName,
  });

  final String id;
  final String name;
  final String? subtitle;
  final String price;
  final String period;
  final List<PlanIncludeItem> includes;
  final String bestFor;
  final bool isRecommended;
  /// Short name for bottom CTA, e.g. "Essential", "Plus".
  final String ctaDisplayName;
}

/// Static plan list matching React subscription screen.
abstract class PlansData {
  static const essential = PlanModel(
    id: 'essential',
    name: 'Cherish Essential',
    subtitle: 'For one relationship',
    price: '\$9',
    period: '/ month',
    includes: [
      PlanIncludeItem('You add one loved one/relationship'),
      PlanIncludeItem(
        'Daily personalized messages & inspirations',
        detail:
            'Thoughtful words and ideas you can send directly, or naturally mention in conversation to show care in a personal and intentional way!',
      ),
    ],
    bestFor: 'One meaningful relationship - romantic, family, friendship or professional',
    isRecommended: false,
    ctaDisplayName: 'Essential',
  );

  static const plus = PlanModel(
    id: 'plus',
    name: 'Cherish Plus',
    subtitle: null,
    price: '\$16',
    period: '/ month',
    includes: [
      PlanIncludeItem('Includes everything in Cherish Essential, plus:'),
      PlanIncludeItem('Up to 6 loved ones'),
      PlanIncludeItem('Unlimited important dates'),
      PlanIncludeItem(
        'Push notification',
        detail: 'Gentle reminders and inspirations at the right moments!',
      ),
      PlanIncludeItem('Independent goals and preferences per loved one'),
    ],
    bestFor: 'Partners, families, close friends, or users balancing multiple relationships',
    isRecommended: true,
    ctaDisplayName: 'Plus',
  );

  static const unlimited = PlanModel(
    id: 'unlimited',
    name: 'Cherish Unlimited',
    subtitle: null,
    price: '\$26',
    period: '/ month',
    includes: [
      PlanIncludeItem('Includes everything in Cherish Plus, plus:'),
      PlanIncludeItem('Unlimited loved ones'),
      PlanIncludeItem('Deeper long-term personalization across all relationships'),
      PlanIncludeItem('Relationship insights over time'),
      PlanIncludeItem('Early access to new features'),
    ],
    bestFor: 'Large families, highly social users, or anyone who wants Cherish AI fully integrated into daily life.',
    isRecommended: false,
    ctaDisplayName: 'Unlimited',
  );

  static const List<PlanModel> plans = [essential, plus, unlimited];
}
