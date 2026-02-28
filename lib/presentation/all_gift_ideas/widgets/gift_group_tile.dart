// lib/presentation/all_gift_ideas/widgets/gift_group_tile.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_gift_ideas_controller.dart';
import '../models/gift_idea_item.dart';
import 'gift_item_card.dart';

const double _kTileRadius = 16;
const double _kTilePadding = 20;
const double _kIconBoxSize = 48;
const double _kIconBoxRadius = 12;
const double _kIconSize = 24;
const double _kChevronSize = 20;
const int _kExpandDurationMs = 280;

class GiftGroupTile extends StatelessWidget {
  const GiftGroupTile({
    super.key,
    required this.groupKey,
    required this.gifts,
  });

  final String groupKey;
  final List<GiftIdeaItem> gifts;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllGiftIdeasController>();
    return Obx(() {
      final isExpanded = c.expandedGroupKeys.contains(groupKey);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => c.toggleSection(groupKey),
              borderRadius: BorderRadius.circular(_kTileRadius),
              child: Container(
                padding: const EdgeInsets.all(_kTilePadding),
                decoration: BoxDecoration(
                  color: AppColors.giftIdeasStatCardBg.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(_kTileRadius),
                  border: Border.all(color: const Color(0x80FBCFE8)),
                  boxShadow: AppShadows.giftIdeasCard,
                ),
                child: Row(
                  children: [
                    Container(
                      width: _kIconBoxSize,
                      height: _kIconBoxSize,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFF43F5E), Color(0xFFA855F7)],
                        ),
                        borderRadius: BorderRadius.circular(_kIconBoxRadius),
                        boxShadow: AppShadows.giftIdeasCard,
                      ),
                      child: Icon(
                        Icons.card_giftcard,
                        size: _kIconSize,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            groupKey,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${gifts.length} gift ideas',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: _kExpandDurationMs ~/ 2),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: _kChevronSize,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: _kExpandDurationMs),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      children: gifts
                          .map(
                            (g) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GiftItemCard(gift: g),
                            ),
                          )
                          .toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }
}
