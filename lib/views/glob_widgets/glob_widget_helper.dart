import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GlobWidgetHelper {
  static AppBar showAppBar(
    bool showActionsWidget,
    String titleText,
    bool isBack,
  ) {
    return AppBar(
      backgroundColor: AppStyles.cardColor,
      leading:
          isBack
              ? InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  AppIcons.back,
                  color: Colors.white,
                  width: 24.w,
                  height: 24.h,
                ),
              )
              : SizedBox(),
      title: Text(titleText, style: AppStyles.bodyMedium),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child:
              showActionsWidget
                  ? CircleAvatar(
                    backgroundColor: AppStyles.cardColor,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppIcons.bell,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Handle notification tap
                      },
                    ),
                  )
                  : SizedBox(),
        ),
      ],
    );
  }
}
