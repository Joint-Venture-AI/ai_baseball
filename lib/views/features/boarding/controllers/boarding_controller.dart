import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
// Remove unused imports if you are removing the multi-step boarding:
// import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
// import 'package:baseball_ai/views/features/main_parent/bottom_nav/main_parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BoardingController extends GetxController {
  // Keep this to show the initial loading indicator on BoardingScreen
  var isShowLoadingSection = RxBool(true);

  // --- Remove or comment out multi-step onboarding variables if no longer needed ---

  var contentIndex = 0.obs;

  List<String> titlesText = [
    'Discover your athletic identity',
    'Unlock Your Potential',
    'Peak performance starts here',
  ];

  List<String> subTitleText = [
    'Understand what drives you-your core values are your compass when is on and everybody’s watching.',
    'Define your goals and map out the steps to achieve greatness.',
    'It’s time to lock it in, define your direction, and take the first step towards finding your daily blueprint',
  ];

  List<String> adviceText = [
    '"l never let winning define me. I define myself by how I carry my character and values, whether I win or lose."__Simone Biles',
    '"Success isn\'t always about greatness. It\'s about consistency. Consistent hard work leads to success."__Dwayne Johnson',
    '"...Results come when you commit to the work nobody sees. "__Alex Rodriguez',
  ];

  // --- End of potentially unused variables ---

  @override
  void onInit() async {
    super.onInit();
    // --- Remove or comment out assertions if variables are removed ---

    assert(
      titlesText.length == subTitleText.length &&
          titlesText.length == adviceText.length,
      "Boarding content lists must have the same number of items.",
    );
    assert(titlesText.length == 3, "Expected 3 boarding screens.");

    // --- End of potentially unused assertions ---

    // Wait for the initial loading period
    await Future.delayed(const Duration(seconds: 3));

    // Show the privacy dialog instead of toggling isShowLoadingSection directly
    showPrivacyDialog();
  }

  // Method to display the dialog matching the image
  void showPrivacyDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2F2F2F), // Dark gray background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // Rounded corners
        ),
        contentPadding: EdgeInsets.zero, // Use custom padding inside content
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Fit content size
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When using Prism Sports Journal, your privacy is our priority. This journal is your personal space to track, reflect and grow-none of your logs, notes, or recordings are ever shared or made public. Everything you input stays fully private accessible only to you.',
                style: AppStyles.bodySmall.copyWith(
                  color: Colors.white.withOpacity(0.85), // Light text color
                  fontSize: 14.sp, // Adjust size as needed
                  height: 1.5, // Adjust line spacing
                ),
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // More Info Button
                  TextButton(
                    onPressed: () {
                      // Define action for "More info" - e.g., open a URL or show another dialog
                      // For now, just closes the dialog if needed, but user must accept eventually
                      print("More info pressed");
                      // Get.back(); // Optionally close dialog, but maybe not useful
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                    ),
                    child: Text(
                      'More info',
                      style: AppStyles.bodyMedium.copyWith(
                        color: Colors.yellow, // Yellow color for text
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),

                  // I Understand Button
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      // Close the dialog first
                      // Navigate to the auth route, replacing the current stack
                      Get.offAllNamed(AppRoute.auth);
                      print("Navigating to /auth");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF4F4F4F,
                      ), // Slightly lighter gray button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r), // Pill shape
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 10.h,
                      ),
                      elevation: 0, // No shadow
                    ),
                    child: Text(
                      'I understand',
                      style: AppStyles.bodyMedium.copyWith(
                        color: Colors.white, // White text
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
  }

  // --- Remove or comment out changeContent if no longer needed ---

  void changeContent() {
    // Check if the current index is the last index
    if (contentIndex.value == titlesText.length - 1) {
      print("Onboarding finished. Navigating to WelcomeScreen...");
      Get.to(() => WelcomeScreen()); // Use function syntax for Get.to
    } else {
      // Not on the last screen yet, just increment the index
      contentIndex.value++;
      print("Moving to content index: ${contentIndex.value}");
    }
  }

  // --- End of potentially unused changeContent ---
}
