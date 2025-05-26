import 'package:baseball_ai/core/utils/const/app_images.dart';
import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    // Add a small delay for better UX (optional)
    await Future.delayed(const Duration(seconds: 2));
    
    try {
      // Get or create AuthController
      final AuthController authController;
      if (Get.isRegistered<AuthController>()) {
        authController = Get.find<AuthController>();
      } else {
        authController = Get.put(AuthController());
      }

      // Check if user has saved token
      if (authController.isLoggedIn) {
        print('📱 Token found, checking user profile...');
          // Try to get user profile with saved token (silently)
        final profileSuccess = await authController.getProfileSilently();
        
        // Check if profile was successfully loaded
        if (profileSuccess && authController.currentUser.value != null) {
          print('✅ User authenticated successfully, navigating to home');
          // User is authenticated, go to main screen
          Get.offAllNamed(AppRoute.main);} else {
          print('❌ Profile loading failed, navigating to auth');
          // Profile loading failed, clear token and go to auth
          authController.clearToken();
          Get.offAllNamed(AppRoute.auth);
        }
      } else {
        print('🔓 No token found, navigating to auth');
        // No token found, go to auth screen
        Get.offAllNamed(AppRoute.auth);
      }
    } catch (e) {
      print('💥 Authentication check failed: $e');
      // On any error, go to auth screen
      Get.offAllNamed(AppRoute.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    // No need for Obx or isShowLoadingSection here.
    // The logo and text are the static splash content.
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.h, // Use ScreenUtil for size
                width: 150.w, // Use ScreenUtil for size
                child: ClipRRect(
                  child: Image.asset(AppImages.appLogo),
                ), // Load your logo
              ),
              SizedBox(height: 10.h),
              Text(
                'Prism',
                style: AppStyles.bodyMedium.copyWith(
                  color: AppStyles.primaryColor,
                  fontSize: 40.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Sports Journal',
                style: AppStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp, // Use ScreenUtil for font size
                  fontWeight: FontWeight.w400,
                ),
              ),
              // The CupertinoActivityIndicator is not in the final splash image sequence,
              // but you can keep it here if you want a brief loading indicator before the dialog.
              // If you want *only* the logo then the dialog, remove this.
              SizedBox(height: 30.h),
              CupertinoActivityIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}


