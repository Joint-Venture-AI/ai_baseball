import 'package:baseball_ai/core/utils/const/app_images.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/controllers/boarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BoardingScreen extends StatelessWidget {
  BoardingScreen({super.key});
  // Ensure BoardingController is registered with GetX (e.g., in main.dart or using bindings)
  final boardingController = Get.find<BoardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppStyles.backgroundColor, // Use your defined background color
      body: SafeArea(
        child: Center(
          // Centering the indicator might be cleaner now
          child: Obx(() {
            return boardingController.isShowLoadingSection.value
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150.h,
                      width: 150.w,
                      child: ClipRRect(child: Image.asset(AppImages.appLogo)),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Prism',
                      style: AppStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Sports Journal',
                      style: AppStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    CupertinoActivityIndicator(color: Colors.white),
                  ],
                )
                : Container(); // Display nothing once loading is technically "done" (dialog handles next step)
          }),
        ),
      ),
    );
  }
}
