// lib/presentation/loved_ones/views/loved_ones_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/loved_ones_controller.dart';
import '../models/loved_one_model.dart';

const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingV = 24;
const double _kBackBtnSize = 40;
const double _kBackBtnRadius = 12;
const double _kTitleSubtitleGap = 4;
const double _kAddBtnSize = 44;
const double _kAddBtnRadius = 16;
const double _kAddLabelGap = 4;
const double _kContentPaddingH = 24;
const double _kContentPaddingTop = 32;
const double _kCardRadius = 24;
const double _kCardPadding = 24;
const double _kCardGap = 16;
const double _kAvatarSize = 64;
const double _kAvatarRadius = 16;
const double _kAvatarContentGap = 16;
const double _kNameRelationshipGap = 4;
const double _kActionBtnSize = 40;
const double _kActionBtnRadius = 12;
const double _kActionBtnGap = 8;
const double _kEmojiSize = 28;
const double _kBottomNavHeight = 72;
const double _kBottomNavRadius = 28;
const double _kBottomNavPaddingH = 16;
const double _kBottomNavPaddingV = 12;
const double _kBottomNavHideLabelWidth = 280;
const double _kListBottomPadding = 24;

class LovedOnesScreen extends StatelessWidget {
  const LovedOnesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LovedOnesController>();
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.lovedOnesPageBg,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final showBottomNavLabels = screenWidth >= _kBottomNavHideLabelWidth;
              final paddingH = screenWidth < Breakpoints.sm ? 16.0 : _kContentPaddingH;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context, c, paddingH),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(
                        left: paddingH,
                        right: paddingH,
                        top: _kContentPaddingTop,
                        bottom: _kBottomNavHeight + _kListBottomPadding + bottomPadding,
                      ),
                      children: [
                        Obx(() => c.lovedOnes.isEmpty
                            ? _buildEmptyState(context, c)
                            : _buildList(context, c)),
                      ],
                    ),
                  ),
                  _buildBottomNav(context, c, showBottomNavLabels),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LovedOnesController c, double paddingH) {
    return Container(
      padding: EdgeInsets.fromLTRB(paddingH, _kHeaderPaddingV, paddingH, _kHeaderPaddingV),
      decoration: BoxDecoration(
        color: AppColors.lovedOnesHeaderBg,
        border: Border(
          bottom: BorderSide(color: AppColors.lovedOnesBackBtnBorder.withOpacity(0.5), width: 1),
        ),
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBack,
              borderRadius: BorderRadius.circular(_kBackBtnRadius),
              child: Container(
                width: _kBackBtnSize,
                height: _kBackBtnSize,
                decoration: BoxDecoration(
                  color: AppColors.lovedOnesBackBtnBg,
                  borderRadius: BorderRadius.circular(_kBackBtnRadius),
                  border: Border.all(color: AppColors.lovedOnesBackBtnBorder),
                  boxShadow: AppShadows.lovedOnesBackBtn,
                ),
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.lovedOnesBackIcon),
              ),
            ),
          ),
          SizedBox(width: _kAvatarContentGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Loved Ones', style: AppTextStyles.lovedOnesTitle),
                SizedBox(height: _kTitleSubtitleGap),
                Obx(() => Text(c.subtitleText, style: AppTextStyles.lovedOnesSubtitle)),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: c.onAddLovedOne,
                  borderRadius: BorderRadius.circular(_kAddBtnRadius),
                  child: Container(
                    width: _kAddBtnSize,
                    height: _kAddBtnSize,
                    decoration: BoxDecoration(
                      gradient: AppGradients.lovedOnesAddBtn,
                      borderRadius: BorderRadius.circular(_kAddBtnRadius),
                      boxShadow: AppShadows.lovedOnesAddBtn,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.add, size: 28, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: _kAddLabelGap),
              Text('Add a loved one', style: AppTextStyles.lovedOnesAddLabel),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, LovedOnesController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              gradient: AppGradients.searchQuickLovedOnes,
              shape: BoxShape.circle,
              boxShadow: AppShadows.lovedOnesAddBtn,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.favorite, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text('No Loved Ones Yet', style: AppTextStyles.lovedOnesTitle),
          const SizedBox(height: 12),
          Text(
            'Start your journey by adding the special people in your life',
            style: AppTextStyles.lovedOnesSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onAddLovedOne,
              borderRadius: BorderRadius.circular(_kCardRadius),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  gradient: AppGradients.lovedOnesAddBtn,
                  borderRadius: BorderRadius.circular(_kCardRadius),
                  boxShadow: AppShadows.lovedOnesAddBtn,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 24, color: Colors.white),
                    const SizedBox(width: 8),
                    Text('Add Your First Person', style: AppTextStyles.profileSaveBtn),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, LovedOnesController c) {
    return Obx(() => Column(
      children: c.lovedOnes.asMap().entries.map((entry) {
        final item = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: entry.key < c.lovedOnes.length - 1 ? _kCardGap : 0),
          child: _buildCard(context, c, item),
        );
      }).toList(),
    ));
  }

  Widget _buildCard(BuildContext context, LovedOnesController c, LovedOneModel item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => c.onTapLovedOne(item.id),
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: Container(
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.lovedOnesCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(color: AppColors.lovedOnesCardBorder, width: 2),
            boxShadow: AppShadows.lovedOnesCard,
          ),
          child: Row(
            children: [
              Container(
                width: _kAvatarSize,
                height: _kAvatarSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.lovedOnesAvatarBg,
                  borderRadius: BorderRadius.circular(_kAvatarRadius),
                  border: Border.all(color: AppColors.lovedOnesAvatarRing, width: 2),
                  boxShadow: AppShadows.lovedOnesAvatar,
                ),
                alignment: Alignment.center,
                child: Text(item.emoji, style: const TextStyle(fontSize: _kEmojiSize)),
              ),
              SizedBox(width: _kAvatarContentGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppTextStyles.lovedOnesCardName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: _kNameRelationshipGap),
                    Text(
                      item.relationship,
                      style: AppTextStyles.lovedOnesCardRelationship,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: _kActionBtnGap),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => c.onEditLovedOne(item.id),
                  borderRadius: BorderRadius.circular(_kActionBtnRadius),
                  child: Container(
                    width: _kActionBtnSize,
                    height: _kActionBtnSize,
                    decoration: BoxDecoration(
                      color: AppColors.lovedOnesEditBtnBg,
                      borderRadius: BorderRadius.circular(_kActionBtnRadius),
                      border: Border.all(color: AppColors.lovedOnesEditBtnBorder),
                      boxShadow: AppShadows.lovedOnesIconBtn,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.edit_outlined, size: 20, color: AppColors.lovedOnesEditIcon),
                  ),
                ),
              ),
              SizedBox(width: _kActionBtnGap),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => c.onDeleteLovedOne(item.id),
                  borderRadius: BorderRadius.circular(_kActionBtnRadius),
                  child: Container(
                    width: _kActionBtnSize,
                    height: _kActionBtnSize,
                    decoration: BoxDecoration(
                      color: AppColors.lovedOnesDeleteBtnBg,
                      borderRadius: BorderRadius.circular(_kActionBtnRadius),
                      border: Border.all(color: AppColors.lovedOnesDeleteBtnBorder),
                      boxShadow: AppShadows.lovedOnesIconBtn,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.delete_outline, size: 20, color: AppColors.lovedOnesDeleteIcon),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    LovedOnesController c,
    bool showLabels,
  ) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.only(
        left: _kBottomNavPaddingH,
        right: _kBottomNavPaddingH,
        top: _kBottomNavPaddingV,
        bottom: _kBottomNavPaddingV + bottomPadding,
      ),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.homeBottomNavBg,
            borderRadius: BorderRadius.circular(_kBottomNavRadius),
            border: Border.all(color: AppColors.homeBottomNavBorder),
            boxShadow: AppShadows.homeBottomNav,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildNavItem(context, c, 'home', Icons.home_rounded, 'Home', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'search', Icons.search, 'Search', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'loved_ones', Icons.favorite_border, 'Loved Ones', isActive: true, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'alerts', Icons.notifications_outlined, 'Alerts', isActive: false, showLabel: showLabels),
              ),
              Expanded(
                child: _buildNavItem(context, c, 'profile', Icons.person_outline, 'Profile', isActive: false, showLabel: showLabels),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    LovedOnesController c,
    String tab,
    IconData icon,
    String label, {
    required bool isActive,
    bool showLabel = true,
  }) {
    return GestureDetector(
      onTap: () => c.onTapBottomNav(tab),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: showLabel ? 12 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isActive ? AppGradients.homeBottomNavActivePill : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive ? AppShadows.homeBottomNavActivePill : null,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive ? AppColors.homeBottomNavActiveIcon : AppColors.homeBottomNavInactiveIcon,
              ),
              if (showLabel) ...[
                const SizedBox(height: 4),
                Text(
                  label,
                  style: isActive ? AppTextStyles.homeBottomNavLabel : AppTextStyles.homeBottomNavLabelInactive,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
