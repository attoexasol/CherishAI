// lib/presentation/edit_loved_one/bindings/edit_loved_one_binding.dart
import 'package:get/get.dart';
import '../controllers/edit_loved_one_controller.dart';

/// Route-specific binding for Edit Loved One screen.
/// Ensures EditLovedOneController is registered before the screen builds.
class EditLovedOneBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<EditLovedOneController>()) {
      Get.put<EditLovedOneController>(
        EditLovedOneController(),
        permanent: false,
      );
    }
  }
}
