// lib/presentation/profile/controllers/profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Profile screen state: view vs edit mode, form fields, stats, and actions.
/// Data load/save matches React: profile from user storage; save writes back; logout clears and navigates to auth.
class ProfileController extends GetxController {
  final RxBool isEditMode = false.obs;

  // Profile data (wire to repository when available; placeholder for now)
  final RxString fullName = 'zfbzcvb'.obs;
  final RxString email = 'john.doe@gmail.com'.obs;
  final RxString phone = ''.obs;
  final RxString selectedCountry = 'Czech Republic'.obs;
  final RxString city = 'zcvbzcvb'.obs;
  final RxString postalCode = 'Z'.obs;
  final RxString stateRegion = ''.obs;
  final RxString streetAddress = ''.obs;
  final RxString accountType = 'Cherish Unlimited'.obs;

  // Stats (placeholder; wire to real data when available)
  final RxInt lovedOnesCount = 12.obs;
  final RxInt momentsCount = 47.obs;
  final RxInt giftsSentCount = 23.obs;
  final RxString lovedOnesDelta = '+2 this month'.obs;
  final RxString momentsDelta = '+8 this week'.obs;
  final RxString giftsSentDelta = '+3 this month'.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();
  final stateRegionController = TextEditingController();
  final streetAddressController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    _syncControllersFromProfile();
  }

  void _syncControllersFromProfile() {
    nameController.text = fullName.value;
    emailController.text = email.value;
    phoneController.text = phone.value;
    cityController.text = city.value;
    postalCodeController.text = postalCode.value;
    stateRegionController.text = stateRegion.value;
    streetAddressController.text = streetAddress.value;
  }

  void toggleEdit() {
    if (isEditMode.value) {
      _syncControllersFromProfile();
    }
    isEditMode.toggle();
  }

  void onSaveChanges() {
    fullName.value = nameController.text.trim();
    email.value = emailController.text.trim();
    phone.value = phoneController.text.trim();
    city.value = cityController.text.trim();
    postalCode.value = postalCodeController.text.trim();
    stateRegion.value = stateRegionController.text.trim();
    streetAddress.value = streetAddressController.text.trim();
    // TODO: persist to storage (same as React: localStorage cherish_users)
    isEditMode.value = false;
  }

  void onManageSubscription() {
    Get.toNamed(AppRoutes.choosePlan);
  }

  void onLogout() {
    Get.dialog(
      AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _performLogout();
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    // TODO: clear storage (same as React: cherish_users, etc.) then navigate
    Get.offAllNamed(AppRoutes.auth);
  }

  void onTapBottomNav(String tab) {
    if (tab == 'profile') return;
    switch (tab) {
      case 'home':
        Get.offNamed(AppRoutes.home);
        break;
      case 'search':
        Get.offNamed(AppRoutes.search);
        break;
      case 'loved_ones':
        Get.offNamed(AppRoutes.lovedOnesList);
        break;
      case 'alerts':
        Get.offNamed(AppRoutes.notificationsList);
        break;
      default:
        break;
    }
  }

  String get membershipLabel => '${accountType.value} Member';

  String get locationDisplay {
    final parts = <String>[];
    if (city.value.isNotEmpty) parts.add(city.value);
    if (postalCode.value.isNotEmpty) parts.add(postalCode.value);
    if (stateRegion.value.isNotEmpty) parts.add(stateRegion.value);
    if (selectedCountry.value.isNotEmpty) parts.add(selectedCountry.value);
    return parts.join(', ');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    stateRegionController.dispose();
    streetAddressController.dispose();
    super.onClose();
  }
}
