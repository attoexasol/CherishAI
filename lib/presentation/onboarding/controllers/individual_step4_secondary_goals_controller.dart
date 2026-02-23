// lib/presentation/onboarding/controllers/individual_step4_secondary_goals_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';

/// Minimal UI state for Individual Step 4 (Secondary goals). Multi-select up to 3;
/// back -> pop; Submit enabled when >= 1 selected; Skip for now -> same as React.
class IndividualStep4SecondaryGoalsController extends GetxController {
  static const int maxSelection = 3;

  final RxList<String> selectedGoalIds = <String>[].obs;
  final RxBool isSubmitting = false.obs;

  void onBack() {
    Get.back();
  }

  void toggleGoal(String id) {
    if (selectedGoalIds.contains(id)) {
      selectedGoalIds.remove(id);
    } else if (selectedGoalIds.length < maxSelection) {
      selectedGoalIds.add(id);
    }
    selectedGoalIds.refresh();
  }

  void onSubmit() {
    if (selectedGoalIds.isEmpty || isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      Get.toNamed(AppRoutes.lovedOnePreferences);
    });
  }

  void onSkip() {
    Get.toNamed(AppRoutes.individualUserInfo);
  }
}

class SecondaryGoalOption {
  const SecondaryGoalOption({required this.id, required this.label});
  final String id;
  final String label;
}

class SecondaryGoalCategory {
  const SecondaryGoalCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.bubbleColor,
    required this.options,
  });
  final String id;
  final String title;
  final IconData icon;
  final Color bubbleColor;
  final List<SecondaryGoalOption> options;
}

abstract class SecondaryGoalsData {
  static const List<SecondaryGoalCategory> categories = [
    SecondaryGoalCategory(
      id: 'life_presence',
      title: 'Life & Presence',
      icon: Icons.terrain,
      bubbleColor: AppColors.secGoalsSectionBubbleBeige,
      options: [
        SecondaryGoalOption(id: 'balance_busy_life', label: 'Balance love with a busy life'),
        SecondaryGoalOption(id: 'be_present', label: 'Be more present and intentional'),
        SecondaryGoalOption(id: 'reconnect_after_distance', label: 'Reconnect after distance or absence'),
      ],
    ),
    SecondaryGoalCategory(
      id: 'growth_longevity',
      title: 'Growth & Longevity',
      icon: Icons.diamond_outlined,
      bubbleColor: AppColors.secGoalsSectionBubbleBlue,
      options: [
        SecondaryGoalOption(id: 'grow_together', label: 'Grow together emotionally'),
        SecondaryGoalOption(id: 'long_term_future', label: 'Build a long term future together'),
        SecondaryGoalOption(id: 'family_bonds', label: 'Strengthen family bonds'),
      ],
    ),
    SecondaryGoalCategory(
      id: 'healing_repair',
      title: 'Healing & Repair',
      icon: Icons.auto_awesome,
      bubbleColor: AppColors.secGoalsSectionBubblePink,
      options: [
        SecondaryGoalOption(id: 'heal_after_period', label: 'Heal after a difficult period'),
        SecondaryGoalOption(id: 'restore_after_conflict', label: 'Restore closeness after conflict'),
      ],
    ),
    SecondaryGoalCategory(
      id: 'moments_meaning',
      title: 'Moments & Meaning',
      icon: Icons.wb_sunny_outlined,
      bubbleColor: AppColors.secGoalsSectionBubbleYellow,
      options: [
        SecondaryGoalOption(id: 'celebrate_moments', label: 'Celebrate everyday moments'),
        SecondaryGoalOption(id: 'important_milestone', label: 'Prepare for an important milestone'),
        SecondaryGoalOption(id: 'joyful_surprises', label: 'Create joyful surprises'),
      ],
    ),
    SecondaryGoalCategory(
      id: 'emotional_expression',
      title: 'Emotional Expression',
      icon: Icons.favorite_border,
      bubbleColor: AppColors.secGoalsSectionBubblePink,
      options: [
        SecondaryGoalOption(id: 'deeply_understood', label: 'Make them feel deeply understood'),
        SecondaryGoalOption(id: 'lightness_playfulness', label: 'Bring more lightness and playfulness'),
      ],
    ),
  ];
}
