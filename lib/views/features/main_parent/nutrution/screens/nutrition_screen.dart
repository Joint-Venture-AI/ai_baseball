import 'package:baseball_ai/views/features/main_parent/nutrution/controller/nutrution_controller.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NutritionScreen extends StatelessWidget {
  NutritionScreen({super.key});

  final nutritionController = Get.put(NutrutionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.cardColor,
        leading: SizedBox.shrink(),
        title: Text('Nutrition', style: AppStyles.headingTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Track your eating habits', style: AppStyles.bodyText),
                SizedBox(height: 10.h),
                _buildSliderSection(
                  label:
                      'On a scale of 1 to 10, how on top of your nutrition do you feel you were today?',
                  value: nutritionController.feelValue.value,
                  onChanged: (v) {
                    nutritionController.feelValue.value = v;
                  },
                  context: context,
                ),
                SizedBox(height: 10.h),
                _buildSliderSection(
                  label:
                      'On a scale of 1 to 10, how well do you feel you did with your protein intake?',
                  value: nutritionController.proteinValue.value,
                  onChanged: (v) {
                    nutritionController.proteinValue.value = v;
                  },
                  context: context,
                ),
                SizedBox(height: 10.h),
                _buildSliderSection(
                  label:
                      'On a scale of 1 to 10, how well do you feel you met your caloric intake needs?',
                  value: nutritionController.caloricValue.value,
                  onChanged: (v) {
                    nutritionController.caloricValue.value = v;
                  },
                  context: context,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Did you consume anything that might impede your ability to recover the next day? (e.g., alcohol)',
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Yes',
                      activeColor: AppStyles.primaryColor,
                      groupValue: nutritionController.recoverNextDay.value,
                      onChanged: (value) {
                        if (value != null) {
                          nutritionController.recoverNextDay.value = value;
                        }
                      },
                    ),
                    Text('Yes', style: AppStyles.bodyText),
                    SizedBox(width: 10.w),
                    Radio<String>(
                      value: 'No',
                      activeColor: AppStyles.primaryColor,

                      groupValue: nutritionController.recoverNextDay.value,
                      onChanged: (value) {
                        if (value != null) {
                          nutritionController.recoverNextDay.value = value;
                        }
                      },
                    ),
                    Text('No', style: AppStyles.bodyText),
                  ],
                ),
                SizedBox(height: 15.h),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppStyles.cardColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nutrition Tips:', style: AppStyles.headingTitle),
                        SizedBox(height: 5.h),
                        Text(
                          'Aim for 1.6-2.2g of protein per kg of bodyweight \nStay hydrated throughout the day \nConsume carbohydrates before and after training \nConsider timing your nutrition around your training schedule',
                          style: AppStyles.bodyText.copyWith(
                            color: AppStyles.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),                ),
                SizedBox(height: 15.h),
                Obx(() => MyTextButton(
                  buttonText: nutritionController.isSubmitting.value 
                      ? 'Submitting...' 
                      : 'Submit',
                  onTap: nutritionController.isSubmitting.value
                      ? () {}
                      : () => nutritionController.submitNutritionData(),
                  isOutline: false,
                )),

                SizedBox(height: 50.h),
              ],
            );
          }),
        ),
      ),
    );
  }

  ///====>>>> SliderHelperWidget<<<<<<=========///
  Widget _buildSliderSection({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.labelText),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppStyles.primaryColor,
                  inactiveTrackColor: AppStyles.sliderInactiveColor.withOpacity(
                    0.5,
                  ),
                  trackHeight: 6.0, // Thickness of the track
                  thumbColor: Colors.white, // Color of the draggable thumb
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10.0,
                  ), // Size of the thumb
                  overlayColor: AppStyles.primaryColor.withAlpha(
                    0x29,
                  ), // Color when interacting
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 20.0,
                  ), // Size of the overlay
                  trackShape:
                      const RoundedRectSliderTrackShape(), // Makes track ends rounded
                ),
                child: Slider(
                  value: value,
                  min: 0.0,
                  max: 10.0,
                  divisions: 9, // Allows snapping to integers 1 through 10
                  // label: value.round().toString(), // Shows label on drag (optional)
                  onChanged: onChanged,
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Text(
              value.round().toString(), // Display the rounded integer value
              style: AppStyles.sliderValueText,
            ),
          ],
        ),
      ],
    );
  }
}
