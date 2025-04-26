import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/screens/intro_screen.dart';
import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextButton(
              isOutline: false,
              buttonText: 'SignIn',
              onTap: () => Get.toNamed(AppRoute.signIn),
            ),
            SizedBox(height: 10.h),
            MyTextButton(
              isOutline: true,
              buttonText: 'SignUp',
              onTap: () => Get.to(IntroScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
