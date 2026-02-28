// lib/presentation/business_subscription_plans/views/business_choose_plan_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/business_choose_plan_controller.dart';
import '../widgets/business_choose_plan_card.dart';

const double _kPagePaddingH = 24;
const double _kPagePaddingTop = 32;
const double _kPagePaddingBottom = 96;
const double _kBackMb = 32;
const double _kBackPaddingH = 16;
const double _kBackPaddingV = 12;
const double _kBackIconSize = 20;
const double _kHeaderMb = 48;
const double _kBadgePaddingH = 20;
const double _kBadgePaddingV = 8;
const double _kBadgeIconSize = 16;
const double _kBadgeMb = 24;
const double _kTitleMb = 16;
const double _kTitleFontSize = 36;
const double _kSubtitleFontSize = 18;
const double _kCardsGap = 24;
const double _kCardsSectionMb = 48;
const double _kBenefitsGap = 24;
const double _kBenefitsSectionMb = 48;
const double _kBenefitCardPadding = 24;
const double _kBenefitCardRadius = 20;
const double _kBenefitIconSize = 56;
const double _kBenefitIconInner = 28;
const double _kBenefitTitleMb = 8;
const double _kMaxContentWidth = 1024;

class BusinessChoosePlanScreen extends StatelessWidget {
  const BusinessChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessChoosePlanController>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x4DFAF5FF),
              Color(0x4DFDF2F8),
              Color(0x4DFAF5FF),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(_kPagePaddingH, _kPagePaddingTop, _kPagePaddingH, _kPagePaddingBottom),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildBackButton(c),
                    SizedBox(height: _kBackMb),
                    _buildHeader(),
                    SizedBox(height: _kCardsSectionMb),
                    _buildPlanCards(context, c),
                    SizedBox(height: _kBenefitsSectionMb),
                    _buildBenefitCards(context),
                    SizedBox(height: _kBenefitsSectionMb),
                    _buildBottomLink(c),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BusinessChoosePlanController c) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onBackToDashboard,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: _kBackPaddingH, vertical: _kBackPaddingV),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(offset: const Offset(0, 10), blurRadius: 15, spreadRadius: -3, color: const Color(0x1A000000)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.businessDashboardBackIcon),
                const SizedBox(width: 8),
                Text('Back to Dashboard', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.businessDashboardBackIcon)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFFAF5FF), Color(0xFFFDF2F8)],
            ),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFE9D5FF)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_border, size: _kBadgeIconSize, color: const Color(0xFF9333EA)),
              const SizedBox(width: 8),
              Text('Business Subscriptions', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xFF9333EA))),
            ],
          ),
        ),
        SizedBox(height: _kBadgeMb),
        Text(
          'Choose Your Plan',
          style: AppTextStyles.manageSubChooseTitle.copyWith(fontSize: _kTitleFontSize),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: _kTitleMb),
        Text(
          'Connect with customers who need you most, at the perfect moment',
          style: TextStyle(fontSize: _kSubtitleFontSize, fontWeight: FontWeight.w400, color: const Color(0xFF4B5563), height: 1.5),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPlanCards(BuildContext context, BusinessChoosePlanController c) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useTwoColumns = constraints.maxWidth > 600;
        if (useTwoColumns) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.only(right: _kCardsGap / 2), child: _planCard(c, BusinessChoosePlanController.plans[0]))),
              Expanded(child: Padding(padding: const EdgeInsets.only(left: _kCardsGap / 2), child: _planCard(c, BusinessChoosePlanController.plans[1]))),
            ],
          );
        }
        return Column(
          children: [
            _planCard(c, BusinessChoosePlanController.plans[0]),
            SizedBox(height: _kCardsGap),
            _planCard(c, BusinessChoosePlanController.plans[1]),
          ],
        );
      },
    );
  }

  Widget _planCard(BusinessChoosePlanController c, BusinessChoosePlanModel plan) {
    return Obx(() => BusinessChoosePlanCard(
          plan: plan,
          isCurrentPlan: c.currentPlan.value == plan.id,
          onUpgradeToPlus: plan.id == 'plus' ? c.onUpgradeToPlus : null,
        ));
  }

  Widget _buildBenefitCards(BuildContext context) {
    final benefits = [
      (icon: Icons.gps_fixed, title: 'Smart Matching', desc: 'Connect with customers at the perfect moment'),
      (icon: Icons.people_outline, title: 'Grow Your Business', desc: 'Reach more customers who need your services'),
      (icon: Icons.bar_chart, title: 'Premium Analytics', desc: 'Track performance and optimize your offerings'),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        final useThreeColumns = constraints.maxWidth > 600;
        if (useThreeColumns) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 3; i++) Expanded(child: Padding(padding: EdgeInsets.only(left: i > 0 ? _kBenefitsGap / 2 : 0, right: i < 2 ? _kBenefitsGap / 2 : 0), child: _benefitCard(benefits[i].icon, benefits[i].title, benefits[i].desc))),
            ],
          );
        }
        return Column(
          children: benefits.map((b) => Padding(padding: const EdgeInsets.only(bottom: _kBenefitsGap), child: _benefitCard(b.icon, b.title, b.desc))).toList(),
        );
      },
    );
  }

  Widget _benefitCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(_kBenefitCardPadding),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(_kBenefitCardRadius),
        border: Border.all(color: const Color(0xFFE9D5FF)),
        boxShadow: [
          BoxShadow(offset: const Offset(0, 4), blurRadius: 12, color: const Color(0x0D000000)),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: _kBenefitIconSize,
            height: _kBenefitIconSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFF3E8FF), Color(0xFFFCE7F3)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: _kBenefitIconInner, color: const Color(0xFF9333EA)),
          ),
          SizedBox(height: _kBenefitTitleMb),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937)), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildBottomLink(BusinessChoosePlanController c) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: c.onBackToDashboard,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios_new, size: 16, color: AppColors.businessDashboardBackIcon),
                const SizedBox(width: 8),
                Text('Back to Dashboard', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.businessDashboardBackIcon)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
