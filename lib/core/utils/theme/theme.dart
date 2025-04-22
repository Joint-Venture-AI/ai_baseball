import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyThemeData {
  static final theme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppStyles.primaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        ),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white, // <- text color while typing
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppStyles.hintTextColor),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(width: 1, color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),

        borderSide: BorderSide(width: 1, color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),

        borderSide: BorderSide(width: 1, color: Colors.white),
      ),
    ),
  );
}
