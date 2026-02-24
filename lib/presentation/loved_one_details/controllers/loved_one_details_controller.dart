// lib/presentation/loved_one_details/controllers/loved_one_details_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../onboarding/controllers/individual_step3_relationship_goals_controller.dart';
import '../../edit_loved_one/models/edit_loved_one_models.dart';
import '../../loved_ones/controllers/loved_ones_controller.dart';
import '../../loved_ones/models/loved_one_model.dart';

/// Loved One Details screen state. Mirrors React LovedOneDetailsScreen:
/// receives id from route, displays/edits primary + secondary goals, navigates to edit / gift ideas / subscription.
class LovedOneDetailsController extends GetxController {
  String get lovedOneId =>
      Get.arguments is Map ? (Get.arguments['id'] as String?) ?? '' : '';

  final RxString name = ''.obs;
  final RxString relationship = ''.obs;
  final RxString emoji = '💑'.obs;
  final RxString birthday = ''.obs;
  final RxString anniversary = ''.obs;
  final RxString phone = ''.obs;
  final RxString primaryGoalKey = ''.obs;
  final RxList<String> secondaryGoalIds = <String>[].obs;
  final RxList<String> hobbyLabels = <String>[].obs;

  static const int maxSecondaryGoals = 3;

  List<RelationshipGoalOption> get primaryGoalOptions =>
      RelationshipGoalsData.options;
  List<SecondaryGoalItemDisplay> get secondaryGoalsWithCategory =>
      EditLovedOneData.secondaryGoalsWithCategory;

  @override
  void onInit() {
    super.onInit();
    _loadDetails();
  }

  void _loadDetails() {
    if (lovedOneId.isEmpty) return;
    LovedOneModel? found;
    if (Get.isRegistered<LovedOnesController>()) {
      final listCtrl = Get.find<LovedOnesController>();
      for (final e in listCtrl.lovedOnes) {
        if (e.id == lovedOneId) {
          found = e;
          break;
        }
      }
    }
    final lovedOne = found;
    if (lovedOne != null) {
      name.value = lovedOne.name;
      relationship.value = lovedOne.relationship;
      emoji.value = lovedOne.emoji;
    } else {
      name.value = 'Sarah';
      relationship.value = 'Partner';
      emoji.value = '💑';
    }
    birthday.value = 'January 15';
    anniversary.value = 'March 20';
    phone.value = '+1 234 567 8900';
    primaryGoalKey.value = 'deepen_connection';
    secondaryGoalIds.assignAll(['be_present', 'grow_together', 'celebrate_moments']);
    hobbyLabels.assignAll(['Coffee', 'Reading', 'Travel', 'Music']);
  }

  void onBack() {
    Get.back();
  }

  void onEditLovedOne() {
    if (lovedOneId.isEmpty) return;
    Get.toNamed(AppRoutes.editLovedOne, arguments: {'id': lovedOneId});
  }

  void onViewGiftIdeas() {
    if (lovedOneId.isEmpty) return;
    Get.toNamed(AppRoutes.giftIdeas, arguments: {'id': lovedOneId});
  }

  void onViewSubscriptionPlans() {
    Get.toNamed(AppRoutes.choosePlan);
  }

  void onSelectPrimaryGoal(String? key) {
    primaryGoalKey.value = key ?? '';
  }

  void onToggleSecondaryGoal(String goalId) {
    if (secondaryGoalIds.contains(goalId)) {
      secondaryGoalIds.remove(goalId);
    } else if (secondaryGoalIds.length < maxSecondaryGoals) {
      secondaryGoalIds.add(goalId);
    }
    secondaryGoalIds.refresh();
  }

  bool get canAddSecondaryGoal => secondaryGoalIds.length < maxSecondaryGoals;
  RelationshipGoalOption? get selectedPrimaryGoal {
    final k = primaryGoalKey.value;
    if (k.isEmpty) return null;
    for (final g in primaryGoalOptions) {
      if (g.key == k) return g;
    }
    return null;
  }

  void onTapBottomNav(String tab) {
    if (tab == 'loved_ones') return;
    switch (tab) {
      case 'home':
        Get.offNamed(AppRoutes.home);
        break;
      case 'search':
        Get.offNamed(AppRoutes.search);
        break;
      case 'alerts':
        Get.offNamed(AppRoutes.notificationsList);
        break;
      case 'profile':
        Get.offNamed(AppRoutes.profile);
        break;
      default:
        break;
    }
  }
}
