import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/controllers/boarding_controller.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BoardingScreen extends StatelessWidget {
  BoardingScreen({super.key});
  final boardingController = Get.find<BoardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        boardingController.isShowLoadingSection.value
                            ? 'Welcome to Prism Sports Journal'
                            : boardingController.titlesText[boardingController
                                .contentIndex
                                .value],
                        style: AppStyles.headingLarge.copyWith(fontSize: 32.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25.h),
                      boardingController.isShowLoadingSection.value != true
                          ? Text(
                            boardingController.subTitleText[boardingController
                                .contentIndex
                                .value],
                            style: AppStyles.bodySmall.copyWith(
                              color: AppStyles.subtitleColor,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.center,
                          )
                          : SizedBox(),
                    ],
                  ),
                ),
                boardingController.isShowLoadingSection.value
                    ? CupertinoActivityIndicator(color: Colors.white)
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          boardingController.adviceText[boardingController
                              .contentIndex
                              .value],
                          style: AppStyles.bodySmall.copyWith(
                            color: AppStyles.subtitleColor,
                            fontStyle: FontStyle.italic,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30.h),
                        MyTextButton(
                          buttonText: 'Next',
                          onTap: () => boardingController.changeContent(),
                        ),
                      ],
                    ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
