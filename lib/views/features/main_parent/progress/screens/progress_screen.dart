import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/glob_widgets/glob_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

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
          children: [
            Text(
              'On a scale of 1 to 10, how did today go?',
              style: AppStyles.bodyMedium.copyWith(fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }
}
