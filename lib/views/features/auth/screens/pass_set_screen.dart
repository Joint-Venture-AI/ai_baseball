import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/screens/login_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

class PassSetScreen extends StatelessWidget {
  const PassSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.cardColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          'Reset Password',
          style: AppStyles.bodyMedium.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Set your password', style: AppStyles.bodyMedium),
              Text('Enter your new password', style: AppStyles.bodySmall),
              SizedBox(height: 10.h),
              TextField(
                decoration: InputDecoration(hintText: 'Enter password'),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(hintText: 'Re-enter password'),
              ),
              SizedBox(height: 20.h),
              MyTextButton(
                buttonText: 'Reset Now',
                onTap: () => Get.offAll(LoginScreen()),
                isOutline: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
