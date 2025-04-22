import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/main_parent/progress/controller/progress_controller.dart';
import 'package:baseball_ai/views/glob_widgets/glob_widget_helper.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final progressController = Get.put(ProgressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobWidgetHelper.showAppBar(
        false,
        'Post Performance/Game Tracker',
        false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'On a scale of 1 to 10, how did today go?',
              style: AppStyles.bodyMedium.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: Slider(
                      max: 10,
                      min: 0,
                      value: progressController.todayScale.value.toDouble(),
                      activeColor: AppStyles.primaryColor,
                      inactiveColor: AppStyles.hintTextColor,
                      onChanged: (v) {
                        progressController.todayScale.value = v.toInt();
                      },
                    ),
                  ),
                  Text(
                    progressController.todayScale.value.toString(),
                    style: AppStyles.bodySmall,
                  ),
                ],
              );
            }),
            Text(
              'Was your workload in a controlled environment(bullpen/batting practice) or in-game?',
              style: AppStyles.bodySmall.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            Text(
              'If you pitched in game today, what were the results of the outing? Type ‘skip’ if you don’t want to submit results.',
              style: AppStyles.bodySmall.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 10.h),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: AppStyles.bodySmall,
                    decoration: InputDecoration(
                      hintText: 'Describe how you\'re feeling today...',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'What was your primary takeaway from today?',
                    style: AppStyles.bodySmall.copyWith(fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    style: AppStyles.bodySmall,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Describe how you\'re feeling today...',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              child: MyTextButton(
                isOutline: false,
                buttonText: 'Submit',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
