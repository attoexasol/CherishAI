// lib/presentation/loved_ones/models/loved_one_model.dart

/// One loved one entry for the list. Mirrors React LovedOne interface.
class LovedOneModel {
  const LovedOneModel({
    required this.id,
    required this.name,
    required this.relationship,
    required this.emoji,
  });

  final String id;
  final String name;
  final String relationship;
  final String emoji;
}
