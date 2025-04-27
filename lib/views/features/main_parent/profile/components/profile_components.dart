import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileComponents {
  static Future<void> showLogOutSheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: AppStyles.primaryColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppStyles.secondaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 38.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppStyles.hintTextColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Logout',
                style: AppStyles.headingLarge.copyWith(
                  color: Colors.red,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Divider(thickness: 1, color: AppStyles.hintTextColor),
              SizedBox(height: 15.h),
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: AppStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppStyles.backgroundColor,
                        ), // Blue outline
                        backgroundColor: Colors.white, // White background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            24.r,
                          ), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppStyles.bodySmall.copyWith(
                          color: Colors.black, // Blue text
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: MyTextButton(
                      buttonText: 'Yes, Logout',
                      onTap: () => Navigator.pop(context),
                      isOutline: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
