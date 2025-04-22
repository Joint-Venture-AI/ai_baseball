import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class MyTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool isOutline;
  const MyTextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.isOutline,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isOutline! ? Colors.transparent : AppStyles.primaryColor,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              width: 1,
              color: isOutline! ? AppStyles.primaryColor : Colors.transparent,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Center(
              child: Text(
                buttonText,
                style: AppStyles.bodyMedium.copyWith(
                  color: isOutline ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
