import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/core/models/daily_logs_model.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class ProgressController extends GetxController {
  // Initialize with a default value (e.g., 0 or 5, depending on preference)
  final todayScale = 0.obs; // Reactive integer for the slider value

  // Initialize with an empty string or a default value
  final workloadType = ''.obs; // Reactive string for the selected radio button

  // Loading state
  var isSubmitting = false.obs;

  // You will also need TextEditingControllers for the TextFormFields
  final resultsController = TextEditingController();
  final takeawayController = TextEditingController();

  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  @override
  void onClose() {
    resultsController.dispose();
    takeawayController.dispose();
    super.onClose();
  }

  Future<void> submitProgress() async {
    try {
      isSubmitting.value = true;

      // Validate required fields
      if (workloadType.value.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please select a session type (Bullpen/Live at-bats or In game)',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (resultsController.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please enter game results or type "skip" if not applicable',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (takeawayController.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please enter your primary takeaway',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Get current user ID
      final currentUser = authController.currentUser.value;
      if (currentUser == null || currentUser.id.isEmpty) {
        Get.snackbar(
          'Error',
          'User not found. Please login again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Create post performance data
      final postPerformance = PostPerformance(
        gameRating: todayScale.value,
        sessionType: workloadType.value,
        gameResults: resultsController.text.trim(),
        primaryTakeaway: takeawayController.text.trim(),
      );

      // Create daily logs request
      final dailyLogsRequest = DailyLogsRequest(
        userId: currentUser.id,
        date: DateTime.now(),
        postPerformance: postPerformance,
      );

      // Submit to API
      final response = await ApiService.submitDailyLogs(
        token: authController.accessToken.value,
        dailyLogsRequest: dailyLogsRequest,
      );

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Reset form values
        _resetForm();
        
      } else {
        // Show error message
        Get.snackbar(
          'Submission Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void _resetForm() {
    todayScale.value = 0;
    workloadType.value = '';
    resultsController.clear();
    takeawayController.clear();
  }
}
