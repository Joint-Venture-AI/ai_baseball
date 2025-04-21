import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MyTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const MyTextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppStyles.primaryColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Center(
              child: Text(
                buttonText,
                style: AppStyles.bodyMedium.copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
