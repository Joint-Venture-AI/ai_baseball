import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/views/features/auth/screens/pass_set_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final bool isForgetPass;
  OtpScreen({super.key, required this.email, required this.isForgetPass});
  final authContrller = Get.find<AuthController>();
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
                children: [
                  Text(
                    'Code has been send to $email',
                    style: AppStyles.bodySmall,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: OtpTextField(
                      fieldHeight: 61.h,
                      fieldWidth: 71.w,
                      numberOfFields: 4,
                      borderColor: Color.fromARGB(255, 34, 31, 41),
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      // onSubmit: (String verificationCode) async {
                      //   authContrller.otpController.text = verificationCode;
                      //   await authContrller.verifyOtp(
                      //     email,
                      //     verificationCode,
                      //     isForgetPass,
                      //   );
                      // }, // end onSubmit
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 180.h),
            MyTextButton(
              buttonText: 'Verify',
              onTap: () => Get.to(PassSetScreen()),
              isOutline: false,
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
