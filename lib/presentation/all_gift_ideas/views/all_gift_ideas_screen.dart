// lib/presentation/all_gift_ideas/views/all_gift_ideas_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/all_gift_ideas_controller.dart';
import '../widgets/gift_group_tile.dart';
import '../widgets/sort_panel.dart';

const double _kMaxContentWidth = 600;
const double _kPaddingH = 24;
const double _kHeaderPaddingV = 24;
const double _kBackBtnSize = 40;
const double _kBackIconSize = 20;
const double _kBackRadius = 12;
const double _kStatsCardRadius = 16;
const double _kStatsCardPadding = 20;
const double _kStatsGap = 16;
const double _kSortBarPaddingV = 12;
const double _kSortBarPaddingH = 20;
const double _kSortBarRadius = 16;
const double _kSortIconSize = 16;
const double _kBottomNavHeight = 88;

class AllGiftIdeasScreen extends StatelessWidget {
  const AllGiftIdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<AllGiftIdeasController>();
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF1F2),
              Color(0xFFFDF2F8),
              Color(0xFFFAF5FF),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, c, topPad),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kPaddingH,
                    right: _kPaddingH,
                    bottom: _kBottomNavHeight + bottomPad,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          _buildStatsCard(c),
                          const SizedBox(height: 24),
                          _buildSortBar(c),
                          const SizedBox(height: 8),
                          const SortPanel(),
                          _buildGroupList(c),
                        ],
                      ),
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
    BuildContext context,
    AllGiftIdeasController c,
    double topPad,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        _kPaddingH,
        topPad + 16,
        _kPaddingH,
        _kHeaderPaddingV,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(_kBackRadius),
              child: Container(
                width: _kBackBtnSize,
                height: _kBackBtnSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.giftIdeasBackBtn,
                  borderRadius: BorderRadius.circular(_kBackRadius),
                  border: Border.all(color: const Color(0xFFC084FC)),
                  boxShadow: AppShadows.giftIdeasBackBtn,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: _kBackIconSize,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFE11D48),
                Color(0xFFEC4899),
                Color(0xFFA855F7),
              ],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds),
            child: const Text(
              'All Gift Ideas',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.25,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Every gift idea you've ever explored, organized just for you",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(AllGiftIdeasController c) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(_kStatsCardPadding),
        decoration: BoxDecoration(
          color: AppColors.giftIdeasStatCardBg.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(_kStatsCardRadius),
          border: Border.all(color: const Color(0x80FBCFE8)),
          boxShadow: AppShadows.giftIdeasCard,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFE11D48), Color(0xFFEC4899)],
                    ).createShader(bounds),
                    child: Text(
                      '${c.totalCount}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Total Ideas',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 32,
              color: const Color(0xFFE5E7EB),
            ),
            Expanded(
              child: Column(
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                    ).createShader(bounds),
                    child: Text(
                      '${c.savedCount}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Saved',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 32,
              color: const Color(0xFFE5E7EB),
            ),
            Expanded(
              child: Column(
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xFFEC4899), Color(0xFFE11D48)],
                    ).createShader(bounds),
                    child: Text(
                      '${c.lovedOnesCount}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Loved Ones',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSortBar(AllGiftIdeasController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.toggleSortPanel,
        borderRadius: BorderRadius.circular(_kSortBarRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: _kSortBarPaddingV,
            horizontal: _kSortBarPaddingH,
          ),
          decoration: BoxDecoration(
            color: AppColors.giftIdeasStatCardBg.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(_kSortBarRadius),
            border: Border.all(color: const Color(0x80FBCFE8)),
            boxShadow: AppShadows.giftIdeasCard,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tune,
                size: _kSortIconSize,
                color: const Color(0xFF374151),
              ),
              const SizedBox(width: 8),
              const Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupList(AllGiftIdeasController c) {
    return Obx(() {
      final grouped = c.organizedGifts;
      if (grouped.isEmpty) {
        return const Padding(
          padding: EdgeInsets.only(top: 24),
          child: Center(
            child: Text(
              'No gift ideas yet',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: Column(
          children: grouped.entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GiftGroupTile(
                    groupKey: e.key,
                    gifts: e.value,
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
