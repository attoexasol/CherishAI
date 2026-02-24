// lib/presentation/loved_one_preferences/views/dialogs/add_special_occasion_dialog.dart
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
const double _kTitleToFieldGap = 16;
const double _kFieldGap = 16;
const double _kFieldToButtonsGap = 24;
const double _kButtonGap = 12;
const double _kMaxDialogWidth = 400;

/// Modal dialog: Add Special Occasion. Opens from SPECIAL OCCASIONS section.
/// Submit calls controller.addSpecialOccasion(name, date) then closes.
class AddSpecialOccasionDialog extends StatefulWidget {
  const AddSpecialOccasionDialog({super.key});

  @override
  State<AddSpecialOccasionDialog> createState() => _AddSpecialOccasionDialogState();
}

class _AddSpecialOccasionDialogState extends State<AddSpecialOccasionDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  bool _canSubmit = false;

  @override
  void initState() {
    super.initState();
    void updateCanSubmit() {
      final can = _nameController.text.trim().isNotEmpty && _dateController.text.trim().isNotEmpty;
      if (can != _canSubmit) setState(() => _canSubmit = can);
    }
    _nameController.addListener(updateCanSubmit);
    _dateController.addListener(updateCanSubmit);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _onDateTap() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
        _dateController.text = '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
      });
    }
  }

  void _submit() {
    final name = _nameController.text.trim();
    final dateStr = _dateController.text.trim();
    if (name.isEmpty || dateStr.isEmpty) return;
    Get.find<LovedOnePreferencesController>().addSpecialOccasion(name, dateStr);
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
                  'Add Special Occasion',
                  style: AppTextStyles.prefsDialogTitle,
                ),
                const SizedBox(height: _kTitleToFieldGap),
                TextField(
                  controller: _nameController,
                  style: AppTextStyles.prefsDialogInput,
                  decoration: InputDecoration(
                    hintText: 'e.g., Birthday, Anniversary, Wedding',
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
                const SizedBox(height: _kFieldGap),
                GestureDetector(
                  onTap: _onDateTap,
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _dateController,
                      style: AppTextStyles.prefsDialogInput,
                      decoration: InputDecoration(
                        hintText: 'mm/dd/yyyy',
                        hintStyle: AppTextStyles.prefsDialogInputPlaceholder,
                        filled: true,
                        fillColor: AppColors.prefsDialogBg,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.prefsDialogPlaceholder),
                        ),
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
                              child: Text('Add Occasion', style: AppTextStyles.prefsDialogPrimaryBtn),
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
