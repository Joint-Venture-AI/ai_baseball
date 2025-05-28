import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

import '../../../../../../../core/services/api_service.dart';

// Enum for the radio button choices
enum WorkloadEnvironment { controlled, inGame }

class ThrowingJournalController extends GetxController {
  // Text Editing Controllers
  final TextEditingController drillsController = TextEditingController();
  final TextEditingController toolsController = TextEditingController();
  final TextEditingController setsRepsController = TextEditingController();
  final TextEditingController longTossDistController = TextEditingController();
  final TextEditingController pitchCountController = TextEditingController();
  final TextEditingController focusController = TextEditingController();
  // Observable values
  final Rx<WorkloadEnvironment> selectedEnvironment = WorkloadEnvironment.controlled.obs;
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedData();
  }

  @override
  void onClose() {
    // Dispose controllers
    drillsController.dispose();
    toolsController.dispose();
    setsRepsController.dispose();
    longTossDistController.dispose();
    pitchCountController.dispose();
    focusController.dispose();
    super.onClose();
  }

  // Update selected environment
  void updateEnvironment(WorkloadEnvironment? environment) {
    if (environment != null) {
      selectedEnvironment.value = environment;
    }
  }

  // Input formatters for numeric fields
  List<TextInputFormatter> get numericInputFormatters => [
    FilteringTextInputFormatter.digitsOnly,
  ];

  // Validate form data
  bool _validateForm() {
    // Check if drills field is filled
    if (drillsController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please describe what drills you did today',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if focus field is filled
    if (focusController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please describe what your focus was',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }
  // Submit throwing journal data
  Future<void> submitThrowingJournal() async {
    if (!_validateForm()) return;

    try {
      isSubmitting.value = true;

      // Check if AuthController is available and has token
      if (!Get.isRegistered<AuthController>()) {
        Get.snackbar(
          'Error',
          'Authentication not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final authController = Get.find<AuthController>();
      
      // Get current user ID and token
      final userId = authController.currentUser.value?.id;
      final token = authController.accessToken.value;

      if (userId == null || userId.isEmpty) {
        Get.snackbar(
          'Error',
          'User not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (token.isEmpty) {
        Get.snackbar(
          'Error',
          'Authentication token not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Create request data
      final requestData = {
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'throwingJournal': {
          'drills': [drillsController.text.trim()],
          'toolsDescription': toolsController.text.trim(),
          'setsAndReps': setsRepsController.text.trim(),
          'longTossDistance': longTossDistController.text.trim().isNotEmpty 
              ? int.tryParse(longTossDistController.text.trim()) ?? 0
              : 0,
          'pitchCount': pitchCountController.text.trim().isNotEmpty 
              ? int.tryParse(pitchCountController.text.trim()) ?? 0
              : 0,
          'focus': focusController.text.trim(),
          'environment': selectedEnvironment.value == WorkloadEnvironment.controlled 
              ? 'Controlled' 
              : 'In Game',
        }
      };

      print('Submitting throwing journal with userId: $userId');
      print('Token available: ${token.isNotEmpty}');

      // Call API
      final response = await ApiService.submitThrowingJournal(
        token: token,
        request: requestData,
      );
      print(response.message);

      if (!response.success) {
        Get.snackbar(
          'Error',
          'Failed to submit throwing journal: ${response.message}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Show success message
      Get.snackbar(
        'Success',
        'Throwing journal submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Reset form
      _resetForm();

      // Navigate back
      Get.back();

    } catch (e) {
      // Handle unexpected errors
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // Reset form to default values
  void _resetForm() {
    drillsController.clear();
    toolsController.clear();
    setsRepsController.clear();
    longTossDistController.clear();
    pitchCountController.clear();
    focusController.clear();
    selectedEnvironment.value = WorkloadEnvironment.controlled;
  }
  // Load any saved data (for offline functionality)
  void _loadSavedData() {
    // Implementation for loading saved data from local storage
    // This can be implemented later if needed
  }

  // Get environment display text
  String getEnvironmentText(WorkloadEnvironment environment) {
    switch (environment) {
      case WorkloadEnvironment.controlled:
        return 'Controlled(Bullpen/ Practice)';
      case WorkloadEnvironment.inGame:
        return 'In Game';
    }
  }

  // Field configurations
  Map<String, dynamic> getDrillsFieldConfig() {
    return {
      'label': 'What drills did you do today?',
      'controller': drillsController,
      'hint': 'List the drills you performed...',
      'maxLines': 4,
      'keyboardType': TextInputType.multiline,
    };
  }

  Map<String, dynamic> getToolsFieldConfig() {
    return {
      'label': '"Did you use any training tools or instruments today?\nExamples such as: plyo balls, Tidaltank, towel drills, Core Velocity Belt, etc-T"',
      'controller': toolsController,
      'hint': 'Describe any tool or requipment used...',
      'maxLines': 4,
      'keyboardType': TextInputType.multiline,
    };
  }

  Map<String, dynamic> getSetsRepsFieldConfig() {
    return {
      'label': 'How many sets and reps did you perform for each exercise or drill?',
      'controller': setsRepsController,
      'hint': 'Details of your sets and reps...',
      'maxLines': 3,
      'keyboardType': TextInputType.multiline,
    };
  }

  Map<String, dynamic> getLongTossFieldConfig() {
    return {
      'label': 'If you long-tossed, how far did you throw? (in feet)',
      'controller': longTossDistController,
      'hint': 'e.g., 120',
      'keyboardType': TextInputType.number,
      'inputFormatters': numericInputFormatters,
      'suffixIcon': Icons.access_time,
    };
  }

  Map<String, dynamic> getPitchCountFieldConfig() {
    return {
      'label': 'If you threw off the mound today, how many pitches did you throw in your bullpen or in game today?',
      'controller': pitchCountController,
      'hint': 'e.g., 120',
      'keyboardType': TextInputType.number,
      'inputFormatters': numericInputFormatters,
      'suffixIcon': Icons.access_time,
    };
  }

  Map<String, dynamic> getFocusFieldConfig() {
    return {
      'label': 'What was your focus?',
      'controller': focusController,
      'hint': 'Describe what you focused on today...',
      'maxLines': 3,
      'keyboardType': TextInputType.multiline,
    };
  }
}