// lib/presentation/onboarding/controllers/individual_step2_add_loved_one_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Minimal UI state for Individual Step 2 (Add a loved one). Navigation matches React:
/// back -> pop; Save & Continue -> same action/route as React.
class IndividualStep2AddLovedOneController extends GetxController {
  final nameController = TextEditingController();

  final RxString selectedRelationshipKey = RxString('');
  final RxBool isSubmitting = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  void onTapAddPhoto() {
    // UI-only stub. Wire to image picker if project adds it.
  }

  void onSelectRelationship(String key) {
    selectedRelationshipKey.value = key;
  }

  void onSaveAndContinue() {
    if (isSubmitting.value) return;
    isSubmitting.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      isSubmitting.value = false;
      // Same as React: next step or submit. Replace with actual route when step 3 exists.
      Get.toNamed(AppRoutes.individualUserInfo);
    });
  }
}

/// One selectable relationship option (single-select across all groups).
class LovedOneRelationshipOption {
  const LovedOneRelationshipOption({
    required this.key,
    required this.label,
    required this.emoji,
  });
  final String key;
  final String label;
  final String emoji;
}

/// Relationship category with title, icon emoji, and options.
class LovedOneRelationshipCategory {
  const LovedOneRelationshipCategory({
    required this.id,
    required this.title,
    required this.titleEmoji,
    required this.options,
  });
  final String id;
  final String title;
  final String titleEmoji;
  final List<LovedOneRelationshipOption> options;
}

/// Static data for Relationship Type (Choose 1). Mirror React structure.
abstract class LovedOneRelationshipData {
  static const List<LovedOneRelationshipCategory> categories = [
    LovedOneRelationshipCategory(
      id: 'romantic',
      title: 'Romantic / Intimate',
      titleEmoji: '💕',
      options: [
        LovedOneRelationshipOption(
          key: 'partner',
          label: 'Partner (dating / committed, not married)',
          emoji: '💕',
        ),
        LovedOneRelationshipOption(key: 'spouse', label: 'Spouse (married partner)', emoji: '💍'),
        LovedOneRelationshipOption(key: 'crush', label: 'Crush / Romantic interest', emoji: '😍'),
      ],
    ),
    LovedOneRelationshipCategory(
      id: 'family',
      title: 'Family',
      titleEmoji: '👨‍👩‍👧',
      options: [
        LovedOneRelationshipOption(key: 'parent', label: 'Parent', emoji: '👪'),
        LovedOneRelationshipOption(key: 'child', label: 'Child', emoji: '👶'),
        LovedOneRelationshipOption(key: 'sibling', label: 'Sibling', emoji: '👫'),
        LovedOneRelationshipOption(key: 'extended_family', label: 'Extended family', emoji: '👨‍👩‍👧‍👦'),
      ],
    ),
    LovedOneRelationshipCategory(
      id: 'social',
      title: 'Social',
      titleEmoji: '🤟',
      options: [
        LovedOneRelationshipOption(key: 'friend', label: 'Friend', emoji: '😊'),
        LovedOneRelationshipOption(key: 'close_friend', label: 'Close friend / Best friend', emoji: '💛'),
      ],
    ),
    LovedOneRelationshipCategory(
      id: 'professional',
      title: 'Professional',
      titleEmoji: '💼',
      options: [
        LovedOneRelationshipOption(key: 'coworker', label: 'Co-worker', emoji: '👥'),
        LovedOneRelationshipOption(key: 'manager', label: 'Manager / Supervisor', emoji: '👔'),
        LovedOneRelationshipOption(key: 'client', label: 'Client / Business contact', emoji: '🤝'),
      ],
    ),
  ];
}
