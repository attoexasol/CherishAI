// lib/presentation/loved_ones/controllers/loved_ones_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../models/loved_one_model.dart';

/// Loved Ones list screen state. Data from mock + context (same as React).
/// Only UI wiring; add/edit/delete call existing nav or services.
class LovedOnesController extends GetxController {
  final RxList<LovedOneModel> lovedOnes = <LovedOneModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadLovedOnes();
  }

  void _loadLovedOnes() {
    final mock = [
      const LovedOneModel(id: '1', name: 'Sarah', relationship: 'Partner', emoji: '💑'),
      const LovedOneModel(id: '2', name: 'Mom', relationship: 'Mother', emoji: '👩'),
      const LovedOneModel(id: '3', name: 'Jake', relationship: 'Best Friend', emoji: '🤝'),
      const LovedOneModel(id: '4', name: 'Dad', relationship: 'Father', emoji: '👨'),
      const LovedOneModel(id: '5', name: 'Emma', relationship: 'Sister', emoji: '👧'),
      const LovedOneModel(id: '6', name: 'Alex', relationship: 'Brother', emoji: '👦'),
      const LovedOneModel(id: '7', name: 'Olivia', relationship: 'Friend', emoji: '🌸'),
      const LovedOneModel(id: '8', name: 'Ikh', relationship: 'Friend', emoji: '💑'),
    ];
    lovedOnes.assignAll(mock);
  }

  void onBack() {
    Get.offNamed(AppRoutes.home);
  }

  void onAddLovedOne() {
    Get.toNamed(AppRoutes.individualAddLovedOne);
  }

  void onEditLovedOne(String id) {
    Get.toNamed(AppRoutes.editLovedOne, arguments: {'id': id});
  }

  void onDeleteLovedOne(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Loved One?'),
        content: const Text(
          'Are you sure you want to remove this person? This action cannot be undone.',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _performDelete(id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _performDelete(String id) {
    lovedOnes.removeWhere((e) => e.id == id);
  }

  void onTapLovedOne(String id) {
    Get.toNamed(AppRoutes.lovedOneDetails, arguments: {'id': id});
  }

  void onTapBottomNav(String tab) {
    if (tab == 'loved_ones') return;
    switch (tab) {
      case 'home':
        Get.offNamed(AppRoutes.home);
        break;
      case 'search':
        Get.offNamed(AppRoutes.search);
        break;
      case 'alerts':
        Get.offNamed(AppRoutes.notificationsList);
        break;
      case 'profile':
        Get.offNamed(AppRoutes.profile);
        break;
      default:
        break;
    }
  }

  String get subtitleText {
    final n = lovedOnes.length;
    return n == 1 ? '1 person you cherish' : '$n people you cherish';
  }
}
