// lib/presentation/onboarding/controllers/individual_step3_relationship_goals_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';

/// Minimal UI state for Individual Step 3 (Your relationship goals). Navigation matches React:
/// back -> pop; Save -> same action/route as React. Single-select goal; Save enabled when one selected.
class IndividualStep3RelationshipGoalsController extends GetxController {
  final RxString selectedGoalKey = RxString('');
  final RxBool isSaving = false.obs;

  void onBack() {
    Get.back();
  }

  void onSelectGoal(String key) {
    selectedGoalKey.value = key;
  }

  void onSave() {
    if (selectedGoalKey.value.isEmpty || isSaving.value) return;
    isSaving.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSaving.value = false;
      Get.toNamed(AppRoutes.individualSecondaryGoals);
    });
  }
}

/// One goal option (single-select).
class RelationshipGoalOption {
  const RelationshipGoalOption({
    required this.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
  final String key;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
}

/// Static data for Primary Goal (choose 1). Mirror React order and copy.
abstract class RelationshipGoalsData {
  static const List<RelationshipGoalOption> options = [
    RelationshipGoalOption(
      key: 'deepen_connection',
      title: 'Deepen emotional connection',
      subtitle: 'Increase closeness, openness, emotional intimacy',
      icon: Icons.favorite,
      iconBgColor: AppColors.goalsCardIconBgPink,
      iconColor: AppColors.goalsCardIconPink,
    ),
    RelationshipGoalOption(
      key: 'keep_spark',
      title: 'Keep the spark alive',
      subtitle: 'Maintain excitement, playfulness, attraction, novelty',
      icon: Icons.auto_awesome,
      iconBgColor: AppColors.goalsCardIconBgOrange,
      iconColor: AppColors.goalsCardIconOrange,
    ),
    RelationshipGoalOption(
      key: 'build_trust',
      title: 'Build trust & emotional security',
      subtitle: 'Create safety, reassurance, reliability, stability',
      icon: Icons.shield_outlined,
      iconBgColor: AppColors.goalsCardIconBgBlue,
      iconColor: AppColors.goalsCardIconBlue,
    ),
    RelationshipGoalOption(
      key: 'improve_communication',
      title: 'Improve communication & understanding',
      subtitle: 'Express better, listen better, feel understood',
      icon: Icons.chat_bubble_outline,
      iconBgColor: AppColors.goalsCardIconBgPurple,
      iconColor: AppColors.goalsCardIconPurple,
    ),
    RelationshipGoalOption(
      key: 'show_appreciation',
      title: 'Show appreciation & care',
      subtitle: 'Express gratitude, recognition, affection',
      icon: Icons.local_florist_outlined,
      iconBgColor: AppColors.goalsCardIconBgPink,
      iconColor: AppColors.goalsCardIconPink,
    ),
    RelationshipGoalOption(
      key: 'shared_moments',
      title: 'Create meaningful shared moments',
      subtitle: 'Build memories through experiences and rituals',
      icon: Icons.wb_sunny_outlined,
      iconBgColor: AppColors.goalsCardIconBgYellow,
      iconColor: AppColors.goalsCardIconYellow,
    ),
    RelationshipGoalOption(
      key: 'reignite_romance',
      title: 'Reignite romance or closeness',
      subtitle: 'Restore warmth, affection, emotional energy',
      icon: Icons.whatshot_outlined,
      iconBgColor: AppColors.goalsCardIconBgRed,
      iconColor: AppColors.goalsCardIconRed,
    ),
    RelationshipGoalOption(
      key: 'support_uplift',
      title: 'Support and uplift each other',
      subtitle: 'Offer encouragement and emotional presence',
      icon: Icons.favorite_border,
      iconBgColor: AppColors.goalsCardIconBgOrange,
      iconColor: AppColors.goalsCardIconOrange,
    ),
    RelationshipGoalOption(
      key: 'romantic_interest',
      title: 'Build romantic interest naturally',
      subtitle: 'Explore attraction with warmth and respect',
      icon: Icons.favorite,
      iconBgColor: AppColors.goalsCardIconBgPink,
      iconColor: AppColors.goalsCardIconPink,
    ),
  ];
}
