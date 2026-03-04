// lib/presentation/old_messages/controllers/old_messages_controller.dart
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

const String filterAll = 'all';
const String filterSarah = 'sarah';
const String filterMom = 'mom';
const String filterAlex = 'alex';

/// Single message item within a loved-one section.
class OldMessageItem {
  const OldMessageItem({
    required this.date,
    required this.text,
    this.tag,
  });
  final String date;
  final String text;
  final String? tag;
}

/// One loved-one section with messages (accordion card data).
class LovedOneSection {
  const LovedOneSection({
    required this.lovedOneKey,
    required this.lovedOneName,
    required this.messageCount,
    required this.messages,
  });
  final String lovedOneKey;
  final String lovedOneName;
  final int messageCount;
  final List<OldMessageItem> messages;
}

class OldMessagesController extends GetxController {
  final RxString activeFilter = filterAll.obs;
  final RxSet<String> expandedLovedOnes = <String>{}.obs;

  final RxList<LovedOneSection> sections = <LovedOneSection>[
    LovedOneSection(
      lovedOneKey: 'sarah',
      lovedOneName: 'Sarah',
      messageCount: 4,
      messages: const [
        OldMessageItem(
          date: 'January 15, 2026',
          text: "Happy Birthday, my love! 🎂 Every moment with you is a treasure. Here's to another year of beautiful memories together.",
          tag: 'Birthday',
        ),
        OldMessageItem(
          date: 'January 10, 2026',
          text: "Good morning beautiful! I was just thinking about that amazing dinner we had last week. Want to try that new Italian place tonight?",
        ),
        OldMessageItem(
          date: 'January 5, 2026',
          text: "You make every day brighter just by being in it. Looking forward to our weekend together! ❤️",
          tag: 'Anniversary',
        ),
        OldMessageItem(
          date: 'November 28, 2025',
          text: "I picked up your favorite coffee on my way home. Can't wait to see your smile when I get there! ☕💕",
        ),
      ],
    ),
    LovedOneSection(
      lovedOneKey: 'mom',
      lovedOneName: 'Mom',
      messageCount: 2,
      messages: const [
        OldMessageItem(
          date: 'January 8, 2026',
          text: "Thank you for always being there for me. Your love and support mean everything. Love you, Mom! 💕",
        ),
        OldMessageItem(
          date: 'December 15, 2025',
          text: "Happy Mother's Day to the best mom in the world! Thank you for your endless love and wisdom. 🌸",
          tag: "Mother's Day",
        ),
      ],
    ),
    LovedOneSection(
      lovedOneKey: 'alex',
      lovedOneName: 'Alex',
      messageCount: 1,
      messages: const [
        OldMessageItem(
          date: 'December 5, 2025',
          text: "Happy Birthday, buddy! Hope your day is filled with joy and laughter. Let's celebrate soon! 🎉",
          tag: 'Birthday',
        ),
      ],
    ),
  ].obs;

  void onBack() {
    Get.back();
  }

  void onSelectFilter(String filter) {
    activeFilter.value = filter;
  }

  void toggleExpand(String lovedOneKey) {
    final next = Set<String>.from(expandedLovedOnes);
    if (next.contains(lovedOneKey)) {
      next.remove(lovedOneKey);
    } else {
      next.add(lovedOneKey);
    }
    expandedLovedOnes.value = next;
  }

  bool isExpanded(String lovedOneKey) => expandedLovedOnes.contains(lovedOneKey);

  Future<void> onCopy(String messageText) async {
    final trimmed = messageText.trim();
    if (trimmed.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: trimmed));
    Get.snackbar(
      'Copied',
      'Message copied',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> onShare(String messageText, {String? lovedOneName}) async {
    final trimmed = messageText.trim();
    if (trimmed.isEmpty) {
      Get.snackbar('Nothing to share', 'There is no content to share.');
      return;
    }
    final buffer = StringBuffer('CherishAI\n\n');
    buffer.write(trimmed);
    if (lovedOneName != null && lovedOneName.isNotEmpty) {
      buffer.write('\n\nFor $lovedOneName');
    }
    buffer.write('\n\nShared via CherishAI');
    await Share.share(buffer.toString(), subject: 'CherishAI');
  }
}
