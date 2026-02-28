// lib/presentation/all_gift_ideas/models/gift_idea_item.dart

/// Single gift idea item for All Gift Ideas list. Mirrors React GiftIdea.
class GiftIdeaItem {
  const GiftIdeaItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.priceValue,
    required this.category,
    required this.lovedOneName,
    required this.lovedOneId,
    required this.occasion,
    required this.occasionDate,
    required this.dateProposed,
    required this.isSaved,
    this.tags = const [],
  });

  final int id;
  final String name;
  final String description;
  final String price;
  final double priceValue;
  final String category;
  final String lovedOneName;
  final int lovedOneId;
  final String occasion;
  final String occasionDate;
  final String dateProposed;
  final bool isSaved;
  final List<String> tags;

  GiftIdeaItem copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    double? priceValue,
    String? category,
    String? lovedOneName,
    int? lovedOneId,
    String? occasion,
    String? occasionDate,
    String? dateProposed,
    bool? isSaved,
    List<String>? tags,
  }) {
    return GiftIdeaItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      priceValue: priceValue ?? this.priceValue,
      category: category ?? this.category,
      lovedOneName: lovedOneName ?? this.lovedOneName,
      lovedOneId: lovedOneId ?? this.lovedOneId,
      occasion: occasion ?? this.occasion,
      occasionDate: occasionDate ?? this.occasionDate,
      dateProposed: dateProposed ?? this.dateProposed,
      isSaved: isSaved ?? this.isSaved,
      tags: tags ?? this.tags,
    );
  }
}
