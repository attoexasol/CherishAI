// lib/presentation/dislikes/models/dislike_category_model.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';


class DislikeItem {
  const DislikeItem({required this.id, required this.label});
  final String id;
  final String label;
}

class DislikeCategoryModel {
  const DislikeCategoryModel({
    required this.key,
    required this.title,
    required this.backgroundColor,
    required this.items,
  });
  final String key;
  final String title;
  final Color backgroundColor;
  final List<DislikeItem> items;
}

abstract class DislikeCategoriesData {
  static const List<DislikeCategoryModel> categories = [
    DislikeCategoryModel(
      key: 'gift_material',
      title: 'Gift & Material Preferences',
      backgroundColor: AppColors.dislikesCardGift,
      items: [
        DislikeItem(id: 'generic_gifts', label: 'Generic gifts'),
        DislikeItem(id: 'expensive_gifts', label: 'Expensive gifts'),
        DislikeItem(id: 'cheap_looking', label: 'Cheap-looking items'),
        DislikeItem(id: 'practical_gifts', label: 'Practical gifts'),
        DislikeItem(id: 'overly_romantic', label: 'Overly romantic gestures'),
        DislikeItem(id: 'flashy_showy', label: 'Flashy or showy items'),
      ],
    ),
    DislikeCategoryModel(
      key: 'food_lifestyle',
      title: 'Food & Lifestyle',
      backgroundColor: AppColors.dislikesCardFood,
      items: [
        DislikeItem(id: 'sweets_desserts', label: 'Sweets & desserts'),
        DislikeItem(id: 'alcohol', label: 'Alcohol'),
        DislikeItem(id: 'coffee', label: 'Coffee'),
        DislikeItem(id: 'spicy_food', label: 'Spicy food'),
        DislikeItem(id: 'dining_out', label: 'Dining out'),
        DislikeItem(id: 'late_night', label: 'Late-night activities'),
      ],
    ),
    DislikeCategoryModel(
      key: 'experiences_social',
      title: 'Experiences & Social',
      backgroundColor: AppColors.dislikesCardExperiences,
      items: [
        DislikeItem(id: 'crowded_places', label: 'Crowded places'),
        DislikeItem(id: 'small_talk', label: 'Small talk'),
        DislikeItem(id: 'formal_events', label: 'Formal events'),
        DislikeItem(id: 'surprise_parties', label: 'Surprise parties'),
        DislikeItem(id: 'public_attention', label: 'Public attention'),
      ],
    ),
    DislikeCategoryModel(
      key: 'wellness_personality',
      title: 'Wellness & Personality',
      backgroundColor: AppColors.dislikesCardWellness,
      items: [
        DislikeItem(id: 'high_intensity', label: 'High-intensity activities'),
        DislikeItem(id: 'structured_schedules', label: 'Structured schedules'),
        DislikeItem(id: 'tech_heavy', label: 'Technology-heavy experiences'),
        DislikeItem(id: 'minimal_planning', label: 'Minimal planning'),
      ],
    ),
  ];
}
