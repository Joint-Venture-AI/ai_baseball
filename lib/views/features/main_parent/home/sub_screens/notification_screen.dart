import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
// import 'package:baseball_ai/views/features/main_parent/home/sub_screens/visualization/screens/visualization_screen.dart'; // Not used, can remove
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove Expanded directly around body - Scaffold's body fills the available space
    // body: Expanded(...) <-- This was incorrect

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ), // Use const
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Notifications', style: AppStyles.bodyMedium),
      ),
      body: ListView.builder(
        // body automatically takes the available space
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            // Added horizontal padding for list items, adjusted vertical
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            child: Container(
              // Added internal padding within the container
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppStyles.cardColor,
                // Border might not be needed if background colors differentiate sections well
                // border: Border.all(width: 1, color: AppStyles.hintTextColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                // Align items at the top of the row
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      // Corrected backgroundColor to AppStyles.cardColor (assuming kCardColor was a placeholder)
                      backgroundColor: AppStyles.hintTextColor.withOpacity(0.2),
                      // Put SvgPicture directly if the circle isn't meant to be a separate button
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          AppIcons.bell,
                          color: Colors.white, // Or theme color if available
                          width: 24, // Explicit size for icon
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ), // Increased spacing slightly between icon and text
                  Expanded(
                    // <--- KEY CHANGE: Wrap the Column with Expanded
                    child: Column(
                      // Align text content to the start (left)
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discipline keeps you committed to your routines, ensuring consistency.', // Added more text for testing
                          style: AppStyles.bodySmall,
                          // Text will automatically wrap within the constrained width provided by Expanded
                        ),
                        SizedBox(
                          height: 4.h,
                        ), // Add vertical space between message and timestamp
                        Align(
                          alignment:
                              Alignment
                                  .bottomRight, // Keep right alignment for the timestamp
                          child: Text('32s ago', style: AppStyles.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
