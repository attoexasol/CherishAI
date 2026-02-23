// lib/presentation/loved_one_preferences/models/hobby_category_model.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';


class HobbyChip {
  const HobbyChip({required this.id, required this.label});
  final String id;
  final String label;
}

class HobbyCategoryModel {
  const HobbyCategoryModel({
    required this.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.chips,
  });
  final String key;
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final List<HobbyChip> chips;
}

abstract class HobbyCategoriesData {
  static const List<HobbyCategoryModel> categories = [
    HobbyCategoryModel(
      key: 'creative',
      title: 'Creative & Expressive',
      icon: Icons.brush_outlined,
      backgroundColor: AppColors.prefsCategoryCardCreative,
      chips: [
        HobbyChip(id: 'art', label: 'Art & Illustration'),
        HobbyChip(id: 'photography', label: 'Photography'),
        HobbyChip(id: 'writing', label: 'Writing & Journaling'),
        HobbyChip(id: 'music_listening', label: 'Music (Listening)'),
        HobbyChip(id: 'playing_music', label: 'Playing Music'),
        HobbyChip(id: 'diy', label: 'DIY & Crafts'),
        HobbyChip(id: 'design', label: 'Design & Aesthetics'),
      ],
    ),
    HobbyCategoryModel(
      key: 'food',
      title: 'Food & Lifestyle',
      icon: Icons.restaurant_outlined,
      backgroundColor: AppColors.prefsCategoryCardFood,
      chips: [
        HobbyChip(id: 'cooking', label: 'Cooking'),
        HobbyChip(id: 'baking', label: 'Baking'),
        HobbyChip(id: 'coffee', label: 'Coffee & Cafes'),
        HobbyChip(id: 'wine', label: 'Wine & Cocktails'),
        HobbyChip(id: 'dining_out', label: 'Dining Out'),
        HobbyChip(id: 'food_experiences', label: 'Food Experiences'),
      ],
    ),
    HobbyCategoryModel(
      key: 'experiences',
      title: 'Experiences & Exploration',
      icon: Icons.explore_outlined,
      backgroundColor: AppColors.prefsCategoryCardExperiences,
      chips: [
        HobbyChip(id: 'travel', label: 'Travel'),
        HobbyChip(id: 'road_trips', label: 'Road Trips'),
        HobbyChip(id: 'nature', label: 'Nature & Outdoors'),
        HobbyChip(id: 'hiking', label: 'Hiking'),
        HobbyChip(id: 'camping', label: 'Camping'),
        HobbyChip(id: 'cultural', label: 'Cultural Experiences'),
      ],
    ),
    HobbyCategoryModel(
      key: 'wellness',
      title: 'Wellness & Mindfulness',
      icon: Icons.self_improvement_outlined,
      backgroundColor: AppColors.prefsCategoryCardWellness,
      chips: [
        HobbyChip(id: 'fitness', label: 'Fitness & Gym'),
        HobbyChip(id: 'yoga', label: 'Yoga & Pilates'),
        HobbyChip(id: 'meditation', label: 'Meditation & Mindfulness'),
        HobbyChip(id: 'mental_wellness', label: 'Mental Wellness'),
        HobbyChip(id: 'self_care', label: 'Self Care & Relaxation'),
      ],
    ),
    HobbyCategoryModel(
      key: 'fun',
      title: 'Fun & Entertainment',
      icon: Icons.movie_outlined,
      backgroundColor: AppColors.prefsCategoryCardFun,
      chips: [
        HobbyChip(id: 'movies', label: 'Movies & TV'),
        HobbyChip(id: 'gaming', label: 'Gaming'),
        HobbyChip(id: 'board_games', label: 'Board Games'),
        HobbyChip(id: 'live_events', label: 'Live Events & Concerts'),
        HobbyChip(id: 'socializing', label: 'Socializing & Nightlife'),
      ],
    ),
    HobbyCategoryModel(
      key: 'ambition',
      title: 'Ambition & Productivity',
      icon: Icons.trending_up_outlined,
      backgroundColor: AppColors.prefsCategoryCardAmbition,
      chips: [
        HobbyChip(id: 'career', label: 'Career Growth'),
        HobbyChip(id: 'entrepreneurship', label: 'Entrepreneurship'),
        HobbyChip(id: 'productivity', label: 'Productivity & Planning'),
        HobbyChip(id: 'finance', label: 'Finance & Investing'),
      ],
    ),
    HobbyCategoryModel(
      key: 'relationships',
      title: 'Relationships & Family',
      icon: Icons.family_restroom_outlined,
      backgroundColor: AppColors.prefsCategoryCardRelationships,
      chips: [
        HobbyChip(id: 'family_time', label: 'Family Time'),
        HobbyChip(id: 'parenting', label: 'Parenting'),
        HobbyChip(id: 'kids_activities', label: 'Kids Activities'),
        HobbyChip(id: 'pets', label: 'Pets & Animals'),
      ],
    ),
    HobbyCategoryModel(
      key: 'tech',
      title: 'Tech & Modern Life',
      icon: Icons.devices_outlined,
      backgroundColor: AppColors.prefsCategoryCardTech,
      chips: [
        HobbyChip(id: 'technology', label: 'Technology & Gadgets'),
        HobbyChip(id: 'ai', label: 'AI & Innovation'),
        HobbyChip(id: 'digital_creation', label: 'Digital Creation'),
      ],
    ),
  ];
}
