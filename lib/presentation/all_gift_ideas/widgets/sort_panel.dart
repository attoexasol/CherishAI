// lib/presentation/all_gift_ideas/widgets/sort_panel.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_gift_ideas_controller.dart';

const double _kPanelRadius = 16;
const double _kPanelPadding = 16;
const double _kOptionPaddingV = 12;
const double _kOptionPaddingH = 16;
const double _kOptionRadius = 12;
const double _kOptionGap = 8;
const double _kIconSize = 16;
const double _kDotSize = 8;

class SortPanel extends StatelessWidget {
  const SortPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllGiftIdeasController>();
    return Obx(() {
      if (!c.isSortPanelOpen.value) return const SizedBox.shrink();
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(_kPanelPadding),
        decoration: BoxDecoration(
          color: AppColors.giftIdeasStatCardBg.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(_kPanelRadius),
          border: Border.all(color: const Color(0x80FBCFE8)),
          boxShadow: AppShadows.giftIdeasCard,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SortOption(
              sortMode: SortMode.dateProposed,
              label: 'Date Proposed',
              icon: Icons.calendar_today_outlined,
            ),
            SizedBox(height: _kOptionGap),
            _SortOption(
              sortMode: SortMode.occasion,
              label: 'Occasion',
              icon: Icons.card_giftcard_outlined,
            ),
            SizedBox(height: _kOptionGap),
            _SortOption(
              sortMode: SortMode.lovedOne,
              label: 'Loved One',
              icon: Icons.favorite_border,
            ),
          ],
        ),
      );
    });
  }
}

class _SortOption extends StatelessWidget {
  const _SortOption({
    required this.sortMode,
    required this.label,
    required this.icon,
  });

  final SortMode sortMode;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllGiftIdeasController>();
    final isSelected = c.sortMode.value == sortMode;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => c.setSortModeAndClose(sortMode),
        borderRadius: BorderRadius.circular(_kOptionRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: _kOptionPaddingV,
            horizontal: _kOptionPaddingH,
          ),
          decoration: BoxDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF43F5E), Color(0xFFEC4899)],
                  )
                : null,
            color: isSelected ? null : const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(_kOptionRadius),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      color: const Color(0x33E11D48),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: _kIconSize,
                color: isSelected ? Colors.white : const Color(0xFF374151),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF374151),
                  ),
                ),
              ),
              if (isSelected)
                Container(
                  width: _kDotSize,
                  height: _kDotSize,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
