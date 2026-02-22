// lib/presentation/auth/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

enum AuthTab { signUp, login }

/// Flow: auth ← onboarding intro; success → user type.
class AuthController extends GetxController {
  final Rx<AuthTab> selectedTab = AuthTab.signUp.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void switchTab(AuthTab tab) {
    selectedTab.value = tab;
    error.value = '';
  }

  /// Same as React: navigate('/') — go to app root (onboarding intro).
  void onBack() {
    Get.offAllNamed(AppRoutes.onboardingIntro);
  }

  Future<void> onTapGoogle() async {
    error.value = '';
    isLoading.value = true;
    try {
      // TODO: wire oauthLogin('google') when auth service exists; same contract as React
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offNamed(AppRoutes.userType);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onTapFacebook() async {
    error.value = '';
    isLoading.value = true;
    try {
      // TODO: wire oauthLogin('facebook')
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offNamed(AppRoutes.userType);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onTapApple() async {
    error.value = '';
    isLoading.value = true;
    try {
      // TODO: wire oauthLogin('apple')
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offNamed(AppRoutes.userType);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubmitEmailPassword() async {
    error.value = '';
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      error.value = 'Please enter email and password';
      return;
    }
    isLoading.value = true;
    try {
      // TODO: wire signUp(email, password) or login(email, password) when auth service exists
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offNamed(AppRoutes.userType);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
