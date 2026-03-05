// lib/core/constants/business_service_categories.dart
// Single source of truth for Product or Services Category options.
// Used by: Business Location (multi-select), Business Information (multi-select), Add Product/Service (single-select).

/// Master category list (16 categories) in exact client order. Use for both
/// business location multi-select and product single-select dropdown.
/// Each map: value (id for storage), label (display), description.
const List<Map<String, String>> kBusinessServiceCategories = [
  {'value': 'gifts_surprises', 'label': 'Gifts & Surprises', 'description': 'Classic love gestures and meaningful tokens'},
  {'value': 'wellness_self_care', 'label': 'Wellness & Self-Care', 'description': 'Services for relaxation, support, and personal wellbeing'},
  {'value': 'entertainment_fun', 'label': 'Entertainment & Fun', 'description': 'Experiences for joy, shared enjoyment, and memorable moments'},
  {'value': 'food_dining', 'label': 'Food & Dining', 'description': 'Meals, cafés, desserts, and culinary experiences'},
  {'value': 'fashion_style', 'label': 'Fashion & Style', 'description': 'Clothing, accessories, personal style gifts'},
  {'value': 'home_lifestyle', 'label': 'Home & Lifestyle', 'description': 'Comfort, décor, ambiance, and personal space items'},
  {'value': 'travel_experiences', 'label': 'Travel & Experiences', 'description': 'Getaways, experiences, and shared adventures'},
  {'value': 'memories_keepsakes', 'label': 'Memories & Keepsakes', 'description': 'Photography, printing, memory preservation, keepsakes'},
  {'value': 'creativity_personal_expression', 'label': 'Creativity & Personal Expression', 'description': 'Art, craft, writing, music, personal expression tools'},
  {'value': 'growth_learning', 'label': 'Growth & Learning', 'description': 'Courses, workshops, skill development, self-growth'},
  {'value': 'family_kids', 'label': 'Family & Kids', 'description': 'Toys, family experiences, parenting support, child-focused gifts'},
  {'value': 'health_fitness', 'label': 'Health & Fitness', 'description': 'Fitness classes, personal training, active wellness services'},
  {'value': 'beauty_grooming', 'label': 'Beauty & Grooming', 'description': 'Salons, spas, skincare, hair services'},
  {'value': 'events_celebrations', 'label': 'Events & Celebrations', 'description': 'Party planning, special event services, decorations'},
  {'value': 'professional_services', 'label': 'Professional Services', 'description': 'Consultation, coaching (non-clinical), personal guidance'},
  {'value': 'digital_experiences', 'label': 'Digital Experiences', 'description': 'Virtual experiences, subscriptions, digital gifts'},
];

/// Labels only (for simple dropdown display). Same order as [kBusinessServiceCategories].
List<String> get kBusinessServiceCategoryTitles =>
    kBusinessServiceCategories.map((e) => e['label']!).toList();
