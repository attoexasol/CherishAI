// lib/presentation/business_dashboard/settings/controllers/business_account_settings_controller.dart
import 'package:get/get.dart';
import '../../../../../app/routes/app_routes.dart';

class BusinessAccountSettingsController extends GetxController {
  void openDialog() {}

  void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back<void>();
    }
  }

  void onTapManageSubscription() {
    closeDialog();
    Get.toNamed(AppRoutes.businessManageSubscription);
  }

  void onTapUserProfile() {
    closeDialog();
    Get.toNamed(AppRoutes.businessProfile);
  }

  void onTapHelpFeedback() {
    closeDialog();
    Get.toNamed(AppRoutes.helpFeedback);
  }

  void onTapLogout() {
    closeDialog();
    Get.offAllNamed(AppRoutes.auth);
  }
}
