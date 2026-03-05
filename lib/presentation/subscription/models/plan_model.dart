// lib/presentation/subscription/models/plan_model.dart

/// Single include line: main text and optional detail line below.
class PlanIncludeItem {
  const PlanIncludeItem(this.text, {this.detail});
  final String text;
  final String? detail;
}

/// Plan display model for Choose your plan screen.
/// Shared source for subscription cards and manage subscription.
class PlanModel {
  const PlanModel({
    required this.id,
    required this.name,
    this.displayTitleEmoji,
    this.subtitle,
    this.description,
    required this.price,
    required this.period,
    required this.includes,
    required this.bestFor,
    this.isRecommended = false,
    required this.ctaDisplayName,
  });

  final String id;
  final String name;
  /// Optional emoji prefix for card title (e.g. "🌟", "✨").
  final String? displayTitleEmoji;
  final String? subtitle;
  /// Header/paragraph under subtitle (e.g. "Everything in Essential, plus :").
  final String? description;
  final String price;
  final String period;
  final List<PlanIncludeItem> includes;
  final String bestFor;
  final bool isRecommended;
  /// Short name for bottom CTA, e.g. "Essential", "Plus".
  final String ctaDisplayName;
}

/// Static plan list – single source for subscription content (Choose Plan + Manage Subscription).
abstract class PlansData {
  static const essential = PlanModel(
    id: 'essential',
    name: 'Cherish Essential',
    displayTitleEmoji: null,
    subtitle: 'Perfect for one relationship',
    description: 'Everything you need to show up thoughtfully and consistently.',
    price: '\$9',
    period: ' / month',
    includes: [
      PlanIncludeItem('One Loved one / Relationship'),
      PlanIncludeItem(
        '💬 Daily personalized messages & inspirations',
        detail: 'Thoughtful ideas you can send directly or naturally use in conversation. And you can regenerate if you want to',
      ),
      PlanIncludeItem(
        '🎯 Relationship-aware personalization',
        detail: 'Messages adapt to tone, goals, and relationship type.',
      ),
      PlanIncludeItem(
        '🎁 Smart gift & experience suggestions',
        detail: 'Intelligently matched to the loved one\'s preferences, occasion, and moment.',
      ),
      PlanIncludeItem(
        '📅 Special-date reminders',
        detail: 'Add special dates / occasions that matter to your relationship. Never miss birthdays, anniversaries, or meaningful milestones.',
      ),
      PlanIncludeItem(
        '🔄 Goal & preference editing anytime',
        detail: 'Relationships evolve. Change relationship type & goals any time and the way you personally care adapts your choice',
      ),
      PlanIncludeItem(
        '🧠 Smart occasion awareness',
        detail: 'Relevant ideas when moments matter most.',
      ),
      PlanIncludeItem(
        '🎨 Browse nearby gifts and experience providers intelligently chosen for your relationship, loved one and occasion when you need them most to express care to your loved ones',
      ),
    ],
    bestFor: 'One romantic relationship (family, friendship, or professional, etc.)',
    isRecommended: false,
    ctaDisplayName: 'Essential',
  );

  static const plus = PlanModel(
    id: 'plus',
    name: 'Cherish Plus',
    displayTitleEmoji: '🌟',
    subtitle: 'For people nurturing multiple important relationships (partners, friends, child, sibling…)',
    description: 'Everything in Essential, plus :',
    price: '\$16',
    period: ' / month',
    includes: [
      PlanIncludeItem('❤️ Up to 6 loved ones'),
      PlanIncludeItem('♾ Unlimited important dates per loved one'),
      PlanIncludeItem('🔔 Gentle push reminders & timely inspirations'),
      PlanIncludeItem('🧩 Independent goals & preferences per loved one'),
      PlanIncludeItem('🎁 thoughful gift suggestions per loved one per occasion'),
      PlanIncludeItem('⏱ Smart reminders before important moments'),
      PlanIncludeItem('🔄 Priority message generation'),
      PlanIncludeItem(
        '🧠 Adaptive tone learning',
        detail: 'Cherish learns how you naturally express care.',
      ),
    ],
    bestFor: 'Partners, families, close friends, or anyone balancing several relationships.',
    isRecommended: true,
    ctaDisplayName: 'Plus',
  );

  static const unlimited = PlanModel(
    id: 'unlimited',
    name: 'Cherish Unlimited',
    displayTitleEmoji: '✨',
    subtitle: 'The full Cherish experience - all relationships supported personally & effortlessly',
    description: 'Everything in Plus, plus :',
    price: '\$26',
    period: ' / month',
    includes: [
      PlanIncludeItem('♾ Unlimited loved ones / Relationship'),
      PlanIncludeItem('💛 Emotional memory & relationship rhythm learning'),
      PlanIncludeItem('📊 Relationship insights over time'),
      PlanIncludeItem('🎯 Advanced personalization across all relationships'),
      PlanIncludeItem('🚀 Early access to new features'),
    ],
    bestFor: 'Large families, highly social users, or anyone who wants Cherish fully integrated into daily life.',
    isRecommended: false,
    ctaDisplayName: 'Unlimited',
  );

  static const List<PlanModel> plans = [essential, plus, unlimited];
}
