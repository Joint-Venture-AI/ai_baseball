import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static Color primaryColor = Color(0xffFFD700);
  static Color secondaryColor = Color(0xff36454F);
  static Color cardColor = Color(0xff2C2C2C);
  static Color backgroundColor = Color(0xff101010);
  static Color subtitleColor = Color(0xffD6D6D6);
  static const Color inactiveIconColor = Color(
    0xFFAAAAAA,
  ); // Example Light Grey
  static const Color fabIconColor =
      Colors.black; // Example Black icon on yellow FAB
  static const Color navigationBarColor = Color(0xFF2A2A2A);
  static const Color borderColor = Color(0xFF4A4A4A); // Subtle border/divider

  static const Color textPrimaryColor = Colors.white;
  static const Color hintTextColor = Color(0xFFAAAAAA); // Lighter grey tex

  static final TextStyle bodyMedium = TextStyle(
    color: textPrimaryColor,
    fontSize: 16.sp, // Adjusted for potential screen util scaling
    fontWeight: FontWeight.w600, // Semibold often looks good for titles
  );

  static final TextStyle bodySmall = TextStyle(
    color: textPrimaryColor, // Default to white
    fontSize: 14.sp, // Adjusted for potential screen util scaling
    fontWeight: FontWeight.normal,
  );

  static final TextStyle headingLarge = TextStyle(
    color: textPrimaryColor,
    fontSize: 28.sp, // Larger heading
    fontWeight: FontWeight.bold,
  );

  static final TextStyle buttonTextStyle = TextStyle(
    color: Colors.black, // Text color on yellow button
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
}
