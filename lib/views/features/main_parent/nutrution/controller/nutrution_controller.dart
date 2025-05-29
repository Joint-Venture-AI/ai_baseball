import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/core/models/nutrition_model.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class NutrutionController extends GetxController {
  var feelValue = 4.0.obs;
  var proteinValue = 8.0.obs;
  var caloricValue = 3.0.obs;
  final TextEditingController proteinIntakeController = TextEditingController();

  var recoverNextDay = ''.obs;
  
  // Loading state
  var isSubmitting = false.obs;
  
  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  Future<void> submitNutritionData() async {
    try {
      isSubmitting.value = true;

      // Validate required fields
      if (recoverNextDay.value.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please answer the recovery question',
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

      // Create nutrition request
      final nutritionRequest = NutritionRequest(
        user: currentUser.id,
        nutritionScore: feelValue.value.round(),
        proteinScore: proteinIntakeController.text.isNotEmpty
            ? int.tryParse(proteinIntakeController.text) ?? 0
            : proteinValue.value.round(),
        caloricScore: caloricValue.value.round(),
        consumedImpedingSubstances: recoverNextDay.value == 'Yes',
        date: DateTime.now(),
      );

      // Submit to API
      final response = await ApiService.submitNutrition(
        token: authController.accessToken.value,
        nutritionRequest: nutritionRequest,
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

        // Reset form values (optional)
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
    feelValue.value = 4.0;
    proteinValue.value = 8.0;
    caloricValue.value = 3.0;
    recoverNextDay.value = '';
  }
}
