import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/controllers/boarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardingScreen extends StatelessWidget {
  BoardingScreen({super.key});
  // Ensure BoardingController is registered with GetX (e.g., in main.dart or using bindings)
  final boardingController = Get.find<BoardingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppStyles.backgroundColor, // Use your defined background color
      body: SafeArea(
        child: Center(
          // Centering the indicator might be cleaner now
          child: Obx(() {
            return boardingController.isShowLoadingSection.value
                ? const CupertinoActivityIndicator(
                  color: Colors.white, // Or use a color from AppStyles
                  radius: 15, // Adjust size if needed
                )
                : Container(); // Display nothing once loading is technically "done" (dialog handles next step)
          }),
        ),
      ),
    );
  }
}
