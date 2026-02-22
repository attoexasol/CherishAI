// lib/presentation/splash/views/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/theme/app_animations.dart';
import '../controllers/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _heroOpacity = 1;
  double _heroScale = 1;
  double _heroY = 0;
  static const double _heroSectionMinHeight = 800;

  late AnimationController _logoAnim;
  late AnimationController _scrollIndicatorAnim;
  late AnimationController _ctaShimmerAnim;

  @override
  void initState() {
    super.initState();
    _logoAnim = AnimationController(
      vsync: this,
      duration: AppAnimations.logoEntrance,
    )..forward();

    _scrollIndicatorAnim = AnimationController(
      vsync: this,
      duration: AppAnimations.scrollIndicatorBounce,
    )..repeat(reverse: true);

    _ctaShimmerAnim = AnimationController(
      vsync: this,
      duration: AppAnimations.ctaShimmer,
    )..repeat();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final heroHeight = viewportHeight > 0 ? viewportHeight : _heroSectionMinHeight;
    final progress = (offset / heroHeight).clamp(0.0, 1.0);
    setState(() {
      _heroScale = 1 - (progress * 0.1);
      _heroOpacity = 1 - (progress * 0.7).clamp(0.0, 1.0);
      _heroY = -50 * progress;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _logoAnim.dispose();
    _scrollIndicatorAnim.dispose();
    _ctaShimmerAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildFloatingOrbs(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppGradients.splashPageBackground,
        ),
      ),
    );
  }

  Widget _buildFloatingOrbs() {
    return IgnorePointer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                left: constraints.maxWidth * 0.1,
                top: constraints.maxHeight * 0.15,
                child: _FloatingOrb(
                  size: 400,
                  color: AppColors.primaryPink,
                  opacity: 0.3,
                ),
              ),
              Positioned(
                right: constraints.maxWidth * 0.05,
                top: constraints.maxHeight * 0.3,
                child: _FloatingOrb(
                  size: 250,
                  color: AppColors.primaryPurple,
                  opacity: 0.35,
                ),
              ),
              Positioned(
                left: constraints.maxWidth * 0.2,
                bottom: constraints.maxHeight * 0.2,
                child: _FloatingOrb(
                  size: 400,
                  color: AppColors.pinkAccent,
                  opacity: 0.3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final heroHeight = viewportHeight > 0 ? viewportHeight : _heroSectionMinHeight;
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          SizedBox(
            height: heroHeight,
            child: _buildHeroSection(),
          ),
          _buildFeatureSection(),
          _buildTrustSection(),
          _buildCtaSection(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Transform.translate(
      offset: Offset(0, _heroY),
      child: Transform.scale(
        scale: _heroScale,
        child: Opacity(
          opacity: _heroOpacity.clamp(0.0, 1.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 448),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  _buildLogo(),
                  const SizedBox(height: 32),
                  _buildBrandName(),
                  const SizedBox(height: 16),
                  _buildBadge(),
                  const SizedBox(height: 24),
                  _buildHeadline(),
                  const SizedBox(height: 20),
                  _buildSubheadline(),
                  const SizedBox(height: 40),
                  _buildStats(),
                  const SizedBox(height: 40),
                  _buildScrollIndicator(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoAnim,
      builder: (context, child) {
        final t = Curves.elasticOut.transform(_logoAnim.value);
        final scale = t;
        final rotate = (1 - t) * (-0.5 * 3.14159);
        return Transform.rotate(
          angle: rotate,
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 144,
            height: 144,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: AppGradients.primaryPinkPurple,
              boxShadow: AppShadows.logo,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(-0.4, -0.4),
                        radius: 1.2,
                        colors: [
                          Color(0x80FFFFFF),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.favorite,
                      size: 80,
                      color: AppColors.white,
                      fill: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandName() {
    final width = MediaQuery.sizeOf(context).width;
    final fontSize = (width * 0.1).clamp(42.0, 56.0);
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          AppGradients.brandText.createShader(bounds),
      child: Text(
        'Cherish AI',
        textAlign: TextAlign.center,
        style: AppTextStyles.splashBrand(fontSize),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: AppGradients.badgeBackground,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: AppColors.primaryPink,
          width: 2,
        ),
        boxShadow: AppShadows.badge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryPink),
          const SizedBox(width: 8),
          Text(
            'LOVE • CARE • CONNECT',
            style: AppTextStyles.splashBadge,
          ),
          const SizedBox(width: 8),
          Icon(Icons.auto_awesome, size: 16, color: AppColors.primaryPurple),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Make Every Moment',
            textAlign: TextAlign.center,
            style: AppTextStyles.splashHeadline,
          ),
          const SizedBox(height: 4),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) =>
                AppGradients.headlineAccent.createShader(bounds),
            child: Text(
              'Unforgettable',
              textAlign: TextAlign.center,
              style: AppTextStyles.splashHeadline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubheadline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 384),
        child: Text(
          'The AI-powered companion that helps you nurture relationships and celebrate what truly matters',
          textAlign: TextAlign.center,
          style: AppTextStyles.splashSubheadline,
        ),
      ),
    );
  }

  Widget _buildStats() {
    final stats = [
      _StatData('10k+', 'Happy Users', Icons.people, AppGradients.statUsers),
      _StatData('50k+', 'Moments Tracked', Icons.favorite, AppGradients.statMoments),
      _StatData('4.9★', 'App Rating', Icons.star, AppGradients.statRating),
    ];
    return Row(
      children: List.generate(3, (i) {
        final stat = stats[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
            child: _StatCard(
              value: stat.value,
              label: stat.label,
              icon: stat.icon,
              gradient: stat.gradient,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Text(
          'SCROLL TO EXPLORE',
          style: AppTextStyles.splashScrollHint,
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _scrollIndicatorAnim,
          builder: (context, child) {
            final dy = 8.0 * _scrollIndicatorAnim.value;
            return Transform.translate(
              offset: Offset(0, dy),
              child: child,
            );
          },
          child: Container(
            width: 24,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryPink, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, 8),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryPink,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureSection() {
    final features = [
      _FeatureData(
        'Never Miss a Moment',
        'AI-powered reminders for birthdays, anniversaries, and every special occasion that matters',
        Icons.favorite,
        AppGradients.feature1,
        AppColors.primaryPink,
      ),
      _FeatureData(
        'Perfect Timing, Always',
        'Intelligent scheduling ensures you reach out at just the right moment to show you care',
        Icons.calendar_today,
        AppGradients.feature2,
        AppColors.primaryPurple,
      ),
      _FeatureData(
        'Thoughtful Gift Discovery',
        'Personalized suggestions based on interests, preferences, and meaningful connections',
        Icons.card_giftcard,
        AppGradients.feature3,
        AppColors.pinkAccent,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 448),
        child: Column(
          children: [
            const SizedBox(height: 64),
            Text(
              'Everything You Need',
              style: AppTextStyles.splashSectionTitle,
            ),
            const SizedBox(height: 12),
            Text(
              'Powerful features designed for meaningful connections',
              style: AppTextStyles.splashSectionSubtitle,
            ),
            const SizedBox(height: 48),
            ...features.asMap().entries.map((e) {
              return Padding(
                padding: EdgeInsets.only(bottom: e.key < features.length - 1 ? 32 : 0),
                child: _FeatureCard(
                  title: e.value.title,
                  description: e.value.description,
                  icon: e.value.icon,
                  gradient: e.value.gradient,
                  color: e.value.color,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustSection() {
    final items = [
      _TrustItem('Bank-Level Security', Icons.security, AppColors.primaryPurple),
      _TrustItem('Ad-Free Forever', Icons.favorite, AppColors.primaryPink),
      _TrustItem('Always Improving', Icons.trending_up, AppColors.pinkAccent),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 448),
        child: Column(
          children: [
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.white70,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: AppColors.primaryPink.withValues(alpha: 0.15),
                  width: 2,
                ),
                boxShadow: AppShadows.trustCard,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, size: 24, color: AppColors.success),
                      const SizedBox(width: 8),
                      Text(
                        'Built on Trust',
                        style: AppTextStyles.splashTrustTitle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: items.map((e) => Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: e.color.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: e.color.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Icon(e.icon, size: 28, color: e.color),
                          ),
                          Text(
                            e.label,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.splashTrustLabel,
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCtaSection() {
    final c = Get.find<SplashController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 448),
        child: Column(
          children: [
            const SizedBox(height: 32),
            _CtaButton(
              onPressed: c.goToAuth,
              shimmerAnimation: _ctaShimmerAnim,
            ),
            const SizedBox(height: 20),
            Text(
              '✨ Free forever • No credit card required',
              style: AppTextStyles.splashCtaFootnote,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _StatData {
  final String value;
  final String label;
  final IconData icon;
  final LinearGradient gradient;
  _StatData(this.value, this.label, this.icon, this.gradient);
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final LinearGradient gradient;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white70,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primaryPink.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: AppShadows.statCard,
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 20, color: AppColors.white),
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => gradient.createShader(bounds),
            child: Text(
              value,
              style: AppTextStyles.splashStatValue,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.splashStatLabel),
        ],
      ),
    );
  }
}

class _FeatureData {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final Color color;
  _FeatureData(this.title, this.description, this.icon, this.gradient, this.color);
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final Color color;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.white60,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.primaryPink.withValues(alpha: 0.15),
          width: 2,
        ),
        boxShadow: AppShadows.featureCard,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 6,
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    AppShadows.featureIconShadow(color),
                  ],
                ),
                child: Icon(icon, size: 32, color: AppColors.white),
              ),
              const SizedBox(height: 20),
              Text(title, style: AppTextStyles.splashFeatureTitle),
              const SizedBox(height: 12),
              Text(description, style: AppTextStyles.splashFeatureBody),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustItem {
  final String label;
  final IconData icon;
  final Color color;
  _TrustItem(this.label, this.icon, this.color);
}

class _CtaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AnimationController shimmerAnimation;

  const _CtaButton({required this.onPressed, required this.shimmerAnimation});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          decoration: BoxDecoration(
            gradient: AppGradients.primaryPinkPurple,
            borderRadius: BorderRadius.circular(28),
            boxShadow: AppShadows.ctaButton,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: shimmerAnimation,
                builder: (context, child) {
                  return Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.white.withValues(alpha: 0.4),
                            Colors.transparent,
                          ],
                          stops: [
                            (shimmerAnimation.value - 0.3).clamp(0.0, 1.0),
                            shimmerAnimation.value,
                            (shimmerAnimation.value + 0.3).clamp(0.0, 1.0),
                          ],
                        ).createShader(bounds),
                        blendMode: BlendMode.srcATop,
                        child: Container(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome, size: 24, color: AppColors.white),
                  const SizedBox(width: 12),
                  Text('Start Your Journey', style: AppTextStyles.splashCta),
                  const SizedBox(width: 12),
                  Icon(Icons.arrow_forward, size: 24, color: AppColors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingOrb extends StatefulWidget {
  final double size;
  final Color color;
  final double opacity;

  const _FloatingOrb({
    required this.size,
    required this.color,
    this.opacity = 0.3,
  });

  @override
  State<_FloatingOrb> createState() => _FloatingOrbState();
}

class _FloatingOrbState extends State<_FloatingOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
    _opacity = Tween<double>(
      begin: widget.opacity,
      end: widget.opacity * 1.6,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: child,
          ),
        );
      },
      child: ClipOval(
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                widget.color.withValues(alpha: 0.19),
                Colors.transparent,
              ],
              stops: const [0.0, 0.7],
            ),
          ),
        ),
      ),
    );
  }
}
