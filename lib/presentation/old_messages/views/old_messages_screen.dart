// lib/presentation/old_messages/views/old_messages_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/old_messages_controller.dart';

const double _kPaddingH = 20;
const double _kBackIconSize = 24;
const double _kChipPaddingH = 16;
const double _kChipPaddingV = 10;
const double _kChipRadius = 999;
const double _kChipGap = 10;
const double _kCardRadius = 20;
const double _kCardPadding = 20;
const double _kAvatarSize = 48;
const double _kChevronSize = 24;
const double _kMaxWidth = 480;
const double _kBottomPadding = 100;

class OldMessagesScreen extends StatelessWidget {
  const OldMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OldMessagesController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.oldMessagesPageBg,
              AppColors.oldMessagesPageBg,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, c),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kPaddingH,
                    right: _kPaddingH,
                    bottom: _kBottomPadding + bottomPadding,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                      child: Obx(() {
                        final activeFilter = c.activeFilter.value;
                        final summaries = c.conversationSummaries
                            .where((item) => activeFilter == filterAll || item.id == activeFilter)
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildFilterChips(context, c, activeFilter),
                            const SizedBox(height: 20),
                            ...summaries.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildMessageCard(context, c, item),
                                )),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, OldMessagesController c) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_kPaddingH, 16, _kPaddingH, 12),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.oldMessagesBackIcon),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.chat_bubble_outline, size: 22, color: AppColors.oldMessagesTitle),
          const SizedBox(width: 8),
          Text('Old Messages', style: AppTextStyles.oldMessagesTitle),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, OldMessagesController c, String activeFilter) {
    final chips = [
      (filter: filterAll, label: 'All Messages'),
      (filter: filterSarah, label: 'Sarah'),
      (filter: filterMom, label: 'Mom'),
      (filter: filterAlex, label: 'Alex'),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final chip in chips) ...[
            if (chip.filter != chips.first.filter) const SizedBox(width: _kChipGap),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => c.onSelectFilter(chip.filter),
                borderRadius: BorderRadius.circular(_kChipRadius),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                  decoration: BoxDecoration(
                    gradient: activeFilter == chip.filter ? AppGradients.oldMessagesChipSelected : null,
                    color: activeFilter == chip.filter ? null : AppColors.oldMessagesChipUnselectedBg,
                    border: Border.all(
                      color: activeFilter == chip.filter ? Colors.transparent : AppColors.oldMessagesChipUnselectedBorder,
                    ),
                    borderRadius: BorderRadius.circular(_kChipRadius),
                  ),
                  child: Text(
                    chip.label,
                    style: activeFilter == chip.filter
                        ? AppTextStyles.oldMessagesChipSelected
                        : AppTextStyles.oldMessagesChipUnselected,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageCard(
    BuildContext context,
    OldMessagesController c,
    OldMessagesConversationItem item,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => c.onOpenConversation(item.id),
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.oldMessagesCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: AppShadows.oldMessagesCard,
          ),
          child: Row(
            children: [
              Container(
                width: _kAvatarSize,
                height: _kAvatarSize,
                decoration: const BoxDecoration(
                  color: AppColors.oldMessagesAvatarBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite, size: 22, color: AppColors.giftIdeasTitle),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: AppTextStyles.oldMessagesCardName),
                    const SizedBox(height: 2),
                    Text(
                      '${item.messageCount} messages',
                      style: AppTextStyles.oldMessagesCardCount,
                    ),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_down, size: _kChevronSize, color: AppColors.oldMessagesChevron),
            ],
          ),
        ),
      ),
    );
  }
}
