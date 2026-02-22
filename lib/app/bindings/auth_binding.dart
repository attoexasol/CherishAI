// lib/app/bindings/auth_binding.dart
import 'package:get/get.dart';
import '../../presentation/auth/controllers/auth_controller.dart';

/// Auth screen binding; controller is disposed when route is removed.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: false);
  }
}
