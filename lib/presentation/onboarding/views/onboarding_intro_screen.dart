// lib/presentation/onboarding/views/onboarding_intro_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_animations.dart';
import '../../../app/constants/app_assets.dart';
import '../../../core/widgets/asset_image_with_fallback.dart';
import '../controllers/onboarding_intro_controller.dart';

class OnboardingIntroScreen extends StatelessWidget {
  const OnboardingIntroScreen({super.key});

  static const double _continueButtonHeight = 56;
  static const double _bottomPadding = 24;
  static const double _cardRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFAFA),
              Color(0xFFF8F4F8),
              Color(0xFFF5EFF5),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1280),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 24),
                            _buildHeroCard(context),
                            const SizedBox(height: 48),
                            _buildHowItWorksSection(context),
                            const SizedBox(height: 32),
                            _buildContinueButtonAtEnd(context),
                            SizedBox(height: _bottomPadding),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildLanguageMenuOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_cardRadius),
            boxShadow: AppShadows.onboardingCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Most apps focused on maintaining relationships today still ask too much of you.',
                style: AppTextStyles.onboardingHeadline.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),
              _buildBulletRow('Your time', Icons.access_time),
              const SizedBox(height: 12),
              _buildBulletRow('Your efforts', Icons.volunteer_activism),
              const SizedBox(height: 12),
              _buildBulletRow('Emotional work', Icons.psychology),
              const SizedBox(height: 28),
              const Center(child: _AnimatedHeroLogo()),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'CherishAI',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.onboardingNotCoach.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onboardingHeadline,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Not another relationship coach',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.onboardingNotCoach.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF333333),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'CherishAI',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.onboardingNotCoach.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFFF69B4),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'is your personal\nlove assistant',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.onboardingTagline.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF333333),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoPillInCard(),
            ],
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: _buildGlobeButton(context),
        ),
      ],
    );
  }

  /// Light pink pill inside hero card; very light pink bg, darker pink/purple text.
  Widget _buildInfoPillInCard() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0F5),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 8,
              color: Color(0x15EC4899),
            ),
          ],
        ),
        child: Text(
          'it thinks for you, makes efforts for you and helps you love and care better.',
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingInfoPill.copyWith(
            fontSize: 14,
            color: const Color(0xFF8B4789),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildBulletRow(String label, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.onboardingCardBorder, width: 1),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 6,
                color: Color(0x1AEC4899),
              ),
            ],
          ),
          child: Icon(icon, size: 22, color: AppColors.onboardingBulletText),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: AppTextStyles.onboardingBullet.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  // Replaced by _AnimatedHeroLogo (React: center column cherishAIBrandedLogo + float + sparkles).
  // Kept as comment for reference; _AnimatedHeroLogo is defined below.

  Widget _buildHowItWorksSection(BuildContext context) {
    return Column(
      children: [
        Text(
          'HOW IT WORKS',
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingHowItWorks.copyWith(
            fontSize: 26,
            color: const Color(0xFF8A2BE2),
          ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 768;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildHowCard1()),
                  const SizedBox(width: 24),
                  Expanded(child: _buildHowCard2()),
                  const SizedBox(width: 24),
                  Expanded(child: _buildHowCard3()),
                ],
              );
            }
            return Column(
              children: [
                _buildHowCard1(),
                const SizedBox(height: 24),
                _buildHowCard2(),
                const SizedBox(height: 24),
                _buildHowCard3(),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        _buildBusinessCard(),
      ],
    );
  }

  Widget _buildHowCard1() {
    const steps = [
      (1, 'You add yourself'),
      (2, 'You add your loved one'),
      (3, 'You set your relationship goal'),
      (4, 'You share their preferences'),
      (5, 'You share important dates (birthdays, first date, etc.)'),
    ];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: AppShadows.onboardingHowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final s in steps) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDDA0DD),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${s.$1}',
                    style: AppTextStyles.onboardingStepNum.copyWith(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      s.$2,
                      style: AppTextStyles.onboardingStepText.copyWith(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎀', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Text(
                "That's all...",
                style: AppTextStyles.onboardingThatsAll.copyWith(
                  color: const Color(0xFF666666),
                ),
              ),
              const SizedBox(width: 8),
              const Text('🎁', style: TextStyle(fontSize: 22)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowCard2() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: AppShadows.onboardingHowCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CherishAI does the heavy lifting',
            style: AppTextStyles.onboardingHeavyLiftTitle.copyWith(
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'It thinks daily deeply on how to achieve your relationship goal!',
            style: AppTextStyles.onboardingHeavyLiftSubtitle.copyWith(
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          _buildHeavyBullet(
            'Words you can share or say to them, thoughtfully prepared',
          ),
          const SizedBox(height: 12),
          _buildHeavyBullet(
            'Gifts you can offer for each special occasion, carefully chosen',
          ),
          const SizedBox(height: 12),
          _buildHeavyBullet(
            'Cherish remembers important dates so you can focus on being present',
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('🎁', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 6),
              const Text('🎀', style: TextStyle(fontSize: 22)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeavyBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.favorite,
          size: 18,
          color: AppColors.onboardingPinkFill,
          fill: 1.0,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.onboardingHeavyLiftBullet.copyWith(
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  /// Standalone pill: light pink container, vibrant pink gradient text (match reference).
  Widget _buildHowCard3() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE4EC),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 8),
            blurRadius: 24,
            spreadRadius: 0,
            color: Color(0x26FB7185),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => AppGradients.onboardingValuePropText.createShader(bounds),
        child: Text(
          '100% personal love,\n0% emotional labor',
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingValueProp.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardRadius),
        boxShadow: AppShadows.onboardingBusinessCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Are you a business offering gifts and services that help people express love?',
            style: AppTextStyles.onboardingBusinessTitle.copyWith(
              color: const Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Register with CherishAI so your products and services can be thoughtfully suggested to users when they\'re needed most - at the perfect moment of connection.',
            style: AppTextStyles.onboardingBusinessBody.copyWith(
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.card_giftcard, size: 20, color: AppColors.onboardingRoseFill),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Help people cherish those they love',
                  style: AppTextStyles.onboardingBusinessFooter.copyWith(
                    color: const Color(0xFF333333),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.favorite, size: 18, color: AppColors.onboardingRoseFill),
            ],
          ),
        ],
      ),
    );
  }

  /// At end of scroll content: pill-shaped, pink gradient (135°), white bold Continue, subtle shadow.
  Widget _buildContinueButtonAtEnd(BuildContext context) {
    final c = Get.find<OnboardingIntroController>();
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onTapContinue,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: _continueButtonHeight,
            padding: const EdgeInsets.symmetric(horizontal: 64),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: AppGradients.onboardingContinueBtn,
              borderRadius: BorderRadius.circular(999),
              boxShadow: AppShadows.onboardingContinueBtn,
            ),
            child: Text('Continue', style: AppTextStyles.onboardingContinue),
          ),
        ),
      ),
    );
  }

  /// Circular button inside card: transparent/very light bg, thin light purple border, white globe.
  Widget _buildGlobeButton(BuildContext context) {
    final c = Get.find<OnboardingIntroController>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: c.onTapGlobe,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFB587D8), width: 1.5),
          ),
          child: Icon(Icons.language, size: 24, color: const Color(0xFFB587D8)),
        ),
      ),
    );
  }

  Widget _buildLanguageMenuOverlay(BuildContext context) {
    final c = Get.find<OnboardingIntroController>();
    return Obx(() {
      if (!c.showLanguageMenu.value) return const SizedBox.shrink();
      return GestureDetector(
        onTap: c.closeLanguageMenu,
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: const Color(0x1A000000),
          child: Stack(
            children: [
              Positioned(
                top: 96,
                right: 32,
                child: Container(
                  width: 280,
                  constraints: const BoxConstraints(maxHeight: 320),
                  decoration: BoxDecoration(
                    gradient: AppGradients.onboardingGlobeBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.onboardingCardBorder, width: 1),
                    boxShadow: AppShadows.onboardingCard,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Text(
                          'Select Language',
                          style: AppTextStyles.onboardingLangMenuTitle,
                        ),
                      ),
                      const Divider(height: 1),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: OnboardingIntroController.languages.length,
                          itemBuilder: (context, i) {
                            final lang = OnboardingIntroController.languages[i];
                            final name = lang['name']!;
                            final isSelected = c.selectedLanguage.value == name;
                            return Material(
                              color: isSelected
                                  ? const Color(0x1AFB7185)
                                  : Colors.transparent,
                              child: InkWell(
                                onTap: () => c.handleLanguageSelect(name),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(lang['flag']!, style: const TextStyle(fontSize: 24)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          name,
                                          style: AppTextStyles.onboardingLangOption.copyWith(
                                            color: isSelected
                                                ? AppColors.pinkDark
                                                : AppColors.onboardingHeadline,
                                          ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(Icons.favorite,
                                            size: 16, color: AppColors.pinkAccent),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

/// Animated hero logo matching React: cherishAIBrandedLogo + float y [0,-8,0] 4s + sparkles.
class _AnimatedHeroLogo extends StatefulWidget {
  const _AnimatedHeroLogo();

  @override
  State<_AnimatedHeroLogo> createState() => _AnimatedHeroLogoState();
}

class _AnimatedHeroLogoState extends State<_AnimatedHeroLogo>
    with TickerProviderStateMixin {
  static const double _logoSize = 224;
  static const double _sparkleTop = -16;
  static const double _sparkleRight = -16;
  static const double _starBottom = -8;
  static const double _starLeft = -8;

  late final AnimationController _floatController;
  late final AnimationController _sparkleController;
  late final AnimationController _starController;
  late final Animation<double> _floatAnimation;
  late final Animation<double> _sparkleScale;
  late final Animation<double> _sparkleRotate;
  late final Animation<double> _starScale;
  late final Animation<double> _starRotate;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: AppAnimations.onboardingHeroLogoFloat,
    )..repeat(reverse: true);

    _sparkleController = AnimationController(
      vsync: this,
      duration: AppAnimations.onboardingHeroSparkle,
    )..repeat(reverse: true);

    _starController = AnimationController(
      vsync: this,
      duration: AppAnimations.onboardingHeroStar,
    );
    // React: star transition delay 0.5s then repeat
    Future.delayed(AppAnimations.onboardingHeroStarDelay, () {
      if (mounted) _starController.repeat(reverse: true);
    });

    _floatAnimation = Tween<double>(
      begin: 0,
      end: -AppAnimations.onboardingHeroLogoFloatOffset,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: AppAnimations.onboardingHeroFloatCurve,
    ));

    _sparkleScale = Tween<double>(begin: 1, end: 1.1).animate(CurvedAnimation(
      parent: _sparkleController,
      curve: AppAnimations.onboardingHeroFloatCurve,
    ));
    _sparkleRotate = Tween<double>(begin: 0, end: 10 * 3.14159 / 180).animate(
      CurvedAnimation(
        parent: _sparkleController,
        curve: AppAnimations.onboardingHeroFloatCurve,
      ),
    );

    _starScale = Tween<double>(begin: 1, end: 1.15).animate(CurvedAnimation(
      parent: _starController,
      curve: AppAnimations.onboardingHeroFloatCurve,
    ));
    _starRotate = Tween<double>(begin: 0, end: -10 * 3.14159 / 180).animate(
      CurvedAnimation(
        parent: _starController,
        curve: AppAnimations.onboardingHeroFloatCurve,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _sparkleController.dispose();
    _starController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placeholder = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: _logoSize,
          height: _logoSize,
          decoration: BoxDecoration(
            color: AppColors.onboardingCardBorder.withValues(alpha: 0.25),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 8),
                blurRadius: 24,
                color: Color(0x33EC4899),
              ),
            ],
          ),
          child: Icon(
            Icons.people,
            size: 80,
            color: AppColors.onboardingBulletText.withValues(alpha: 0.6),
          ),
        ),
      ],
    );

    return SizedBox(
      width: _logoSize,
      height: _logoSize + AppAnimations.onboardingHeroLogoFloatOffset,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: _sparkleTop,
            right: _sparkleRight,
            child: AnimatedBuilder(
              animation: Listenable.merge([_sparkleRotate, _sparkleScale]),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _sparkleRotate.value,
                  child: Transform.scale(
                    scale: _sparkleScale.value,
                    child: Icon(Icons.auto_awesome, size: 24, color: AppColors.pinkAccent),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: _starBottom,
            left: _starLeft,
            child: AnimatedBuilder(
              animation: Listenable.merge([_starScale, _starRotate]),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _starRotate.value,
                  child: Transform.scale(
                    scale: _starScale.value,
                    child: Icon(Icons.star, size: 20, color: AppColors.purpleAccent),
                  ),
                );
              },
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: _logoSize,
                    height: _logoSize,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 8),
                          blurRadius: 24,
                          color: AppColors.primaryPink.withValues(alpha: 0.2),
                        ),
                      ],
                    ),
                    child: AssetImageWithFallback(
                      assetPath: AppAssets.cherishAIBrandedLogo,
                      width: _logoSize,
                      height: _logoSize,
                      fit: BoxFit.contain,
                      placeholder: placeholder,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
