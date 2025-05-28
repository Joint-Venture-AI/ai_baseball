import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class ArmCareController extends GetxController {
  // Text controller for logging exercises
  final TextEditingController logExerciseController = TextEditingController();

  // Observable maps for checkboxes - Fixed initialization
  final RxMap<String, bool> focusOptions = <String, bool>{
    'Scapular Emphasis': false,
    'Shoulder Emphasis': false,
    'Forearms': false,
    'Biceps/Triceps': false,
  }.obs;

  final RxMap<String, bool> exerciseFocusOptions = <String, bool>{
    'Isometric': false,
    'Eccentric': false,
    'Oscillating': false,
  }.obs;

  final RxMap<String, bool> recoveryOptions = <String, bool>{
    'Hot tub': false,
    'Cold Tub': false,
    'Stim': false,
    'Ice pack': false,
    'Grastens/scraping': false,
    'Foam roll': false,
    'Dry needling': false,
    'Cupping': false,
    'Gameready': false,
    'Normatec': false,
    'Marc Pro': false,
    'BFR': false,
  }.obs;

  // Observable values
  final RxBool showLogWidget = false.obs;
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedData();
  }

  @override
  void onClose() {
    logExerciseController.dispose();
    super.onClose();
  }

  // Toggle checkbox value for focus options - Fixed method
  void toggleFocusOption(String key) {
    focusOptions[key] = !(focusOptions[key] ?? false);
    focusOptions.refresh(); // Force update
  }

  // Toggle checkbox value for exercise focus options - Fixed method
  void toggleExerciseFocusOption(String key) {
    exerciseFocusOptions[key] = !(exerciseFocusOptions[key] ?? false);
    exerciseFocusOptions.refresh(); // Force update
  }

  // Toggle checkbox value for recovery options - Fixed method
  void toggleRecoveryOption(String key) {
    recoveryOptions[key] = !(recoveryOptions[key] ?? false);
    recoveryOptions.refresh(); // Force update
  }

  // Toggle log widget visibility
  void toggleLogWidget() {
    showLogWidget.value = !showLogWidget.value;
  }

  // Handle "Others" tap for recovery options
  void handleOthersTap() {
    final TextEditingController textController = TextEditingController();
    
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text(
          'Add Custom Recovery Option',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: textController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter custom recovery option...',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              final value = textController.text.trim();
              if (value.isNotEmpty) {
                // Add the custom option to recovery options
                recoveryOptions[value] = true;
                recoveryOptions.refresh(); // Force update
                Get.back();
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
        ],
      ),
    );
  }

  // Validate form data
  bool _validateForm() {
    // Check if at least one focus option is selected
    if (!focusOptions.values.any((selected) => selected)) {
      Get.snackbar(
        'Validation Error',
        'Please select at least one focus option',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if at least one exercise focus is selected
    if (!exerciseFocusOptions.values.any((selected) => selected)) {
      Get.snackbar(
        'Validation Error',
        'Please select at least one exercise focus option',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // Get selected options as lists
  List<String> getSelectedFocusOptions() {
    return focusOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  List<String> getSelectedExerciseFocusOptions() {
    return exerciseFocusOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  List<String> getSelectedRecoveryOptions() {
    return recoveryOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  // Submit arm care data
  Future<void> submitArmCare() async {
    if (!_validateForm()) return;

    try {
      isSubmitting.value = true;

      // Check if AuthController is available
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
          'Access token not found. Please login again.',
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
        'armCare': {
          'focusOptions': getSelectedFocusOptions(),
          'exerciseFocus': getSelectedExerciseFocusOptions(),
          'recoveryModalities': getSelectedRecoveryOptions(),
          'loggedExercises': showLogWidget.value && logExerciseController.text.trim().isNotEmpty
              ? logExerciseController.text.trim()
              : null,
        }
      };

      // Print for debugging (you can replace this with actual API call)
      print('Arm Care Data:');
      print('Focus Options: ${getSelectedFocusOptions()}');
      print('Exercise Focus: ${getSelectedExerciseFocusOptions()}');
      print('Recovery Options: ${getSelectedRecoveryOptions()}');
      print('Logged Exercises: ${logExerciseController.text}');
      print('Request Data: $requestData');

      // TODO: Replace with actual API call
      // final response = await ApiService.submitArmCare(
      //   request: requestData,
      //   token: token,
      // );

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      Get.snackbar(
        'Success',
        'Arm care data submitted successfully!',
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
    // Reset all checkbox options
    for (String key in focusOptions.keys) {
      focusOptions[key] = false;
    }
    focusOptions.refresh();
    
    for (String key in exerciseFocusOptions.keys) {
      exerciseFocusOptions[key] = false;
    }
    exerciseFocusOptions.refresh();
    
    for (String key in recoveryOptions.keys) {
      recoveryOptions[key] = false;
    }
    recoveryOptions.refresh();

    // Reset text controller and widget visibility
    logExerciseController.clear();
    showLogWidget.value = false;
  }

  // Load any saved data (for offline functionality)
  void _loadSavedData() {
    // Implementation for loading saved data from local storage
    // This can be implemented later if needed
  }
}