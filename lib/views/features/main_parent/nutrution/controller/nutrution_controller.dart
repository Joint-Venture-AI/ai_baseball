import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class NutrutionController extends GetxController {
  var feelValue = 4.0.obs;
  var proteinValue = 8.0.obs;
  var caloricValue = 3.0.obs;
  final TextEditingController proteinIntakeController = TextEditingController();

  var recoverNextDay = false.obs;
  
  // Loading state
  var isSubmitting = false.obs;
  
  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  Future<void> submitNutritionData(BuildContext context) async {
    try {
      isSubmitting.value = true;

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
      final userId = currentUser.id;

      // Create nutrition request
            final requestData = {
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'nutrition': {
          'nutritionScore': feelValue.value, // 0-10 scale
          'proteinInGram': proteinIntakeController.text.isNotEmpty
              ? double.tryParse(proteinIntakeController.text) ?? 0.0
              : 0.0, // Protein intake in grams
          'caloricScore': caloricValue.value, // 0-10 scale
          'consumedImpedingSubstances': recoverNextDay.value, // User's response to recovery question
        }
       
      };

      // Submit to API
      final response = await ApiService.submitNutrition(
        token: authController.accessToken.value,
        request: requestData,
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
  }
}
