import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Convert to StatefulWidget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State variable to track password visibility
  bool _isPasswordVisible = false;
  
  // Get AuthController instance
  final AuthController authController = Get.find<AuthController>();
  
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      authController.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Email', style: AppStyles.bodySmall),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _emailController,
                    style: AppStyles.bodySmall,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your email...',
                      // You might want to add specific styling for your inputs here
                      // matching your AppStyles if needed.
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text('Password', style: AppStyles.bodySmall),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _passwordController,
                    style: AppStyles.bodySmall,
                    obscureText: !_isPasswordVisible, // Control visibility
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
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
                onPressed: () => Get.toNamed(AppRoute.forgotPassword),
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppStyles.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Obx(() => MyTextButton(
              buttonText: authController.isLoginLoading.value ? 'Logging in...' : 'Login',
              onTap: authController.isLoginLoading.value ? () {} : _handleLogin,
              isOutline: false,
            )),
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
