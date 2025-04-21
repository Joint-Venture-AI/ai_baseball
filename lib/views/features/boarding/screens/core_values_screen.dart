import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/screens/dashboard_personalized_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CoreValuesScreen extends StatelessWidget {
  const CoreValuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    Text(
                      'Let’s start by discovering what drives you! Pick three words that best reflect who you are and what matters most to you.',
                      style: AppStyles.bodySmall,
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your name...',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: AppStyles.cardColor),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: MyTextButton(
                  buttonText: 'Add',
                  onTap: () => Get.to(DashboardPersonalizedScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
