// lib/presentation/edit_loved_one/controllers/edit_loved_one_controller.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../app/routes/app_routes.dart';
import '../../onboarding/controllers/individual_step3_relationship_goals_controller.dart';
import '../../onboarding/controllers/individual_step4_secondary_goals_controller.dart';
import '../../loved_one_preferences/models/hobby_category_model.dart';
import '../../dislikes/models/dislike_category_model.dart';
import '../models/edit_loved_one_models.dart';

class EditLovedOneController extends GetxController {
  String _resolvedId = '';

  String get lovedOneId => _resolvedId;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isReady = false.obs;

  final nameCtrl = TextEditingController();
  final personalNoteCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final birthdayCtrl = TextEditingController();
  final anniversaryCtrl = TextEditingController();
  final customDislikeInputCtrl = TextEditingController();

  final RxString relationship = ''.obs;
  final RxString primaryGoalKey = ''.obs;
  final RxList<String> secondaryGoalIds = <String>[].obs;
  final RxMap<String, String> selectedHobbyByCategory = <String, String>{}.obs;
  final RxMap<String, String> selectedDislikeByCategory = <String, String>{}.obs;
  final RxList<String> customDislikes = <String>[].obs;
  final RxList<CustomDateEntry> customDates = <CustomDateEntry>[].obs;
  final RxBool isSaving = false.obs;
  final RxString photoPath = ''.obs;

  final ImagePicker _imagePicker = ImagePicker();

  static const int maxSecondaryGoals = 3;
  static const int maxHobbiesTotal = 8;
  static const int maxDislikesFromCategories = 4;
  static const int maxCustomDislikes = 2;
  static const int maxDislikesTotal = 6;
  static const int personalNoteMaxLength = 300;

  List<RelationshipOption> get relationshipOptions => EditLovedOneData.relationshipOptions;
  List<RelationshipGoalOption> get primaryGoalOptions => RelationshipGoalsData.options;
  List<SecondaryGoalOption> get secondaryGoalOptionsFlat => EditLovedOneData.secondaryGoalsFlat;
  List<SecondaryGoalItemDisplay> get secondaryGoalsWithCategory => EditLovedOneData.secondaryGoalsWithCategory;
  List<HobbyCategoryModel> get hobbyCategories => HobbyCategoriesData.categories;
  List<DislikeCategoryModel> get dislikeCategories => DislikeCategoriesData.categories;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final params = Get.parameters;
    final fromArgs = args is Map ? (args['id'] ?? args['lovedOneId'])?.toString().trim() ?? '' : '';
    final fromParams = params['id'] ?? params['lovedOneId'] ?? '';
    _resolvedId = fromArgs.isNotEmpty ? fromArgs : fromParams;
    if (_resolvedId.isEmpty) {
      isLoading.value = false;
      errorMessage.value = 'No loved one selected.';
      return;
    }
    _loadLovedOne();
    isLoading.value = false;
    isReady.value = true;
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    personalNoteCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    birthdayCtrl.dispose();
    anniversaryCtrl.dispose();
    customDislikeInputCtrl.dispose();
    super.onClose();
  }

  void _loadLovedOne() {
    if (_resolvedId.isEmpty) return;
    nameCtrl.text = 'Sarah';
    relationship.value = 'Partner (dating / committed, not married)';
    birthdayCtrl.text = '1990-01-15';
    anniversaryCtrl.text = '2022-03-20';
    phoneCtrl.text = '+1 234 567 8900';
    emailCtrl.text = '';
    personalNoteCtrl.text = '';
    primaryGoalKey.value = 'deepen_connection';
    secondaryGoalIds.assignAll(['be_present', 'grow_together', 'celebrate_moments']);
    selectedHobbyByCategory['creative'] = 'art';
    selectedHobbyByCategory['food'] = 'cooking';
    selectedHobbyByCategory['experiences'] = 'travel';
    selectedDislikeByCategory['gift_material'] = 'generic_gifts';
    selectedDislikeByCategory['experiences_social'] = 'crowded_places';
    customDislikes.clear();
    customDates.clear();
  }

  void onBack() {
    Get.back();
  }

  Future<void> onSaveTopBar() async {
    await _performSave();
  }

  void onChangePhoto() {
    // Screen shows bottom sheet and then calls pickFromCamera / pickFromGallery.
  }

  Future<void> pickFromCamera() async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (file != null) {
        photoPath.value = file.path;
      }
    } catch (_) {}
  }

  Future<void> pickFromGallery() async {
    try {
      final XFile? file = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        imageQuality: 85,
      );
      if (file != null) {
        photoPath.value = file.path;
      }
    } catch (_) {}
  }

  Future<void> onPickBirthday() async {
    final d = await _pickDate(initial: _parseDate(birthdayCtrl.text));
    if (d != null) birthdayCtrl.text = _formatDate(d);
  }

  Future<void> onPickAnniversary() async {
    final d = await _pickDate(initial: _parseDate(anniversaryCtrl.text));
    if (d != null) anniversaryCtrl.text = _formatDate(d);
  }

  void onAddImportantDate() {
    customDates.add(CustomDateEntry(id: DateTime.now().millisecondsSinceEpoch.toString(), occasion: '', date: ''));
    customDates.refresh();
  }

  void onRemoveCustomDate(String id) {
    customDates.removeWhere((e) => e.id == id);
    customDates.refresh();
  }

  void onUpdateCustomDate(String id, String field, String value) {
    final idx = customDates.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    final e = customDates[idx];
    final updated = CustomDateEntry(
      id: e.id,
      occasion: field == 'occasion' ? value : e.occasion,
      date: field == 'date' ? value : e.date,
    );
    customDates[idx] = updated;
    customDates.refresh();
  }

  Future<void> onPickCustomDate(String id) async {
    final idx = customDates.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    final e = customDates[idx];
    final d = await _pickDate(initial: _parseDate(e.date));
    if (d != null) {
      onUpdateCustomDate(id, 'date', _formatDate(d));
    }
  }

  void onSelectPrimaryGoal(String key) {
    primaryGoalKey.value = key;
  }

  void onToggleSecondaryGoal(String goalId) {
    if (secondaryGoalIds.contains(goalId)) {
      secondaryGoalIds.remove(goalId);
    } else if (secondaryGoalIds.length < maxSecondaryGoals) {
      secondaryGoalIds.add(goalId);
    }
    secondaryGoalIds.refresh();
  }

  void onToggleHobby(String categoryKey, String hobbyId) {
    final current = selectedHobbyByCategory[categoryKey];
    final totalCount = selectedHobbyByCategory.values.length - (current != null ? 1 : 0);
    if (current == hobbyId) {
      selectedHobbyByCategory.remove(categoryKey);
    } else if (current == null && totalCount < maxHobbiesTotal) {
      selectedHobbyByCategory[categoryKey] = hobbyId;
    }
    selectedHobbyByCategory.refresh();
  }

  void onToggleDislike(String categoryKey, String dislikeId) {
    final current = selectedDislikeByCategory[categoryKey];
    if (current == dislikeId) {
      selectedDislikeByCategory.remove(categoryKey);
    } else {
      selectedDislikeByCategory[categoryKey] = dislikeId;
    }
    selectedDislikeByCategory.refresh();
  }

  void onAddCustomDislike() {
    final text = customDislikeInputCtrl.text.trim();
    if (text.isEmpty || customDislikes.length >= maxCustomDislikes) return;
    customDislikes.add(text);
    customDislikeInputCtrl.clear();
    customDislikes.refresh();
  }

  void onRemoveCustomDislike(String item) {
    customDislikes.remove(item);
    customDislikes.refresh();
  }

  Future<void> onSaveChanges() async {
    await _performSave();
  }

  Future<void> _performSave() async {
    if (isSaving.value) return;
    isSaving.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      Get.offNamed(AppRoutes.lovedOneDetails, arguments: {'id': lovedOneId});
    } finally {
      isSaving.value = false;
    }
  }

  int get totalHobbies => selectedHobbyByCategory.length;
  int get totalDislikes => selectedDislikeByCategory.length + customDislikes.length;
  bool get canAddSecondaryGoal => secondaryGoalIds.length < maxSecondaryGoals;
  bool get canAddCustomDislike => customDislikes.length < maxCustomDislikes && totalDislikes < maxDislikesTotal;

  DateTime? _parseDate(String s) {
    if (s.isEmpty) return null;
    return DateTime.tryParse(s);
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<DateTime?> _pickDate({DateTime? initial}) async {
    final ctx = Get.context;
    if (ctx == null) return null;
    return showDatePicker(
      context: ctx,
      initialDate: initial ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  bool get hasLocalPhoto {
    final path = photoPath.value;
    if (path.isEmpty) return false;
    try {
      return File(path).existsSync();
    } catch (_) {
      return false;
    }
  }
}
