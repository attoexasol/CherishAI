// lib/presentation/account_settings/controllers/account_settings_controller.dart
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../views/account_settings_dialog.dart';

/// Controller for Account Settings modal. Opens dialog and routes row taps to existing routes.
class AccountSettingsController extends GetxController {
  void openDialog() {
    Get.dialog<void>(
      const AccountSettingsDialog(),
      barrierDismissible: true,
      barrierColor: AppColors.accountSettingsBarrier,
    );
  }

  void closeDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back<void>();
    }
  }

  void onTapManageSubscription() {
    closeDialog();
    Get.toNamed(AppRoutes.manageSubscription);
  }

  void onTapUserProfile() {
    closeDialog();
    Get.toNamed(AppRoutes.profile);
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
