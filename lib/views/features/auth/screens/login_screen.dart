import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/screens/forget_pass_screen.dart';
import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// Convert to StatefulWidget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State variable to track password visibility
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: AppStyles.headingLarge.copyWith(fontSize: 40.sp),
            ),
            SizedBox(height: 15.h),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email', style: AppStyles.bodySmall),
                  SizedBox(height: 8.h),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your email...',
                      // You might want to add specific styling for your inputs here
                      // matching your AppStyles if needed.
                    ),
                    keyboardType:
                        TextInputType.emailAddress, // Good practice for email
                  ),
                  SizedBox(height: 10.h),
                  Text('Password', style: AppStyles.bodySmall),
                  SizedBox(height: 8.h),
                  TextFormField(
                    obscureText: !_isPasswordVisible, // Control visibility
                    decoration: InputDecoration(
                      hintText: 'Enter your password...',
                      // Add the suffix icon (the eye)
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Choose icon based on visibility state
                          _isPasswordVisible
                              ? Icons
                                  .visibility_off // Icon when visible
                              : Icons.visibility, // Icon when obscured
                          color: Colors.grey, // Adjust color as needed
                        ),
                        onPressed: () {
                          // Toggle the state when the icon is pressed
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(ForgetPassScreen()),
                child: Text(
                  'Forget Password', // Consider making this a TextButton for interaction
                  style: AppStyles.bodySmall.copyWith(
                    color: AppStyles.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            MyTextButton(
              buttonText: 'Login',
              onTap: () => Get.toNamed(AppRoute.main),
              isOutline: false,
            ),
            SizedBox(height: 15.h),
            Row(
              // Consider making SignUp tappable with GestureDetector or TextButton.rich
              children: [
                Text('I dont\'t have an account?', style: AppStyles.bodySmall),
                TextButton(
                  onPressed: () => Get.to(WelcomeScreen()),
                  child: Text(
                    ' SignUp',
                    style: AppStyles.bodySmall.copyWith(
                      color: AppStyles.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
