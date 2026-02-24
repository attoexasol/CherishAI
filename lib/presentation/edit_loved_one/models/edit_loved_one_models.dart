// lib/presentation/edit_loved_one/models/edit_loved_one_models.dart
import '../../onboarding/controllers/individual_step4_secondary_goals_controller.dart';

class CustomDateEntry {
  const CustomDateEntry({required this.id, required this.occasion, required this.date});
  final String id;
  final String occasion;
  final String date;
}

class RelationshipOption {
  const RelationshipOption({this.category, required this.value});
  final String? category;
  final String value;
}

class SecondaryGoalItemDisplay {
  const SecondaryGoalItemDisplay({required this.id, required this.label, required this.categoryTitle});
  final String id;
  final String label;
  final String categoryTitle;
}

abstract class EditLovedOneData {
  static const List<RelationshipOption> relationshipOptions = [
    RelationshipOption(category: 'Romantic / Intimate', value: 'Partner (dating / committed, not married)'),
    RelationshipOption(category: 'Romantic / Intimate', value: 'Spouse (married partner)'),
    RelationshipOption(category: 'Romantic / Intimate', value: 'Crush / Romantic interest'),
    RelationshipOption(category: 'Family', value: 'Parent'),
    RelationshipOption(category: 'Family', value: 'Child'),
    RelationshipOption(category: 'Family', value: 'Sibling'),
    RelationshipOption(category: 'Family', value: 'Extended family'),
    RelationshipOption(category: 'Social', value: 'Friend'),
    RelationshipOption(category: 'Social', value: 'Close friend / Best friend'),
    RelationshipOption(category: 'Professional', value: 'Colleague'),
    RelationshipOption(category: 'Professional', value: 'Mentor'),
    RelationshipOption(category: 'Professional', value: 'Mentee'),
  ];

  static List<SecondaryGoalOption> get secondaryGoalsFlat {
    final list = <SecondaryGoalOption>[];
    for (final cat in SecondaryGoalsData.categories) {
      for (final opt in cat.options) {
        list.add(opt);
      }
    }
    return list;
  }

  static List<SecondaryGoalItemDisplay> get secondaryGoalsWithCategory {
    final list = <SecondaryGoalItemDisplay>[];
    for (final cat in SecondaryGoalsData.categories) {
      for (final opt in cat.options) {
        list.add(SecondaryGoalItemDisplay(id: opt.id, label: opt.label, categoryTitle: cat.title));
      }
    }
    return list;
  }
}
