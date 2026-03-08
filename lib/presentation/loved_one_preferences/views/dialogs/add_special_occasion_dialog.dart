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

/// Modal dialog: Add Special Occasion. Uses controller's occasionNameController,
/// selectedOccasionDate, addOccasion(), pickOccasionDate(context).
class AddSpecialOccasionDialog extends StatelessWidget {
  const AddSpecialOccasionDialog({Key? key}) : super(key: key);

  static String _formatDate(DateTime d) {
    return '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LovedOnePreferencesController>();
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
                  controller: c.occasionNameController,
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
                  onTap: () => c.pickOccasionDate(context),
                  child: Obx(() {
                    final date = c.selectedOccasionDate.value;
                    final text = date != null ? _formatDate(date) : '';
                    return Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.prefsDialogBg,
                        borderRadius: BorderRadius.circular(_kInputRadius),
                        border: Border.all(color: AppColors.prefsDialogInputBorder),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              text.isEmpty ? 'mm/dd/yyyy' : text,
                              style: text.isEmpty
                                  ? AppTextStyles.prefsDialogInputPlaceholder
                                  : AppTextStyles.prefsDialogInput,
                            ),
                          ),
                          Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.prefsDialogPlaceholder),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: _kFieldToButtonsGap),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => c.addOccasion(),
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
                    const SizedBox(width: _kButtonGap),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Get.back(),
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
