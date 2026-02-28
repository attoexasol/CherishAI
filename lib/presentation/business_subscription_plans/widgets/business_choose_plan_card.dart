// lib/presentation/business_subscription_plans/widgets/business_choose_plan_card.dart
import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../controllers/business_choose_plan_controller.dart';

const double _kCardRadius = 24;
const double _kHeaderPaddingH = 32;
const double _kHeaderPaddingV = 40;
const double _kEmojiSize = 48;
const double _kEmojiMb = 16;
const double _kPlanNameMb = 24;
const double _kPriceMb = 8;
const double _kPriceDescMt = 16;
const double _kContentPaddingH = 32;
const double _kContentPaddingV = 32;
const double _kSectionTitleMb = 16;
const double _kItemGap = 12;
const double _kCheckSize = 20;
const double _kCheckIconSize = 12;
const double _kAnalyticsPt = 24;
const double _kCtaRadius = 16;
const double _kCtaPaddingV = 16;
const double _kBadgeTop = -16;
const double _kBadgePaddingH = 24;
const double _kBadgePaddingV = 8;
const double _kBadgeIconSize = 16;

class BusinessChoosePlanCard extends StatelessWidget {
  const BusinessChoosePlanCard({
    super.key,
    required this.plan,
    required this.isCurrentPlan,
    required this.onUpgradeToPlus,
  });

  final BusinessChoosePlanModel plan;
  final bool isCurrentPlan;
  final VoidCallback? onUpgradeToPlus;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (plan.isPopular) _buildPopularBadge(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(
              color: plan.isPopular ? const Color(0xFFE9D5FF) : const Color(0xFFF3F4F6),
              width: plan.isPopular ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 25,
                spreadRadius: -5,
                color: const Color(0x30000000),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_kCardRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: _kHeaderPaddingH, vertical: _kHeaderPaddingV),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: plan.headerGradientColors,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(plan.emoji, style: const TextStyle(fontSize: _kEmojiSize)),
                      SizedBox(height: _kEmojiMb),
                      Text(plan.name, style: TextStyle(fontSize: 18, color: const Color(0xFF374151), fontWeight: FontWeight.w400)),
                      const SizedBox(height: 4),
                      Text(plan.subtitle, style: AppTextStyles.manageSubPlanName.copyWith(fontSize: 30)),
                      SizedBox(height: _kPriceMb),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('\$${plan.price}', style: AppTextStyles.manageSubPlanName.copyWith(fontSize: 48)),
                          const SizedBox(width: 8),
                          Text('/ ${plan.period}', style: const TextStyle(fontSize: 16, color: Color(0xFF4B5563))),
                        ],
                      ),
                      SizedBox(height: _kPriceDescMt),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          plan.description,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF4B5563), height: 1.5),
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: _kContentPaddingH, vertical: _kContentPaddingV),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.includesTitle.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: _kSectionTitleMb),
                      ...plan.includesItems.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: _kItemGap),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: _kCheckSize,
                                  height: _kCheckSize,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Color(0xFFA78BFA), Color(0xFFEC4899)],
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check, size: _kCheckIconSize, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 14, color: Color(0xFF374151), height: 1.5),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      if (plan.analyticsItems.isNotEmpty) ...[
                        Divider(height: _kAnalyticsPt, color: const Color(0xFFF3F4F6), thickness: 1),
                        Padding(padding: const EdgeInsets.only(top: 8), child: Text(
                          plan.analyticsTitle.toUpperCase(),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1F2937), letterSpacing: 0.5),
                        )),
                        SizedBox(height: _kSectionTitleMb),
                        ...plan.analyticsItems.map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: _kItemGap),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: _kCheckSize,
                                    height: _kCheckSize,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Color(0xFFA78BFA), Color(0xFFEC4899)],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.check, size: _kCheckIconSize, color: Colors.white),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF374151), height: 1.5), maxLines: 2, overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            )),
                      ],
                      if (isCurrentPlan)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: _kCtaPaddingV),
                          decoration: BoxDecoration(
                            color: AppColors.manageSubCtaDisabledBg,
                            borderRadius: BorderRadius.circular(_kCtaRadius),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check, size: 20, color: AppColors.manageSubCtaDisabledText),
                              const SizedBox(width: 8),
                              Text('Current Plan', style: AppTextStyles.manageSubCtaDisabled),
                            ],
                          ),
                        )
                      else if (plan.id == 'plus' && onUpgradeToPlus != null)
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onUpgradeToPlus,
                            borderRadius: BorderRadius.circular(_kCtaRadius),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: _kCtaPaddingV),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Color(0xFFF43F5E), Color(0xFFEC4899), Color(0xFFA855F7)],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                                borderRadius: BorderRadius.circular(_kCtaRadius),
                                boxShadow: [
                                  BoxShadow(offset: const Offset(0, 4), blurRadius: 12, color: const Color(0x4DFECDD3)),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Upgrade to Plus', style: AppTextStyles.manageSubUpgradeBtn),
                                  const SizedBox(width: 8),
                                  Icon(Icons.chevron_right, size: 20, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularBadge() {
    return Positioned(
      top: _kBadgeTop,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: _kBadgePaddingH, vertical: _kBadgePaddingV),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFA855F7), Color(0xFFEC4899), Color(0xFFF43F5E)],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 4), blurRadius: 12, color: const Color(0x40000000)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: _kBadgeIconSize, color: Colors.white),
              const SizedBox(width: 8),
              Text('Most Popular', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
