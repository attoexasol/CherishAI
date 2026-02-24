// lib/presentation/auth/views/auth_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_gradients.dart';
import '../../../app/theme/app_shadows.dart';
import '../../../app/constants/app_assets.dart';
import '../../../core/widgets/asset_image_with_fallback.dart';
import '../controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static const double _horizontalPadding = 24;
  static const double _segmentHeight = 52;
  static const double _segmentRadius = 26;
  static const double _socialHeight = 56;
  static const double _socialRadius = 14;
  /// Google icon size matching React AuthScreen (w-5 h-5 = 20px).
  static const double _googleIconSize = 20;
  /// Gap between social icon and label matching React (gap-3 = 12px).
  static const double _socialIconLabelGap = 12;
  static const double _inputHeight = 56;
  static const double _inputRadius = 14;
  static const double _backSize = 48;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFBFBFC),
              Color(0xFFFAFAFA),
              Color(0xFFFDF6F8),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Column(
                    children: [
                      _buildLogoSection(),
                      _buildWelcome(),
                      const SizedBox(height: 28),
                      _buildSegmentControl(context),
                      const SizedBox(height: 20),
                      _buildErrorSection(),
                      _buildSocialButtons(context),
                      const SizedBox(height: 24),
                      _buildDivider(context),
                      const SizedBox(height: 24),
                      _buildEmailPasswordForm(context),
                      const SizedBox(height: 28),
                      _buildCtaButton(context),
                      const SizedBox(height: 32),
                      _buildFooter(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final c = Get.find<AuthController>();
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: c.onBack,
            borderRadius: BorderRadius.circular(_backSize / 2),
            child: Container(
              width: _backSize,
              height: _backSize,
              decoration: BoxDecoration(
                color: AppColors.authBackBg,
                shape: BoxShape.circle,
                boxShadow: AppShadows.authBackButton,
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 22, color: AppColors.primaryPurple),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AssetImageWithFallback(
              assetPath: AppAssets.cherishLogo,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              placeholder: Icon(Icons.favorite, size: 40, color: AppColors.pinkAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcome() {
    return Column(
      children: [
        Text(
          'Welcome to Cherish AI',
          textAlign: TextAlign.center,
          style: AppTextStyles.authWelcomeTitle,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('your personal love assistant', style: AppTextStyles.authSubtitle),
            const SizedBox(width: 4),
            Icon(Icons.favorite, size: 16, color: AppColors.primaryPink),
          ],
        ),
      ],
    );
  }

  Widget _buildSegmentControl(BuildContext context) {
    final c = Get.find<AuthController>();
    return Obx(() {
      final isSignUp = c.selectedTab.value == AuthTab.signUp;
      return Container(
        height: _segmentHeight,
        decoration: BoxDecoration(
          color: AppColors.authTabContainerBg,
          borderRadius: BorderRadius.circular(_segmentRadius),
          boxShadow: AppShadows.authCardSubtle,
        ),
        padding: const EdgeInsets.all(6),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: isSignUp ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  width: (MediaQuery.sizeOf(context).width - _horizontalPadding * 2 - 12 - 4) / 2,
                  decoration: BoxDecoration(
                    gradient: AppGradients.authTabAndCta,
                    borderRadius: BorderRadius.circular(_segmentRadius - 8),
                    boxShadow: AppShadows.authCtaShadow,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => c.switchTab(AuthTab.signUp),
                      borderRadius: BorderRadius.circular(_segmentRadius - 8),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: isSignUp
                              ? AppTextStyles.authTabActive
                              : AppTextStyles.authTabInactive,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => c.switchTab(AuthTab.login),
                      borderRadius: BorderRadius.circular(_segmentRadius - 8),
                      child: Center(
                        child: Text(
                          'Login',
                          style: isSignUp
                              ? AppTextStyles.authTabInactive
                              : AppTextStyles.authTabActive,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildErrorSection() {
    return Obx(() {
      final c = Get.find<AuthController>();
      if (c.error.value.isEmpty) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.authErrorBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.authErrorBorder),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, size: 20, color: AppColors.authErrorText),
              const SizedBox(width: 8),
              Expanded(child: Text(c.error.value, style: AppTextStyles.authError)),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSocialButtons(BuildContext context) {
    final c = Get.find<AuthController>();
    return Obx(() {
      final loading = c.isLoading.value;
      return Column(
        children: [
          _socialButton(
            label: 'Continue with Google',
            onTap: loading ? null : c.onTapGoogle,
            leading: _googleIcon(),
          ),
          const SizedBox(height: 14),
          _socialButton(
            label: 'Continue with Facebook',
            onTap: loading ? null : c.onTapFacebook,
            leading: Icon(Icons.facebook_rounded, size: 24, color: const Color(0xFF1877F2)),
          ),
          const SizedBox(height: 14),
          _socialButton(
            label: 'Continue with Apple',
            onTap: loading ? null : c.onTapApple,
            leading: Icon(Icons.apple, size: 24, color: Colors.black),
          ),
        ],
      );
    });
  }

  Widget _googleIcon() {
    return SvgPicture.asset(
      AppAssetsIcons.googleIconSvg,
      width: _googleIconSize,
      height: _googleIconSize,
      fit: BoxFit.contain,
      clipBehavior: Clip.antiAlias,
    );
  }

  Widget _socialButton({
    required String label,
    required VoidCallback? onTap,
    required Widget leading,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_socialRadius),
        child: Container(
          height: _socialHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.authSocialButtonBg,
            borderRadius: BorderRadius.circular(_socialRadius),
            boxShadow: AppShadows.authCardSubtle,
          ),
          child: Row(
            children: [
              leading,
              const SizedBox(width: _socialIconLabelGap),
              Text(label, style: AppTextStyles.authSocialButton),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final c = Get.find<AuthController>();
    return Obx(() {
      final isSignUp = c.selectedTab.value == AuthTab.signUp;
      return Row(
        children: [
          Expanded(child: Container(height: 1, color: AppColors.authDividerLine)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'or ${isSignUp ? 'sign up' : 'login'} with email',
              style: AppTextStyles.authDivider,
            ),
          ),
          Expanded(child: Container(height: 1, color: AppColors.authDividerLine)),
        ],
      );
    });
  }

  Widget _buildEmailPasswordForm(BuildContext context) {
    final c = Get.find<AuthController>();
    return Obx(() {
      final isSignUp = c.selectedTab.value == AuthTab.signUp;
      return Column(
        children: [
          _authTextField(
            controller: c.emailController,
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            enabled: !c.isLoading.value,
          ),
          const SizedBox(height: 14),
          _authTextField(
            controller: c.passwordController,
            hint: isSignUp ? 'Create a password' : 'Enter your password',
            obscureText: true,
            enabled: !c.isLoading.value,
          ),
        ],
      );
    });
  }

  Widget _authTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool enabled = true,
  }) {
    return Container(
      height: _inputHeight,
      decoration: BoxDecoration(
        color: AppColors.authInputBg,
        borderRadius: BorderRadius.circular(_inputRadius),
        border: Border.all(color: AppColors.authInputBorder, width: 2),
        boxShadow: AppShadows.authInputShadow,
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: AppTextStyles.authInput,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.authInput.copyWith(color: AppColors.authInputPlaceholder),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCtaButton(BuildContext context) {
    final c = Get.find<AuthController>();
    return Obx(() {
      final isSignUp = c.selectedTab.value == AuthTab.signUp;
      final loading = c.isLoading.value;
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: loading ? null : c.onSubmitEmailPassword,
          borderRadius: BorderRadius.circular(_inputRadius),
          child: Container(
            height: _socialHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: AppGradients.authTabAndCta,
              borderRadius: BorderRadius.circular(_inputRadius),
              boxShadow: AppShadows.authCtaShadow,
            ),
            child: loading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.9)),
                    ),
                  )
                : Text(
                    isSignUp ? 'Create Account' : 'Login',
                    style: AppTextStyles.authCtaButton,
                  ),
          ),
        ),
      );
    });
  }

  Widget _buildFooter() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          'By continuing, you agree to our Terms of Service and Privacy Policy. Your data is encrypted and secure. We never share your personal information.',
          style: AppTextStyles.authFooter,
        ),
      ),
    );
  }
}

