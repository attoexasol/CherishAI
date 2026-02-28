// lib/presentation/all_gift_ideas/widgets/gift_item_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_gift_ideas_controller.dart';
import '../models/gift_idea_item.dart';

const double _kCardRadius = 16;
const double _kCardPadding = 20;
const double _kHeartSize = 32;
const double _kChipPaddingH = 12;
const double _kChipPaddingV = 4;
const double _kChipRadius = 999;
const double _kChipGap = 8;

class GiftItemCard extends StatelessWidget {
  const GiftItemCard({super.key, required this.gift});

  final GiftIdeaItem gift;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllGiftIdeasController>();
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: const Color(0xCCFFFFFF),
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: const Color(0x80FBCFE8)),
        boxShadow: AppShadows.giftIdeasCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gift.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1F2937),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            gift.description,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => c.toggleSaved(gift.id),
                      child: Obx(() {
                        final list = c.allGiftIdeas.where((g) => g.id == gift.id).toList();
                        final updated = list.isEmpty ? null : list.first;
                        final isSaved = updated?.isSaved ?? gift.isSaved;
                        return Container(
                          width: _kHeartSize,
                          height: _kHeartSize,
                          decoration: BoxDecoration(
                            gradient: isSaved
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFFF43F5E),
                                      Color(0xFFEC4899),
                                    ],
                                  )
                                : null,
                            color: isSaved ? null : const Color(0xFFF3F4F6),
                            shape: BoxShape.circle,
                            boxShadow: isSaved
                                ? [
                                    BoxShadow(
                                      offset: const Offset(0, 2),
                                      blurRadius: 6,
                                      color: const Color(0x33E11D48),
                                    ),
                                  ]
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: isSaved ? Colors.white : const Color(0xFF9CA3AF),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: _kChipGap,
                  runSpacing: _kChipGap,
                  children: [
                    _Chip(
                      label: gift.lovedOneName,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFFFF1F2), Color(0xFFFCE7F3)],
                      ),
                      textColor: const Color(0xFFBE185D),
                    ),
                    _Chip(
                      label: gift.occasion,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFF3E8FF), Color(0xFFFCE7F3)],
                      ),
                      textColor: const Color(0xFF7C3AED),
                    ),
                    _Chip(
                      label: gift.category,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFFCE7F3), Color(0xFFFFF1F2)],
                      ),
                      textColor: const Color(0xFFBE185D),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proposed: ${gift.dateProposed}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    Text(
                      gift.price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE11D48),
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

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.gradient,
    required this.textColor,
  });

  final String label;
  final Gradient gradient;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _kChipPaddingH,
        vertical: _kChipPaddingV,
      ),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(_kChipRadius),
        border: Border.all(color: textColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
