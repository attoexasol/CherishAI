// lib/presentation/business_onboarding/products_services/constants/business_category_options.dart
// Re-exports shared master list and adds backward-compat mapping for product category.

import '../../../../core/constants/business_service_categories.dart';

/// Same as [kBusinessServiceCategories]. Use for Business Location (multi-select) and Product (single-select).
const List<Map<String, String>> businessLocationCategoryOptions = kBusinessServiceCategories;

/// Maps legacy product category values to new master list value. Non-destructive: if no mapping, returns [oldValue].
String mapLegacyProductCategoryToNew(String? oldValue) {
  if (oldValue == null || oldValue.isEmpty) return oldValue ?? '';
  switch (oldValue) {
    case 'gifts': return 'gifts_surprises';
    case 'food': return 'food_dining';
    case 'wellness': return 'wellness_self_care';
    case 'entertainment': return 'entertainment_fun';
    case 'fashion': return 'fashion_style';
    case 'home': return 'home_lifestyle';
    case 'travel': return 'travel_experiences';
    case 'memories': return 'memories_keepsakes';
    case 'family': return 'family_kids';
    case 'learning': return 'growth_learning';
    default: return oldValue;
  }
}
