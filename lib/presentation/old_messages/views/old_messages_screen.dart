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
const double _kChipGap = 10;
const double _kChipRadius = 999;
const double _kCardRadius = 20;
const double _kCardPadding = 20;
const double _kAvatarSize = 48;
const double _kChevronSize = 24;
const double _kMaxWidth = 480;
const double _kBottomPadding = 100;
const double _kMessageCardRadius = 16;
const double _kMessageCardPadding = 16;
const double _kDateIconSize = 20;
const double _kTagPaddingH = 12;
const double _kTagPaddingV = 6;
const double _kTagRadius = 999;
const double _kDividerHeight = 1;
const double _kButtonPaddingV = 12;
const double _kButtonGap = 12;
const double _kSubCardGap = 16;

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
                        final list = c.sections
                            .where((s) =>
                                activeFilter == filterAll ||
                                s.lovedOneKey == activeFilter)
                            .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildFilterChips(context, c, activeFilter),
                            const SizedBox(height: 20),
                            ...list.map((section) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _buildLovedOneCard(context, c, section),
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

  Widget _buildHeader(
      BuildContext context, OldMessagesController c) {
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
                child: Icon(Icons.arrow_back_ios_new,
                    size: _kBackIconSize,
                    color: AppColors.oldMessagesBackIcon),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.chat_bubble_outline,
              size: 22, color: AppColors.oldMessagesTitle),
          const SizedBox(width: 8),
          Text('Old Messages', style: AppTextStyles.oldMessagesTitle),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, OldMessagesController c,
      String activeFilter) {
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
            if (chip.filter != chips.first.filter)
              const SizedBox(width: _kChipGap),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => c.onSelectFilter(chip.filter),
                borderRadius: BorderRadius.circular(_kChipRadius),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: _kChipPaddingH, vertical: _kChipPaddingV),
                  decoration: BoxDecoration(
                    gradient: activeFilter == chip.filter
                        ? AppGradients.oldMessagesChipSelected
                        : null,
                    color: activeFilter == chip.filter
                        ? null
                        : AppColors.oldMessagesChipUnselectedBg,
                    border: Border.all(
                      color: activeFilter == chip.filter
                          ? Colors.transparent
                          : AppColors.oldMessagesChipUnselectedBorder,
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

  Widget _buildLovedOneCard(BuildContext context, OldMessagesController c,
      LovedOneSection section) {
    return Obx(() {
      final expanded = c.isExpanded(section.lovedOneKey);
      return Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.oldMessagesCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            boxShadow: AppShadows.oldMessagesCard,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () => c.toggleExpand(section.lovedOneKey),
                borderRadius: BorderRadius.circular(_kCardRadius),
                child: Padding(
                  padding: const EdgeInsets.all(_kCardPadding),
                  child: Row(
                    children: [
                      Container(
                        width: _kAvatarSize,
                        height: _kAvatarSize,
                        decoration: const BoxDecoration(
                          color: AppColors.oldMessagesAvatarBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.favorite,
                            size: 22, color: AppColors.giftIdeasTitle),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(section.lovedOneName,
                                style: AppTextStyles.oldMessagesCardName),
                            const SizedBox(height: 2),
                            Text(
                              '${section.messageCount} message${section.messageCount == 1 ? '' : 's'}',
                              style: AppTextStyles.oldMessagesCardCount,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: _kChevronSize,
                        color: AppColors.oldMessagesChevron,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOut,
                alignment: Alignment.topCenter,
                child: expanded
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: _kCardPadding,
                            right: _kCardPadding,
                            bottom: _kCardPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 8),
                            ...section.messages.asMap().entries.map((e) {
                              final idx = e.key;
                              final msg = e.value;
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: idx == 0 ? 0 : _kSubCardGap),
                                child: _buildMessageSubCard(
                                    context, c, msg, section.lovedOneName),
                              );
                            }),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMessageSubCard(
    BuildContext context,
    OldMessagesController c,
    OldMessageItem msg,
    String lovedOneName,
  ) {
    return Container(
      padding: const EdgeInsets.all(_kMessageCardPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF).withOpacity(0.5),
        borderRadius: BorderRadius.circular(_kMessageCardRadius),
        border: Border.all(color: const Color(0x80E9D5FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: _kDateIconSize, color: const Color(0xFF7C3AED)),
              const SizedBox(width: 8),
              Text(
                msg.date,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(_kMessageCardPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFBCFE8).withOpacity(0.6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (msg.tag != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: _kTagPaddingH, vertical: _kTagPaddingV),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(_kTagRadius),
                      border: Border.all(color: const Color(0xFFE9D5FF)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite_border,
                            size: 14, color: const Color(0xFF7C3AED)),
                        const SizedBox(width: 6),
                        Text(
                          msg.tag!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7C3AED),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Text(
                  msg.text,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF374151),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: _kDividerHeight,
                  color: const Color(0xFFE5E7EB),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => c.onCopy(msg.text),
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        label: const Text('Copy'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFEC4899),
                          side: const BorderSide(color: Color(0xFFFBCFE8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: _kButtonPaddingV),
                        ),
                      ),
                    ),
                    const SizedBox(width: _kButtonGap),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => c.onShare(msg.text,
                            lovedOneName: lovedOneName),
                        icon: const Icon(Icons.share_rounded, size: 18),
                        label: const Text('Share'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFEC4899),
                          side: const BorderSide(color: Color(0xFFFBCFE8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: _kButtonPaddingV),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
