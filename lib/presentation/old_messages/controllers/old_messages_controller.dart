// lib/presentation/old_messages/controllers/old_messages_controller.dart
import 'package:get/get.dart';

/// Filter: 'all' | 'sarah' | 'mom' | 'alex'
const String filterAll = 'all';
const String filterSarah = 'sarah';
const String filterMom = 'mom';
const String filterAlex = 'alex';

/// One conversation summary for Old Messages list (placeholder; wire to API later).
class OldMessagesConversationItem {
  const OldMessagesConversationItem({
    required this.id,
    required this.name,
    required this.messageCount,
  });
  final String id;
  final String name;
  final int messageCount;
}

/// Controller for Old Messages screen.
class OldMessagesController extends GetxController {
  final RxString activeFilter = filterAll.obs;

  final RxList<OldMessagesConversationItem> conversationSummaries = <OldMessagesConversationItem>[
    const OldMessagesConversationItem(id: 'sarah', name: 'Sarah', messageCount: 4),
    const OldMessagesConversationItem(id: 'mom', name: 'Mom', messageCount: 2),
    const OldMessagesConversationItem(id: 'alex', name: 'Alex', messageCount: 1),
  ].obs;

  void onBack() {
    Get.back();
  }

  void onSelectFilter(String filter) {
    activeFilter.value = filter;
  }

  void onToggleConversation(String conversationId) {
    // Expand/collapse if React supports it; else no-op.
  }

  void onOpenConversation(String conversationId) {
    // Navigate to conversation detail if React does; else no-op.
  }
}
