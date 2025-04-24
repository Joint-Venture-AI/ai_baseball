import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/screens/otp_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.cardColor,
        title: Text('Forget Password', style: AppStyles.bodyMedium),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forget Password',
                style: AppStyles.bodyMedium.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 5.h),
              Text('Please enter your email here', style: AppStyles.bodySmall),
              SizedBox(height: 10.h),
              TextField(
                decoration: InputDecoration(hintText: 'Input your email'),
              ),
              SizedBox(height: 10.h),
              MyTextButton(
                buttonText: 'Submit',
                onTap:
                    () => Get.to(
                      OtpScreen(email: 'email@gmail.com', isForgetPass: true),
                    ),
                isOutline: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
