// lib/presentation/onboarding/views/business_splash_screen.dart
// Pixel-perfect from React BusinessSplashScreen (px-6, py-12, pb-24, max-w-md, RomanticCard, RomanticButton).
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/routes/app_routes.dart';
// React: px-6 py-12 pb-24 max-w-md
const double _kPaddingH = 24;
const double _kPaddingTop = 48;
const double _kPaddingBottom = 96;
const double _kMaxContentWidth = 520;

// Back: gap-2 px-3 py-2 mb-6 rounded-xl text-purple-600
const double _kBackGap = 8;
const double _kBackPaddingH = 12;
const double _kBackPaddingV = 8;
const double _kBackMb = 24;
const double _kBackRadius = 12;
const double _kBackIconSize = 20;

// Header: mb-12; badge w-16 h-16 rounded-full mb-4 shadow-lg; Store w-8 h-8
const double _kHeaderMb = 48;
const double _kBadgeSize = 64;
const double _kBadgeMb = 16;
const double _kBadgeIconSize = 32;
// Title text-3xl mb-3
const double _kTitleSize = 30;
const double _kTitleMb = 12;
// Subtitle text-gray-600 leading-relaxed (16px)
const double _kSubtitleSize = 16;

// Cards: space-y-4 mb-12
const double _kCardsGap = 16;
const double _kCardsMb = 48;
// RomanticCard: rounded-[20px] p-6 shadow-[0_8px_30px_rgb(0,0,0,0.08)]
const double _kCardRadius = 20;
const double _kCardPadding = 24;
const List<BoxShadow> _kCardShadow = [
  BoxShadow(offset: Offset(0, 8), blurRadius: 30, color: Color(0x14000000)),
];
// Card row gap-4; icon circle w-12 h-12; icon w-6 h-6
const double _kCardRowGap = 16;
const double _kCardIconCircleSize = 48;
const double _kCardIconSize = 24;
const double _kCardTitleMb = 4;

// Bottom: space-y-3
const double _kCtaGap = 12;
// RomanticButton: px-8 py-4 rounded-2xl, text-lg font-semibold
const double _kButtonPaddingH = 32;
const double _kButtonPaddingV = 16;
const double _kButtonRadius = 16;
const double _kButtonFontSize = 18;
const List<BoxShadow> _kButtonShadow = [
  BoxShadow(offset: Offset(0, 10), blurRadius: 15, color: Color(0x50EC4899)),
];

// React Tailwind colors (exact)
const Color _kPurple600 = Color(0xFF9333EA);
const Color _kIndigo600 = Color(0xFF4F46E5);
const Color _kPurple400 = Color(0xFFA78BFA);
const Color _kIndigo400 = Color(0xFF818CF8);
const Color _kPurple100 = Color(0xFFF3E8FF);
const Color _kIndigo100 = Color(0xFFE0E7FF);
const Color _kGray800 = Color(0xFF1F2937);
const Color _kGray600 = Color(0xFF4B5563);
const Color _kGray500 = Color(0xFF6B7280);
const Color _kRose500 = Color(0xFFF43F5E);
const Color _kPink500 = Color(0xFFEC4899);
const Color _kPurple500 = Color(0xFFA855F7);

class BusinessSplashScreen extends StatelessWidget {
  const BusinessSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBgStart,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(_kPaddingH, _kPaddingTop, _kPaddingH, _kPaddingBottom),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(),
                  SizedBox(height: _kBackMb),
                  _buildHeader(),
                  SizedBox(height: _kHeaderMb),
                  _buildFeatureCards(),
                  SizedBox(height: _kCardsMb),
                  _buildBottom(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.back(),
        borderRadius: BorderRadius.circular(_kBackRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: _kBackPaddingH, vertical: _kBackPaddingV),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back_rounded, size: _kBackIconSize, color: _kPurple600),
              SizedBox(width: _kBackGap),
              Text('Back', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: _kPurple600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            width: _kBadgeSize,
            height: _kBadgeSize,
            margin: const EdgeInsets.only(bottom: _kBadgeMb),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_kPurple400, _kIndigo400],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(offset: Offset(0, 10), blurRadius: 15, color: Colors.black.withValues(alpha: 0.15)),
              ],
            ),
            child: Icon(Icons.store_rounded, size: _kBadgeIconSize, color: Colors.white),
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [_kPurple600, _kIndigo600],
            ).createShader(bounds),
            child: Text(
              'CherishAI for Business',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: _kTitleSize, fontWeight: FontWeight.w700, height: 1.25),
            ),
          ),
          const SizedBox(height: _kTitleMb),
          Text(
            'Help people express their love through your products and services',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: _kSubtitleSize, color: _kGray600, height: 1.625),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCards() {
    final benefits = [
      _Benefit(icon: Icons.people_rounded, title: 'Reach Caring Customers', description: 'Connect with people who value thoughtfulness and meaningful moments - not impulse buying.'),
      _Benefit(icon: Icons.trending_up_rounded, title: 'Be Present at the Right Moment', description: 'Your offerings appear when care matters most: birthdays, anniversaries, milestones, and everyday gestures.'),
      _Benefit(icon: Icons.favorite_rounded, title: 'Grow with Intention', description: 'Get discovered by local individuals, couples, and families who are actively looking to express care.'),
      _Benefit(icon: Icons.store_rounded, title: 'Build Trust Through Relevance', description: 'Partner with a platform built on quality, context, and respect - not ads or aggressive promotion.'),
      _Benefit(icon: Icons.people_rounded, title: 'Simple & Respectful Visibility', description: 'Your business is shared as a thoughtful option, allowing customers to reach out naturally and directly'),
    ];
    return Column(
      children: [
        for (int i = 0; i < benefits.length; i++) ...[
          if (i > 0) SizedBox(height: _kCardsGap),
          _BenefitCard(benefit: benefits[i]),
        ],
      ],
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _onJoinPartnership,
            borderRadius: BorderRadius.circular(_kButtonRadius),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: _kButtonPaddingH, vertical: _kButtonPaddingV),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [_kRose500, _kPink500, _kPurple500],
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(_kButtonRadius),
                boxShadow: _kButtonShadow,
              ),
              child: Center(
                child: Text(
                  'Join for Partnership',
                  style: TextStyle(fontSize: _kButtonFontSize, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: _kCtaGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already a partner? ', style: TextStyle(fontSize: 14, color: _kGray500)),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _onSignIn,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Text('Sign in', style: TextStyle(fontSize: 14, color: _kPurple500, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onJoinPartnership() {
    Get.toNamed(AppRoutes.businessInformation);
  }

  void _onSignIn() {
    Get.toNamed(AppRoutes.auth);
  }
}

class _Benefit {
  const _Benefit({required this.icon, required this.title, required this.description});
  final IconData icon;
  final String title;
  final String description;
}

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.benefit});
  final _Benefit benefit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _kCardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _kCardIconCircleSize,
            height: _kCardIconCircleSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_kPurple100, _kIndigo100],
              ),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(benefit.icon, size: _kCardIconSize, color: _kPurple600),
          ),
          SizedBox(width: _kCardRowGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  benefit.title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: _kGray800),
                ),
                SizedBox(height: _kCardTitleMb),
                Text(
                  benefit.description,
                  style: TextStyle(fontSize: 14, color: _kGray600, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
