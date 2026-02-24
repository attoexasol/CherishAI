// lib/presentation/onboarding/views/user_type_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/constants/app_assets.dart';
import '../../../core/widgets/asset_image_with_fallback.dart';
import '../controllers/user_type_controller.dart';

const double _kBackBtnSize = 56;
const double _kBackBtnInset = 32;
const double _kLogoSize = 160;
const double _kLogoBottomMargin = 24;
const double _kSectionBottomMargin = 48;
const double _kTitleSubtitleGap = 12;
const double _kCardsGap = 24;
const double _kCardRadius = 28;
const double _kCardPadding = 32;
const double _kCardTitleBottom = 24;
const double _kIllustrationMaxSize = 260;
const double _kIllustrationRadius = 24;
const double _kDescBottom = 32;
const double _kCheckSize = 56;
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 1024;

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<UserTypeController>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.userTypePageBg,
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(_kHorizontalPadding,  16, _kHorizontalPadding, 32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                      child: Column(
                        children: [
                          _buildLogoSection(),
                          _buildTitleSection(),
                          SizedBox(height: _kCardsGap + 8),
                          _buildCards(context, c),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: _kBackBtnInset,
              left: _kBackBtnInset,
              child: _buildBackButton(c),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(UserTypeController c) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onBack,
        borderRadius: BorderRadius.circular(_kBackBtnSize / 2),
        child: Container(
          width: _kBackBtnSize,
          height: _kBackBtnSize,
          decoration: BoxDecoration(
            gradient: AppGradients.userTypeBackButton,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.userTypeCardBorderSelected.withValues(alpha: 0.4), width: 2),
            boxShadow: AppShadows.userTypeBackButton,
          ),
          alignment: Alignment.center,
          child: Icon(Icons.arrow_back_rounded, size: 24, color: AppColors.userTypeTitleAccent),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      children: [
        SizedBox(
          width: _kLogoSize,
          height: _kLogoSize,
          child: AssetImageWithFallback(
            assetPath: AppAssets.cherishLogo,
            width: _kLogoSize,
            height: _kLogoSize,
            fit: BoxFit.contain,
            placeholder: const _ImagePlaceholder(semanticLabel: 'Cherish AI Logo'),
          ),
        ),
        const SizedBox(height: _kLogoBottomMargin),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTextStyles.userTypeTitle,
            children: [
              const TextSpan(text: 'How would you like to use '),
              TextSpan(text: 'CherishAI', style: AppTextStyles.userTypeTitleAccent),
              const TextSpan(text: '?'),
            ],
          ),
        ),
        const SizedBox(height: _kTitleSubtitleGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'Choose the path that\'s right for you ',
                style: AppTextStyles.userTypeSubtitle,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Icon(Icons.favorite_rounded, size: 20, color: AppColors.userTypeSubtitle),
          ],
        ),
      ],
    );
  }

  Widget _buildCards(BuildContext context, UserTypeController c) {
    return Obx(() {
      final selected = c.selectedType.value;
      return Column(
        children: [
          _UserTypeCard(
            title: 'I am an individual',
            description:
                'I have loved ones, and I want Cherish AI to help me care for them with intention - thinking for me, making the effort for me, and keeping love personal and alive.',
            illustrationAsset: AppAssets.individualIllustration,
            isSelected: selected == 'individual',
            isBusiness: false,
            onTap: c.onSelectIndividual,
          ),
          const SizedBox(height: _kCardsGap),
          _UserTypeCard(
            title: 'I am a business',
            description:
                'I offer products or services that help people express care and appreciation, and I want Cherish AI to thoughtfully connect my offerings to the moments and relationships where they matter most.',
            illustrationAsset: AppAssets.businessIllustration,
            isSelected: selected == 'business',
            isBusiness: true,
            onTap: c.onSelectBusiness,
          ),
        ],
      );
    });
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.semanticLabel});

  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.userTypeCardBorder.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Icon(Icons.image_outlined, size: 48, color: AppColors.userTypeCardDesc.withValues(alpha: 0.5)),
      ),
    );
  }
}

class _UserTypeCard extends StatelessWidget {
  const _UserTypeCard({
    required this.title,
    required this.description,
    required this.illustrationAsset,
    required this.isSelected,
    required this.isBusiness,
    required this.onTap,
  });

  final String title;
  final String description;
  final String illustrationAsset;
  final bool isSelected;
  final bool isBusiness;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isBusiness
        ? (isSelected ? AppColors.userTypeCardBorderBusinessSelected : AppColors.userTypeCardBorderBusiness)
        : (isSelected ? AppColors.userTypeCardBorderSelected : AppColors.userTypeCardBorder);
    final shadows = isSelected
        ? AppShadows.userTypeCardSelected
        : (isBusiness ? AppShadows.userTypeCardBusinessDefault : AppShadows.userTypeCardDefault);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kCardRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(_kCardPadding),
          decoration: BoxDecoration(
            color: AppColors.userTypeCardBg,
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(color: borderColor, width: isSelected ? 3 : 2.5),
            boxShadow: shadows,
          ),
          child: Column(
            children: [
              Text(title, style: AppTextStyles.userTypeCardTitle, textAlign: TextAlign.center),
              const SizedBox(height: _kCardTitleBottom),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _kIllustrationMaxSize),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: AssetImageWithFallback(
                    assetPath: illustrationAsset,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(_kIllustrationRadius),
                    placeholder: Container(
                      decoration: BoxDecoration(
                        color: AppColors.userTypeCardBorder.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(_kIllustrationRadius),
                        boxShadow: AppShadows.userTypeIllustrationShadow,
                      ),
                      child: Center(
                        child: Icon(
                          isBusiness ? Icons.store_rounded : Icons.favorite_rounded,
                          size: 64,
                          color: AppColors.userTypeCardDesc.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: _kCardTitleBottom),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  description,
                  style: AppTextStyles.userTypeCardDesc,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: _kDescBottom),
              AnimatedScale(
                scale: isSelected ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: _kCheckSize,
                  height: _kCheckSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.userTypeCheckGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 20,
                        color: AppColors.userTypeTitleAccent.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check_rounded, color: AppColors.white, size: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
