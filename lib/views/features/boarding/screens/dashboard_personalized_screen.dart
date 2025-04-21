import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/main_parent/bottom_nav/controllers/main_parent_controller.dart';
import 'package:baseball_ai/views/features/main_parent/bottom_nav/main_parent_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DashboardPersonalizedScreen extends StatelessWidget {
  const DashboardPersonalizedScreen({super.key});

  // Helper widget for the value cards to avoid repetition
  Widget _buildValueCard(
    BuildContext context,
    String iconPath,
    String title,
    String description,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.cardColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppStyles.borderColor, width: 0.5),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w), // Slightly adjusted padding
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppStyles.secondaryColor, // Teal-ish background
                shape: BoxShape.circle, // Make it circular
              ),
              child: Padding(
                padding: EdgeInsets.all(14.w), // Padding inside circle
                child: SvgPicture.asset(
                  // Assuming you have flutter_svg
                  iconPath,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    AppStyles.primaryColor,
                    BlendMode.srcIn,
                  ), // Make icon yellow
                ),
              ),
            ),
            SizedBox(width: 12.w), // Increased spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyles.bodyMedium.copyWith(fontSize: 18.sp),
                  ), // Slightly larger title
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: AppStyles.bodySmall.copyWith(
                      color: AppStyles.hintTextColor,
                      fontSize: 13.sp, // Slightly smaller desc
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for table rows
  Widget _buildTableRow(String sectionName, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2, // Give section name slightly less space
            child: Text(
              sectionName,
              style: AppStyles.bodySmall.copyWith(
                fontSize: 14.sp,
                color: AppStyles.textPrimaryColor,
                fontWeight: FontWeight.w500, // Medium weight
              ),
            ),
          ),
          SizedBox(width: 10.w), // Space between columns
          Expanded(
            flex: 3, // Give description more space
            child: Text(
              description,
              style: AppStyles.bodySmall.copyWith(
                fontSize: 13.sp, // Smaller description text
                color: AppStyles.hintTextColor, // Grey description
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil (usually done in MaterialApp)
    // ScreenUtil.init(context, designSize: const Size(375, 812)); // Example size

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Column(
          // Use Column + Expanded ListView/SingleChildScrollView for button fixed at bottom
          children: [
            Expanded(
              // Make the scrollable content take available space
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ), // Consistent padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      Text(
                        'You\'re all set! Your journey begins now.', // Added period
                        style: AppStyles.headingLarge.copyWith(
                          fontSize: 26.sp,
                        ), // Use heading style
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Explaining the importance of journaling and tracking progress.',
                        style: AppStyles.bodySmall.copyWith(
                          fontSize: 14.sp,
                          color: AppStyles.hintTextColor, // Grey subtitle
                        ),
                      ),
                      SizedBox(height: 30.h), // More space
                      Text(
                        'Your Core Values in Action',
                        style: AppStyles.bodyMedium.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 15.h),

                      ///action_cards
                      _buildValueCard(
                        context,
                        AppIcons.timer,
                        'Focus',
                        'Discipline keeps you committed to your routines, ensuring consistency and long-term success',
                      ),
                      SizedBox(height: 12.h), // Consistent spacing
                      _buildValueCard(
                        context,
                        AppIcons.timer,
                        'Adaptability',
                        'Discipline keeps you committed to your routines, ensuring consistency and long-term success',
                      ),
                      SizedBox(height: 12.h),
                      _buildValueCard(
                        context,
                        AppIcons.timer,
                        'Growth',
                        'Discipline keeps you committed to your routines, ensuring consistency and long-term success',
                      ),

                      SizedBox(height: 30.h), // More space before next section
                      // --- Swapped Text Sections to match image ---
                      Text(
                        'These values work together',
                        style: AppStyles.bodyMedium.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Your selected values—Discipline, Resilience, and Growth—help you stay focused, push through challenges, and constantly improve. These qualities will shape your success in every training session and competition.',
                        style: AppStyles.bodySmall.copyWith(
                          fontSize: 14.sp,
                          color: AppStyles.hintTextColor, // Grey description
                        ),
                      ),
                      SizedBox(height: 30.h), // More space

                      Text(
                        'Explore Your Tools for Success',
                        style: AppStyles.bodyMedium.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Each section is designed to help you track progress, build consistency, and optimize performance. Here\'s how you can use them:',
                        style: AppStyles.bodySmall.copyWith(
                          fontSize: 14.sp,
                          color: AppStyles.hintTextColor, // Grey description
                        ),
                      ),

                      // --- End Swapped Sections ---
                      SizedBox(height: 20.h), // Space before table
                      // --- Tools Table ---
                      Container(
                        decoration: BoxDecoration(
                          color:
                              AppStyles
                                  .cardColor, // Card background for the whole table
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            width: 0.5,
                            color: AppStyles.borderColor,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Table Header
                            Container(
                              // No separate background needed if it's same as cardColor
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 12.w,
                              ), // Padding for header
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Section Name',
                                      style: AppStyles.bodyMedium.copyWith(
                                        fontSize: 15.sp,
                                      ), // Header text style
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Description',
                                      style: AppStyles.bodyMedium.copyWith(
                                        fontSize: 15.sp,
                                      ), // Header text style
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppStyles.borderColor,
                              thickness: 1,
                              height: 1,
                            ), // Thicker divider after header
                            // Table Rows - Use the helper
                            _buildTableRow(
                              'Visualization',
                              'Guided mental training for focus and game preparation.',
                            ),
                            Divider(
                              color: AppStyles.borderColor,
                              thickness: 0.5,
                              height: 0.5,
                              indent: 12.w,
                              endIndent: 12.w,
                            ), // Subtle divider
                            _buildTableRow(
                              'Daily Wellness Log',
                              'Track sleep, hydration, soreness, and readiness.',
                            ),
                            Divider(
                              color: AppStyles.borderColor,
                              thickness: 0.5,
                              height: 0.5,
                              indent: 12.w,
                              endIndent: 12.w,
                            ),
                            _buildTableRow(
                              'Prepwork',
                              'Log corrective exercises and warm-up routines.',
                            ),
                            Divider(
                              color: AppStyles.borderColor,
                              thickness: 0.5,
                              height: 0.5,
                              indent: 12.w,
                              endIndent: 12.w,
                            ),
                            _buildTableRow(
                              'Daily Journal',
                              'Monitor throwing drills, bullpen sessions, and progress.',
                            ),
                            Divider(
                              color: AppStyles.borderColor,
                              thickness: 0.5,
                              height: 0.5,
                              indent: 12.w,
                              endIndent: 12.w,
                            ),
                            _buildTableRow(
                              'Arm Care',
                              'Ensure recovery and maintain arm health through structured routines.',
                            ),
                            Divider(
                              color: AppStyles.borderColor,
                              thickness: 0.5,
                              height: 0.5,
                              indent: 12.w,
                              endIndent: 12.w,
                            ),
                            _buildTableRow(
                              'Lifting',
                              'Track strength training and conditioning sessions.',
                            ),
                            // Add more rows if needed following the pattern
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ), // Space at the bottom of scroll view
                    ],
                  ),
                ),
              ),
            ), // End Expanded for scroll view
            // --- Start Exploring Button ---
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ), // Padding around button
              child: SizedBox(
                // Use SizedBox to control width easily
                width: double.infinity, // Make button full width
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => MainParentScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppStyles.primaryColor, // Yellow background
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                    ), // Button height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30.r,
                      ), // Highly rounded corners
                    ),
                  ),
                  child: Text(
                    'Start Exploring',
                    style: AppStyles.buttonTextStyle, // Use button text style
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
