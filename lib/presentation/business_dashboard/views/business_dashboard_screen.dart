// lib/presentation/business_dashboard/views/business_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../app/theme/app_gradients.dart';
import '../../../../app/theme/app_shadows.dart';
import '../controllers/business_dashboard_controller.dart';

const double _kMaxContentWidth = 600;
const double _kHeaderPaddingH = 24;
const double _kHeaderPaddingTop = 48;
const double _kHeaderPaddingBottom = 80;
const double _kHeaderRadius = 30;
const double _kBackBtnSize = 40;
const double _kSettingsBtnSize = 48;
const double _kProfileSize = 64;
const double _kBackMb = 24;
const double _kProfileRowMb = 32;
const double _kStatBoxPadding = 12;
const double _kStatBoxRadius = 16;
const double _kContentOverlap = -40;
const double _kContentPaddingH = 24;
const double _kContentSpacing = 24;
const double _kCardRadius = 20;
const double _kCardPadding = 24;
const double _kMetricIconSize = 40;
const double _kDecoCircleSize = 80;
const double _kEmptyIconSize = 64;
const double _kEmptyIconInner = 32;
const double _kCrownBubbleSize = 56;
const double _kCrownIconSize = 28;
const double _kAddProductBtnPaddingV = 8;
const double _kAddProductBtnPaddingH = 24;
const double _kAddProductBtnRadius = 999;
const double _kViewPlansPaddingV = 16;
const double _kViewPlansPaddingH = 32;
const double _kViewPlansRadius = 16;
const double _kBottomPadding = 96;

class BusinessDashboardScreen extends StatelessWidget {
  const BusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<BusinessDashboardController>();
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.businessDashboardPageBg),
        child: SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeader(context, c, topPad),
                    Transform.translate(
                      offset: Offset(0, _kContentOverlap),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                          _kContentPaddingH,
                          0,
                          _kContentPaddingH,
                          _kBottomPadding + bottomPad,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildMetricsCards(c),
                                SizedBox(height: _kContentSpacing),
                                _buildYourProductsSection(context, c),
                                SizedBox(height: _kContentSpacing),
                                _buildUpgradeCard(context, c),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, BusinessDashboardController c, double topPad) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        _kContentPaddingH,
        _kHeaderPaddingTop + topPad,
        _kContentPaddingH,
        _kHeaderPaddingBottom,
      ),
      decoration: BoxDecoration(
        gradient: AppGradients.businessDashboardHeader,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(_kHeaderRadius),
          bottomRight: Radius.circular(_kHeaderRadius),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: c.onBack,
                      borderRadius: BorderRadius.circular(_kBackBtnSize / 2),
                      child: Container(
                        width: _kBackBtnSize,
                        height: _kBackBtnSize,
                        decoration: BoxDecoration(
                          color: AppColors.businessDashboardBackBtnBg,
                          shape: BoxShape.circle,
                          boxShadow: AppShadows.businessDashboardBackBtn,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.businessDashboardBackIcon),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: c.onOpenSettings,
                      borderRadius: BorderRadius.circular(_kSettingsBtnSize / 2),
                      child: Container(
                        width: _kSettingsBtnSize,
                        height: _kSettingsBtnSize,
                        decoration: BoxDecoration(
                          color: AppColors.businessDashboardSettingsBtnBg,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.businessDashboardSettingsBtnBorder, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.settings_rounded, size: 24, color: AppColors.businessDashboardStatValue),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: _kBackMb),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _kProfileSize,
                    height: _kProfileSize,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.businessDashboardProfileBorder, width: 2),
                      boxShadow: AppShadows.businessDashboardBackBtn,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.store_rounded, size: 28, color: AppColors.businessDashboardBackIcon),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text('xcgvnv', style: AppTextStyles.businessDashboardBusinessName, overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.businessDashboardBadgeBg,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.workspace_premium_rounded, size: 12, color: AppColors.businessDashboardBadgeText),
                                  SizedBox(width: 4),
                                  Text('Basic', style: AppTextStyles.businessDashboardBadge),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('vbn', style: AppTextStyles.businessDashboardUsername),
                        SizedBox(height: 2),
                        Text('Partner since Jan 2024', style: AppTextStyles.businessDashboardPartnerSince),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: _kProfileRowMb),
              Obx(() => Row(
                children: [
                  Expanded(child: _buildStatBox('Views', '1.2k')),
                  SizedBox(width: 12),
                  Expanded(child: _buildStatBox('Interactions', '${c.interactions.value}')),
                  SizedBox(width: 12),
                  Expanded(child: _buildStatBox('Website', '${c.websiteClicks.value}')),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Container(
      padding: EdgeInsets.all(_kStatBoxPadding),
      decoration: BoxDecoration(
        color: AppColors.businessDashboardStatBoxBg,
        borderRadius: BorderRadius.circular(_kStatBoxRadius),
        border: Border.all(color: AppColors.businessDashboardStatBoxBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.businessDashboardStatBoxLabel),
          SizedBox(height: 4),
          Text(value, style: AppTextStyles.businessDashboardStatBoxValue),
        ],
      ),
    );
  }

  Widget _buildMetricsCards(BusinessDashboardController c) {
    return Obx(() => Column(
      children: [
        _buildMetricCard(
          title: 'Business Profile Views',
          value: '1,247',
          trend: '+12%',
          icon: Icons.visibility_rounded,
          iconColor: AppColors.businessInfoBadgeStart,
          iconBg: AppColors.businessDashboardCardDeco,
        ),
        SizedBox(height: 12),
        _buildMetricCard(
          title: 'Interactions with Products',
          value: '${c.interactions.value}',
          trend: '+8%',
          icon: Icons.touch_app_rounded,
          iconColor: Color(0xFF2563EB),
          iconBg: Color(0xFFDBEAFE),
        ),
        SizedBox(height: 12),
        _buildMetricCard(
          title: 'Clicks on Website Link',
          value: '${c.websiteClicks.value}',
          trend: '+5%',
          icon: Icons.open_in_new_rounded,
          iconColor: Color(0xFF4F46E5),
          iconBg: Color(0xFFE0E7FF),
        ),
      ],
    ));
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String trend,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.businessDashboardCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.businessDashboardCard,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -8,
            right: -8,
            child: Container(
              width: _kDecoCircleSize,
              height: _kDecoCircleSize,
              decoration: BoxDecoration(
                color: AppColors.businessDashboardCardDeco,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: _kMetricIconSize,
                    height: _kMetricIconSize,
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 20, color: iconColor),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.trending_up_rounded, size: 12, color: AppColors.businessDashboardTrendGreen),
                      SizedBox(width: 4),
                      Text(trend, style: AppTextStyles.businessDashboardTrend),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(title, style: AppTextStyles.businessDashboardMetricLabel),
              SizedBox(height: 4),
              Text(value, style: AppTextStyles.businessDashboardMetricValue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYourProductsSection(BuildContext context, BusinessDashboardController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Your Products', style: AppTextStyles.businessDashboardSectionTitle),
                    SizedBox(width: 8),
                    Icon(Icons.auto_awesome_rounded, size: 20, color: AppColors.businessInfoBadgeStart),
                  ],
                ),
                SizedBox(height: 4),
                Obx(() => Text(
                  c.hasProducts.value ? 'Active listings' : 'No products yet',
                  style: AppTextStyles.businessDashboardSectionSubtitle,
                )),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: c.onManageProducts,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Manage', style: AppTextStyles.businessDashboardManageLink),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.businessDashboardManageLink),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Obx(() {
          if (c.hasProducts.value) {
            return SizedBox.shrink();
          }
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 32, horizontal: _kCardPadding),
            decoration: BoxDecoration(
              color: AppColors.businessDashboardCardBg,
              borderRadius: BorderRadius.circular(_kCardRadius),
              boxShadow: AppShadows.businessDashboardCard,
            ),
            child: Column(
              children: [
                Container(
                  width: _kEmptyIconSize,
                  height: _kEmptyIconSize,
                  decoration: BoxDecoration(
                    color: AppColors.businessDashboardEmptyIconBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.auto_awesome_rounded, size: _kEmptyIconInner, color: AppColors.businessDashboardEmptyIcon),
                ),
                SizedBox(height: 16),
                Text('No Products Yet', style: AppTextStyles.businessDashboardEmptyTitle),
                SizedBox(height: 8),
                Text('Add your first product or service to get started', style: AppTextStyles.businessDashboardEmptyDesc),
                SizedBox(height: 16),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.onAddProduct,
                    borderRadius: BorderRadius.circular(_kAddProductBtnRadius),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: _kAddProductBtnPaddingV, horizontal: _kAddProductBtnPaddingH),
                      decoration: BoxDecoration(
                        gradient: AppGradients.businessDashboardAddProductBtn,
                        borderRadius: BorderRadius.circular(_kAddProductBtnRadius),
                        boxShadow: AppShadows.businessDashboardCtaBtn,
                      ),
                      child: Text('Add Product', style: AppTextStyles.businessDashboardAddProductBtn),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildUpgradeCard(BuildContext context, BusinessDashboardController c) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        gradient: AppGradients.businessDashboardUpgradeCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: AppShadows.businessDashboardCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: _kCrownBubbleSize,
            height: _kCrownBubbleSize,
            decoration: BoxDecoration(
              gradient: AppGradients.businessDashboardCrownBubble,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppShadows.businessDashboardCtaBtn,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.workspace_premium_rounded, size: _kCrownIconSize, color: AppColors.white),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Upgrade to Plus', style: AppTextStyles.businessDashboardUpgradeTitle),
                    SizedBox(width: 8),
                    Icon(Icons.auto_awesome_rounded, size: 16, color: AppColors.businessDashboardSparkleAmber),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Get up to 7 business locations & up to 130 product listed',
                  style: AppTextStyles.businessDashboardUpgradeDesc,
                ),
                SizedBox(height: 4),
                Text(
                  '(For 1 business location: up to 15 products)',
                  style: AppTextStyles.businessDashboardUpgradeDesc.copyWith(
                    fontSize: 12,
                    color: AppColors.businessDashboardUpgradeDescMuted,
                  ),
                ),
                SizedBox(height: 16),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: c.onViewPlans,
                    borderRadius: BorderRadius.circular(_kViewPlansRadius),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: _kViewPlansPaddingV, horizontal: _kViewPlansPaddingH),
                      decoration: BoxDecoration(
                        gradient: AppGradients.businessDashboardViewPlansBtn,
                        borderRadius: BorderRadius.circular(_kViewPlansRadius),
                        boxShadow: AppShadows.businessInfoCta,
                      ),
                      child: Text('View Plans', style: AppTextStyles.businessDashboardViewPlansBtn),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
