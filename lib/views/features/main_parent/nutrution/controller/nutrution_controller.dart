import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/core/models/nutrition_model.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class NutrutionController extends GetxController {
  var feelValue = 4.0.obs;
  var proteinValue = 8.0.obs;
  var caloricValue = 3.0.obs;
  var recoverNextDay = ''.obs;
  var isSubmitting = false.obs;

  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  Future<void> submitNutrition() async {
    // Validate required fields
    if (recoverNextDay.value.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please answer whether you consumed anything that might impede recovery',
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
        'Please login to submit nutrition data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isSubmitting.value = true;

      // Create nutrition request
      final nutritionRequest = NutritionRequest(
        user: user.id,
        nutritionScore: feelValue.value.round(),
        proteinScore: proteinValue.value.round(),
        caloricScore: caloricValue.value.round(),
        consumedImpedingSubstances: recoverNextDay.value == 'Yes',
        date: DateTime.now().toIso8601String(),
      );

      // Submit to API
      final response = await ApiService.submitNutrition(
        token: authController.accessToken.value,
        request: nutritionRequest,
      );

      if (response.success) {
        Get.snackbar(
          'Success',
          'Nutrition data submitted successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        
        // Navigate back or reset form
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
        'Failed to submit nutrition data: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
