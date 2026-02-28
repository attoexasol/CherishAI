// lib/presentation/your_approach/controllers/your_approach_controller.dart
import 'package:get/get.dart';

class YourApproachController extends GetxController {
  late final String lovedOneName;
  final RxString relationshipType = 'partner'.obs;
  final RxString primaryGoal = 'Primary goal: Deepen relationship'.obs;
  final RxString guidance = RxString(
    "We're still learning about your relationship dynamics. Keep engaging with CherishAI, and we'll provide personalized guidance tailored to your unique connection. The more you interact and share, the better we can support you in nurturing this important relationship.",
  );

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    lovedOneName = args?['name'] as String? ?? 'Sarah';
    if (args?['relationshipType'] != null) {
      relationshipType.value = args!['relationshipType'] as String;
    }
    if (args?['primaryGoal'] != null) {
      final goal = args!['primaryGoal'] as String;
      primaryGoal.value = goal.startsWith('Primary goal:') ? goal : 'Primary goal: $goal';
    }
    if (args?['guidance'] != null) {
      guidance.value = args!['guidance'] as String;
    }
  }

  void onBack() => Get.back();
}
