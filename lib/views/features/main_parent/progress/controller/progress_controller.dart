import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/core/models/daily_logs_model.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class ProgressController extends GetxController {
  // Initialize with a default value (e.g., 0 or 5, depending on preference)
  final todayScale = 0.obs; // Reactive integer for the slider value

  // Initialize with an empty string or a default value
  final workloadType = ''.obs; // Reactive string for the selected radio button

  // You will also need TextEditingControllers for the TextFormFields
  final resultsController = TextEditingController();
  final takeawayController = TextEditingController();
  
  // Loading state
  final isSubmitting = false.obs;

  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  @override
  void onClose() {
    resultsController.dispose();
    takeawayController.dispose();
    super.onClose();
  }

  Future<void> submitProgress() async {
    // Validate required fields
    if (workloadType.value.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please select the session type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (takeawayController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please provide your primary takeaway',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final user = authController.currentUser.value;
    if (user == null) {
      Get.snackbar(
        'Error',
        'Please login to submit progress data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      // Create post performance data
      final postPerformanceData = PostPerformanceData(
        gameRating: todayScale.value,
        sessionType: workloadType.value,
        gameResults: resultsController.text.trim().isEmpty 
            ? "skip" 
            : resultsController.text.trim(),
        primaryTakeaway: takeawayController.text.trim(),
      );

      // Create daily logs request
      final dailyLogsRequest = DailyLogsRequest(
        userId: user.id,
        date: DateTime.now().toIso8601String(),
        postPerformance: postPerformanceData,
      );

      // Submit to API
      final response = await ApiService.submitDailyLogs(
        token: authController.accessToken.value,
        request: dailyLogsRequest,
      );
      print('Response: ${response.success}, Message: ${response.message}');
      
      if (response.success || response.success == true || response.success == 'true') {
        Get.snackbar(
          'Success',
          'Post-performance data submitted successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        
        // Clear form
        _clearForm();
        
        // Navigate back
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit progress: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void _clearForm() {
    todayScale.value = 0;
    workloadType.value = '';
    resultsController.clear();
    takeawayController.clear();
  }
}
