import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final AuthController authController = Get.find<AuthController>();
  String _otpCode = '';

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
          'Verify',
          style: AppStyles.bodyMedium.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [                  Obx(() => Text(
                    'Code has been sent to ${authController.forgotPasswordEmail.value}',
                    style: AppStyles.bodySmall,
                  )),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: OtpTextField(
                      fieldHeight: 45.h,
                      fieldWidth: 35.w,
                      numberOfFields: 6,
                      textStyle: AppStyles.bodySmall,
                      borderColor: AppStyles.cardColor,
                      focusedBorderColor: AppStyles.primaryColor,
                      showFieldAsBox: true,
                      borderRadius: BorderRadius.circular(8.r),
                      onCodeChanged: (String code) {
                        _otpCode = code;
                      },
                      onSubmit: (String verificationCode) {
                        _handleVerifyOtp(verificationCode);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // Resend Code Button
            TextButton(
              onPressed: () => _handleResendCode(),
              child: Text(
                'Resend Code',
                style: AppStyles.bodySmall.copyWith(
                  color: AppStyles.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 160.h),
            Obx(() => MyTextButton(
              buttonText: authController.isVerifyEmailLoading.value 
                  ? 'Verifying...' 
                  : 'Verify',
              onTap: authController.isVerifyEmailLoading.value
                  ? () {}
                  : () => _handleVerifyOtp(_otpCode),
              isOutline: false,
            )),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  void _handleVerifyOtp(String otp) {
    if (otp.length != 6) {
      Get.snackbar(
        'Invalid Code',
        'Please enter the complete 6-digit verification code',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    authController.verifyEmail(
      email: authController.forgotPasswordEmail.value,
      oneTimeCode: otp,
    );
  }

  void _handleResendCode() {
    authController.forgotPassword(
      email: authController.forgotPasswordEmail.value,
    );
  }
}
