// lib/presentation/checkout/views/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../controllers/checkout_controller.dart';
import '../models/plan_summary_model.dart';

const double _kTopInset = 16;
const double _kBackIconSize = 20;
const double _kHeaderIconSize = 56;
const double _kHeaderIconIconSize = 28;
const double _kCardRadius = 24;
const double _kCardPadding = 24;
const double _kIconSquareSize = 40;
const double _kInputRadius = 12;
const double _kPaymentTileRadius = 16;
const double _kPaymentDotSize = 8;
const double _kCtaHeight = 52;
const double _kCtaRadius = 16;
const double _kCtaSectionHeight = 148; // CTA block height for scroll padding (top + button + footer rows + bottom)
const double _kHorizontalPadding = 24;
const double _kMaxContentWidth = 480;
const double _kDetailsCardIconSize = 72;
const double _kDetailsCardSecureRadius = 16;

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.checkoutPageBg,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: _kHorizontalPadding,
                    right: _kHorizontalPadding,
                    top: 24,
                    bottom: _kCtaSectionHeight + MediaQuery.paddingOf(context).bottom,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildHeader(context),
                              const SizedBox(height: 32),
                              _buildContactCard(context),
                              const SizedBox(height: 24),
                              _buildPaymentMethodCard(context),
                              const SizedBox(height: 24),
                              Obx(() {
                                final c = Get.find<CheckoutController>();
                                final method = c.selectedPaymentMethod.value;
                                if (method == 'card') return _buildCardInfoCard(context);
                                if (method == 'apple') return _buildApplePayDetailsCard(context);
                                if (method == 'google') return _buildGooglePayDetailsCard(context);
                                return const SizedBox.shrink();
                              }),
                              const SizedBox(height: 24),
                              _buildOrderSummaryCard(context),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              _buildBottomCta(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final c = Get.find<CheckoutController>();
    return Padding(
      padding: EdgeInsets.only(
        left: _kHorizontalPadding,
        right: _kHorizontalPadding,
        top: _kTopInset,
        bottom: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: c.onBackToPlans,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back_ios_new, size: _kBackIconSize, color: AppColors.checkoutBackText),
                    const SizedBox(width: 8),
                    Text('Back to Plans', style: AppTextStyles.checkoutBack),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.checkoutSecureBg,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.checkoutSecureBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, size: 16, color: AppColors.checkoutSecureIcon),
                const SizedBox(width: 8),
                Text('Secure Checkout', style: AppTextStyles.checkoutSecure),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: _kHeaderIconSize,
            height: _kHeaderIconSize,
            decoration: BoxDecoration(
              gradient: AppGradients.checkoutAccent,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppShadows.checkoutCard,
            ),
            child: Icon(Icons.check_circle, size: _kHeaderIconIconSize, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => AppGradients.checkoutAccent.createShader(bounds),
          child: Text(
            'Complete Your Order',
            style: AppTextStyles.checkoutTitle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Start caring more intentionally today',
          style: AppTextStyles.checkoutSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context) {
    final c = Get.find<CheckoutController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.checkoutCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.checkoutCardBorder),
        boxShadow: AppShadows.checkoutCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _kIconSquareSize,
                height: _kIconSquareSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.subAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.mail_outline, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text('Contact Information', style: AppTextStyles.checkoutSectionTitle),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: c.emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyles.checkoutInput,
            decoration: InputDecoration(
              hintText: 'Email address',
              hintStyle: AppTextStyles.checkoutInputPlaceholder,
              filled: true,
              fillColor: AppColors.checkoutInputBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.checkoutInputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.checkoutInputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.checkoutPaymentTileSelectedBorder, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: c.fullNameController,
            style: AppTextStyles.checkoutInput,
            decoration: InputDecoration(
              hintText: 'Full name',
              hintStyle: AppTextStyles.checkoutInputPlaceholder,
              filled: true,
              fillColor: AppColors.checkoutInputBg,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.checkoutInputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.checkoutInputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_kInputRadius),
                borderSide: const BorderSide(color: AppColors.checkoutPaymentTileSelectedBorder, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context) {
    final c = Get.find<CheckoutController>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.checkoutCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.checkoutCardBorder),
        boxShadow: AppShadows.checkoutCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select Payment Method', style: AppTextStyles.checkoutSectionTitle),
          const SizedBox(height: 16),
          Obx(() {
            final selected = c.selectedPaymentMethod.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: _buildPaymentTile(
                    context,
                    key: 'card',
                    icon: Icons.credit_card,
                    label: 'Credit Card',
                    isSelected: selected == 'card',
                    onTap: () => c.onSelectPaymentMethod('card'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: _buildPaymentTile(
                    context,
                    key: 'google',
                    label: 'Google Pay',
                    isGooglePay: true,
                    isSelected: selected == 'google',
                    onTap: () => c.onSelectPaymentMethod('google'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: _buildPaymentTile(
                    context,
                    key: 'apple',
                    label: 'Apple Pay',
                    isApplePay: true,
                    isSelected: selected == 'apple',
                    onTap: () => c.onSelectPaymentMethod('apple'),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentTile(
    BuildContext context, {
    required String key,
    required String label,
    IconData? icon,
    bool isGooglePay = false,
    bool isApplePay = false,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_kPaymentTileRadius),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.checkoutPaymentTileSelectedBg : AppColors.checkoutCardBg,
            borderRadius: BorderRadius.circular(_kPaymentTileRadius),
            border: Border.all(
              color: isSelected ? AppColors.checkoutPaymentTileSelectedBorder : AppColors.checkoutPaymentTileBorder,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected ? AppShadows.checkoutCard : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 32,
                  color: isSelected ? AppColors.checkoutPaymentTileSelectedText : AppColors.checkoutPaymentTileUnselectedText,
                ),
              if (isGooglePay)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                          )
                        : null,
                    color: isSelected ? null : const Color(0xFFE5E7EB),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'G',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? Colors.white : AppColors.checkoutPaymentTileUnselectedText,
                    ),
                  ),
                ),
              if (isApplePay)
                Icon(
                  Icons.apple,
                  size: 32,
                  color: isSelected ? AppColors.checkoutPaymentTileSelectedText : AppColors.checkoutPaymentTileUnselectedText,
                ),
              const SizedBox(height: 8),
              Text(
                label,
                style: isSelected ? AppTextStyles.checkoutPaymentLabelSelected : AppTextStyles.checkoutPaymentLabel,
              ),
              if (isSelected) ...[
                const SizedBox(height: 6),
                Container(
                  width: _kPaymentDotSize,
                  height: _kPaymentDotSize,
                  decoration: const BoxDecoration(
                    color: AppColors.checkoutPaymentTileDot,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.checkoutCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.checkoutCardBorder),
        boxShadow: AppShadows.checkoutCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: _kIconSquareSize,
                height: _kIconSquareSize,
                decoration: BoxDecoration(
                  gradient: AppGradients.checkoutAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.credit_card, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text('Card Information', style: AppTextStyles.checkoutSectionTitle),
            ],
          ),
          const SizedBox(height: 16),
          Text('Accepted Cards', style: AppTextStyles.checkoutOrderPricePeriod),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildCardLogo('VISA'),
              const SizedBox(width: 12),
              _buildCardLogo('MC'),
              const SizedBox(width: 12),
              _buildCardLogo('AMEX'),
              const SizedBox(width: 12),
              _buildCardLogo('DISC'),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.checkoutSecurityBoxBg,
              borderRadius: BorderRadius.circular(_kDetailsCardSecureRadius),
              border: Border.all(color: AppColors.checkoutSecurityBoxBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock, size: 20, color: AppColors.checkoutSecureIcon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your payment is secure', style: AppTextStyles.checkoutSecurityTitle),
                      const SizedBox(height: 4),
                      Text('All transactions are encrypted and PCI-compliant', style: AppTextStyles.checkoutSecurityDesc),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplePayDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.checkoutCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.checkoutCardBorder),
        boxShadow: AppShadows.checkoutCard,
      ),
      child: Column(
        children: [
          Container(
            width: _kDetailsCardIconSize,
            height: _kDetailsCardIconSize,
            decoration: BoxDecoration(
              color: const Color(0xFF212121),
              shape: BoxShape.circle,
              boxShadow: AppShadows.checkoutCard,
            ),
            alignment: Alignment.center,
            child: Icon(Icons.apple, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Text(
            'Pay with Apple Pay',
            style: AppTextStyles.checkoutSectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Complete your purchase securely using your Apple Pay account',
            style: AppTextStyles.checkoutSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.checkoutSecurityBoxBg,
              borderRadius: BorderRadius.circular(_kDetailsCardSecureRadius),
              border: Border.all(color: AppColors.checkoutSecurityBoxBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user, size: 20, color: AppColors.checkoutSecureIcon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Secure Apple Pay checkout', style: AppTextStyles.checkoutSecurityTitle),
                      const SizedBox(height: 4),
                      Text(
                        "Your payment information is protected by Apple's security",
                        style: AppTextStyles.checkoutSecurityDesc,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGooglePayDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(_kCardPadding),
      decoration: BoxDecoration(
        color: AppColors.checkoutCardBg,
        borderRadius: BorderRadius.circular(_kCardRadius),
        border: Border.all(color: AppColors.checkoutCardBorder),
        boxShadow: AppShadows.checkoutCard,
      ),
      child: Column(
        children: [
          Container(
            width: _kDetailsCardIconSize,
            height: _kDetailsCardIconSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4285F4),
                  Color(0xFF34A853),
                  Color(0xFFFBBC05),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
              shape: BoxShape.circle,
              boxShadow: AppShadows.checkoutCard,
            ),
            alignment: Alignment.center,
            child: const Text(
              'G',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Pay with Google Pay',
            style: AppTextStyles.checkoutSectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Complete your purchase securely using your Google Pay account',
            style: AppTextStyles.checkoutSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.checkoutSecurityBoxBg,
              borderRadius: BorderRadius.circular(_kDetailsCardSecureRadius),
              border: Border.all(color: AppColors.checkoutSecurityBoxBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user, size: 20, color: AppColors.checkoutSecureIcon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Secure Google Pay checkout', style: AppTextStyles.checkoutSecurityTitle),
                      const SizedBox(height: 4),
                      Text(
                        "Your payment information is protected by Google's security",
                        style: AppTextStyles.checkoutSecurityDesc,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardLogo(String label) {
    return Container(
      width: 48,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.checkoutInputBorder),
      ),
      alignment: Alignment.center,
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF374151))),
    );
  }

  Widget _buildOrderSummaryCard(BuildContext context) {
    final c = Get.find<CheckoutController>();
    return Obx(() {
      final plan = c.selectedPlan.value;
      if (plan == null) return const SizedBox.shrink();
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(_kCardPadding),
        decoration: BoxDecoration(
          color: AppColors.checkoutCardBg,
          borderRadius: BorderRadius.circular(_kCardRadius),
          border: Border.all(color: AppColors.checkoutCardBorder),
          boxShadow: AppShadows.checkoutCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: _kIconSquareSize,
                  height: _kIconSquareSize,
                  decoration: BoxDecoration(
                    gradient: AppGradients.checkoutAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.auto_awesome, size: 22, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.name, style: AppTextStyles.checkoutOrderPlanName),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(plan.priceDisplay, style: AppTextStyles.checkoutOrderPrice),
                          const SizedBox(width: 4),
                          Text(plan.periodSlash, style: AppTextStyles.checkoutOrderPricePeriod),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: AppColors.checkoutCardBorder),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Monthly Subscription', style: AppTextStyles.checkoutLineItem),
                Text(plan.pricePerPeriod, style: AppTextStyles.checkoutLineItem),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Due Today', style: AppTextStyles.checkoutDueTodayLabel),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => AppGradients.checkoutAccent.createShader(bounds),
                  child: Text(plan.priceDisplay, style: AppTextStyles.checkoutOrderPrice.copyWith(fontSize: 28)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.checkoutDisclaimerBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "You'll be billed ${plan.priceDisplay} monthly. Cancel anytime from your account settings.",
                style: AppTextStyles.checkoutDisclaimer,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildBottomCta(BuildContext context) {
    final c = Get.find<CheckoutController>();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: _kHorizontalPadding,
        right: _kHorizontalPadding,
        top: 16,
        bottom: 16 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 8,
            color: const Color(0x0D000000),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            final loading = c.isSubmitting.value;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: loading ? null : c.onCompletePurchase,
                borderRadius: BorderRadius.circular(_kCtaRadius),
                child: Container(
                  height: _kCtaHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: loading ? null : AppGradients.checkoutCta,
                    color: loading ? AppColors.checkoutInputBorder : null,
                    borderRadius: BorderRadius.circular(_kCtaRadius),
                    boxShadow: loading ? null : AppShadows.checkoutCta,
                  ),
                  alignment: Alignment.center,
                  child: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text('Complete Purchase', style: AppTextStyles.checkoutCta),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 16, color: AppColors.checkoutFooterCheck),
              const SizedBox(width: 8),
              Text('No commitment • Cancel anytime', style: AppTextStyles.checkoutFooter),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 16, color: AppColors.checkoutFooterCheck),
              const SizedBox(width: 8),
              Text('Secure 256-bit SSL encryption', style: AppTextStyles.checkoutFooter),
            ],
          ),
        ],
      ),
    );
  }
}
