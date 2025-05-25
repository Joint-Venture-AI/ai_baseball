import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.cardColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Forgot Password',
          style: AppStyles.bodyMedium.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Reset Your Password',
                  style: AppStyles.bodyMedium.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Please enter your email to receive verification code',
                  style: AppStyles.bodySmall,
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: authController.forgotPasswordEmailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppStyles.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: AppStyles.bodySmall.copyWith(
                      color: AppStyles.hintTextColor,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                Obx(() => MyTextButton(
                  buttonText: authController.isForgotPasswordLoading.value 
                      ? 'Sending...' 
                      : 'Send Code',
                  onTap: authController.isForgotPasswordLoading.value
                      ? () {}
                      : () => _handleForgotPassword(),
                  isOutline: false,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleForgotPassword() {
    if (_formKey.currentState!.validate()) {
      authController.forgotPassword(
        email: authController.forgotPasswordEmailController.text.trim(),
      );
    }
  }
}
