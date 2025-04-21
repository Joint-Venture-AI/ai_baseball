import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/screens/core_values_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.h, top: 20.h),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: AppStyles.headingLarge.copyWith(fontSize: 48.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Select 6 words that best represent your core values',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppStyles.subtitleColor,
                  ),
                ),
                SizedBox(height: 30.h),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: AppStyles.bodyMedium),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text('Email', style: AppStyles.bodyMedium),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text('Level of Sport', style: AppStyles.bodyMedium),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'school,college etc',
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text('Player Type', style: AppStyles.bodyMedium),
                      Text('Player Type', style: AppStyles.bodyMedium),

                      SizedBox(height: 10.h),

                      Container(
                        decoration: BoxDecoration(
                          color: AppStyles.cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ai Guidance', style: AppStyles.bodyMedium),
                              Text(
                                '"Prism Sports Joumal is designed to empower athletes to log their daily habitsand workloads, ensuring they can track their progress and reflect on their performance throughout a long, challenging season. Meanwhile, Coach PJ, your Al coach, continuously monitors and logs this information on the backend to provide guidance, keep you consistent, and offer support when you\'re feeling lost',
                                style: AppStyles.bodySmall.copyWith(
                                  color: AppStyles.subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      MyTextButton(
                        buttonText: 'Next',
                        onTap: () => Get.to(CoreValuesScreen()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
