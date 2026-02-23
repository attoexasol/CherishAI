// lib/presentation/help_feedback/controllers/help_feedback_controller.dart
import 'package:get/get.dart';

/// Topic option for "What would you like to share?"
class HelpFeedbackTopic {
  const HelpFeedbackTopic(this.id, this.label);
  final String id;
  final String label;
}

/// Controller for Help & Feedback screen. Form state and submit wiring.
/// Does NOT change business logic; submit calls same handler as React (API/support).
class HelpFeedbackController extends GetxController {
  static const List<HelpFeedbackTopic> topics = [
    HelpFeedbackTopic('question', 'Question / How it works'),
    HelpFeedbackTopic('suggestion', 'Suggestion / Idea'),
    HelpFeedbackTopic('something_wrong', 'Something didn\'t feel right'),
    HelpFeedbackTopic('bug', 'Bug or technical issue'),
    HelpFeedbackTopic('billing', 'Subscription or billing'),
    HelpFeedbackTopic('other', 'Other'),
  ];

  static const int maxMessageLength = 1000;

  final RxString selectedTopicId = ''.obs;
  final RxString message = ''.obs;
  final RxBool allowContact = false.obs;

  bool get hasValidTopic => selectedTopicId.value.isNotEmpty;
  bool get hasValidMessage => message.value.trim().isNotEmpty;
  bool get canSubmit => hasValidTopic && hasValidMessage;

  void selectTopic(String id) {
    selectedTopicId.value = id;
  }

  void setMessage(String value) {
    if (value.length <= maxMessageLength) message.value = value;
  }

  void setAllowContact(bool value) {
    allowContact.value = value;
  }

  void onBack() {
    Get.back();
  }

  void onSubmit() {
    if (!canSubmit) return;
    // TODO: call same API/support handler as React (no logic change)
    Get.back();
  }
}
