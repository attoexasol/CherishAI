// lib/presentation/loved_one_preferences/views/dialogs/add_custom_hobby_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/theme/app_colors.dart';
import '../../../../../app/theme/app_text_styles.dart';
import '../../../../../app/theme/app_gradients.dart';
import '../../../../../app/theme/app_shadows.dart';
import '../../controllers/loved_one_preferences_controller.dart';

const double _kDialogRadius = 20;
const double _kDialogPadding = 24;
const double _kInputRadius = 12;
const double _kButtonHeight = 48;
const double _kButtonRadius = 12;
const double _kTitleToFieldGap = 20;
const double _kFieldToButtonsGap = 24;
const double _kButtonGap = 12;
const double _kMaxDialogWidth = 400;

/// Modal dialog: Add Custom Hobby. Opens from Hobbies section "Add Custom Hobby" button.
/// Submit calls controller.addCustomHobby(name) then closes.
class AddCustomHobbyDialog extends StatefulWidget {
  const AddCustomHobbyDialog({super.key});

  @override
  State<AddCustomHobbyDialog> createState() => _AddCustomHobbyDialogState();
}

class _AddCustomHobbyDialogState extends State<AddCustomHobbyDialog> {
  final TextEditingController _hobbyController = TextEditingController();
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    _hobbyController.addListener(() {
      final can = _hobbyController.text.trim().isNotEmpty;
      if (can != _canSubmit) setState(() => _canSubmit = can);
    });
  }

  @override
  void dispose() {
    _hobbyController.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _hobbyController.text.trim();
    if (name.isEmpty) return;
    Get.find<LovedOnePreferencesController>().addCustomHobby(name);
    Get.back();
  }

  void _cancel() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _kMaxDialogWidth),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.prefsDialogBg,
            borderRadius: BorderRadius.circular(_kDialogRadius),
            boxShadow: AppShadows.prefsDialogShadow,
          ),
          padding: const EdgeInsets.all(_kDialogPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add Custom Hobby',
                  style: AppTextStyles.prefsDialogTitle,
                ),
                const SizedBox(height: _kTitleToFieldGap),
                TextField(
                  controller: _hobbyController,
                  style: AppTextStyles.prefsDialogInput,
                  decoration: InputDecoration(
                    hintText: 'e.g., Stargazing, Collecting vinyl, Urban gardening',
                    hintStyle: AppTextStyles.prefsDialogInputPlaceholder,
                    filled: true,
                    fillColor: AppColors.prefsDialogBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(_kInputRadius),
                      borderSide: const BorderSide(color: AppColors.prefsDialogInputBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(_kInputRadius),
                      borderSide: const BorderSide(color: AppColors.prefsDialogInputBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(_kInputRadius),
                      borderSide: const BorderSide(color: AppColors.prefsAddButtonBorder, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: _kFieldToButtonsGap),
                Row(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: _canSubmit ? 1 : 0.5,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _canSubmit ? _submit : null,
                            borderRadius: BorderRadius.circular(_kButtonRadius),
                            child: Container(
                              height: _kButtonHeight,
                              decoration: BoxDecoration(
                                gradient: AppGradients.prefsCta,
                                borderRadius: BorderRadius.circular(_kButtonRadius),
                                boxShadow: AppShadows.prefsCta,
                              ),
                              alignment: Alignment.center,
                              child: Text('Add Hobby', style: AppTextStyles.prefsDialogPrimaryBtn),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: _kButtonGap),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _cancel,
                        borderRadius: BorderRadius.circular(_kButtonRadius),
                        child: Container(
                          height: _kButtonHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: AppColors.prefsDialogBg,
                            borderRadius: BorderRadius.circular(_kButtonRadius),
                            border: Border.all(color: AppColors.prefsDialogCancelBorder),
                          ),
                          alignment: Alignment.center,
                          child: Text('Cancel', style: AppTextStyles.prefsDialogCancelBtn),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
