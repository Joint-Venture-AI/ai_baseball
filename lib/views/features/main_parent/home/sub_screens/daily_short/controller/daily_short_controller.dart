import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/core/models/daily_checkin_model.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class DailyController extends GetxController {
  // Text controllers
  final TextEditingController feelingController = TextEditingController();
  
  // Observable values for sliders
  final RxDouble sorenessValue = 3.0.obs;
  final RxDouble hydrationValue = 5.0.obs;
  final RxDouble readinessValue = 7.0.obs;
  
  // Observable values for time
  final Rx<TimeOfDay?> sleepTime = Rx<TimeOfDay?>(null);
  final Rx<TimeOfDay?> wakeTime = Rx<TimeOfDay?>(null);
  
  // Loading state
  final RxBool isSubmitting = false.obs;
  
  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    // Initialize default values if needed
    _loadSavedData();
  }

  @override
  void onClose() {
    feelingController.dispose();
    super.onClose();
  }

  // Update soreness value
  void updateSorenessValue(double value) {
    sorenessValue.value = value;
  }

  // Update hydration value
  void updateHydrationValue(double value) {
    hydrationValue.value = value;
  }

  // Update readiness value
  void updateReadinessValue(double value) {
    readinessValue.value = value;
  }

  // Update sleep time
  void updateSleepTime(TimeOfDay? time) {
    sleepTime.value = time;
  }

  // Update wake time
  void updateWakeTime(TimeOfDay? time) {
    wakeTime.value = time;
  }

  // Format time for display
  String formatTime(TimeOfDay? time) {
    if (time == null) {
      return '-- : --';
    }
    
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    
    return '$hour:$minute $period';
  }

  // Validate form data
  bool _validateForm() {
    if (feelingController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please describe how you\'re feeling',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (sleepTime.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select your sleep time',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (wakeTime.value == null) {
      Get.snackbar(
        'Validation Error',
        'Please select your wake time',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // Convert TimeOfDay to DateTime for API
  DateTime _timeOfDayToDateTime(TimeOfDay timeOfDay, {bool isNextDay = false}) {
    final now = DateTime.now();
    final baseDate = isNextDay ? now.add(const Duration(days: 1)) : now;
    
    return DateTime(
      baseDate.year,
      baseDate.month,
      baseDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  // Submit daily wellness data
  Future<void> submitDailyWellness() async {
    if (!_validateForm()) return;

    try {
      isSubmitting.value = true;

      // Get current user ID
      final userId = authController.currentUser.value?.id;
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

      // Create request object
      final request = DailyWellnessRequest(
        userId: userId,
        date: DateTime.now(),
        dailyWellnessQuestionnaire: DailyWellnessQuestionnaire(
          feeling: feelingController.text.trim(),
          soreness: sorenessValue.value.round(),
          sleepTime: _timeOfDayToDateTime(sleepTime.value!),
          wakeUpTime: _timeOfDayToDateTime(wakeTime.value!),
          hydrationLevel: hydrationValue.value.round(),
          readinessToCompete: readinessValue.value.round(),
        ),
      );

      // Call API
      final response = await ApiService.submitDailyWellness(
        request: request,
        token: authController.accessToken.value,
      );

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          'Daily wellness data submitted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reset form
        _resetForm();

        // Navigate back or to home
        // Get.back();
      } else {
        // Show error message
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to submit data',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
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
    feelingController.clear();
    sorenessValue.value = 3.0;
    hydrationValue.value = 5.0;
    readinessValue.value = 7.0;
    sleepTime.value = null;
    wakeTime.value = null;
  }

  // Load any saved data (if needed for offline functionality)
  void _loadSavedData() {
    // Implementation for loading saved data from local storage
    // This can be implemented later if needed
  }

  // Save data locally (if needed for offline functionality)
  void _saveDataLocally() {
    // Implementation for saving data locally
    // This can be implemented later if needed
  }
}