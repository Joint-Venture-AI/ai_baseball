import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/core/services/api_service.dart';

class VisualizationController extends GetxController {
  // Timer variables
  Timer? _timer;
  
  // Observable variables
  final RxInt currentSession = 1.obs;
  final RxInt totalSessions = 4.obs;
  final RxInt remainingSeconds = 240.obs; // 4 minutes per session (4*60)
  final RxBool isRunning = false.obs;
  final RxBool isSaving = false.obs; // New: for API call state
  final RxString savingMessage = ''.obs; // New: for saving feedback
  
  // Session duration (4 minutes in seconds)
  static const int sessionDuration = 240;
  
  @override
  void onInit() {
    super.onInit();
    resetToFirstSession();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // Computed properties
  double get progress {
    if (remainingSeconds.value <= 0) return 1.0;
    return 1.0 - (remainingSeconds.value / sessionDuration);
  }

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get remainingBoxTime {
    final totalRemaining = (totalSessions.value - currentSession.value + 1) * sessionDuration + remainingSeconds.value;
    final minutes = totalRemaining ~/ 60;
    return '${minutes}min remaining';
  }

  // Timer control methods
  void togglePlayPause() {
    if (isRunning.value) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    if (remainingSeconds.value <= 0) return;
    
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        // Session completed
        _onSessionCompleted();
      }
    });
  }

  void pauseTimer() {
    isRunning.value = false;
    _timer?.cancel();
  }

  void stopTimer() {
    isRunning.value = false;
    _timer?.cancel();
    remainingSeconds.value = sessionDuration;
  }

  void restartTimer() {
    stopTimer();
    remainingSeconds.value = sessionDuration;
  }

  void resetToFirstSession() {
    stopTimer();
    currentSession.value = 1;
    remainingSeconds.value = sessionDuration;
    isSaving.value = false;
    savingMessage.value = '';
  }

  // Handle session completion
  Future<void> _onSessionCompleted() async {
    pauseTimer();
    
    // Call API to save session data
    await _saveSessionToAPI();
    
    // Check if all sessions are completed
    if (currentSession.value >= totalSessions.value) {
      _onAllSessionsCompleted();
    } else {
      _moveToNextSession();
    }
  }

  // API call to save session data
  Future<void> _saveSessionToAPI() async {
    try {
      isSaving.value = true;
      savingMessage.value = 'Saving session ${currentSession.value}...';

      // Check authentication
      if (!Get.isRegistered<AuthController>()) {
        throw Exception('Authentication not found. Please login again.');
      }

      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;
      final token = authController.accessToken.value;

      if (userId == null || userId.isEmpty) {
        throw Exception('User not found. Please login again.');
      }

      if (token.isEmpty) {
        throw Exception('Access token not found. Please login again.');
      }

      // Create request data
      final requestData = {
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'visualization': {
          'sessionNumber': currentSession.value,
          'totalSessions': totalSessions.value,
          'duration': sessionDuration, // Duration in seconds
          'completedAt': DateTime.now().toIso8601String(),
          'type': 'box_breathing',
        }
      };

      // Print for debugging
      print('Saving Visualization Session:');
      print('Session: ${currentSession.value}/${totalSessions.value}');
      print('Request Data: $requestData');

      // TODO: Replace with actual API call
      // final response = await ApiService.submitVisualizationSession(
      //   request: requestData,
      //   token: token,
      // );

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Simulate successful response
      // if (response == null || !response.success) {
      //   throw Exception(response?.message ?? 'Failed to save session data');
      // }

      savingMessage.value = 'Session ${currentSession.value} saved!';
      
      // Show success message
      Get.snackbar(
        'Session Saved',
        'Session ${currentSession.value} completed and saved successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 2),
      );

      // Wait a moment to show the saved message
      await Future.delayed(const Duration(milliseconds: 500));

    } catch (e) {
      savingMessage.value = 'Failed to save session';
      
      Get.snackbar(
        'Save Error',
        'Failed to save session: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFF44336),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 3),
      );
      
      // Even if save fails, continue to next session
      print('Error saving session: $e');
    } finally {
      isSaving.value = false;
    }
  }

  // Move to next session
  void _moveToNextSession() {
    currentSession.value++;
    remainingSeconds.value = sessionDuration;
    savingMessage.value = '';
    
    Get.snackbar(
      'Next Session',
      'Ready for session ${currentSession.value}/${totalSessions.value}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFFD700),
      colorText: const Color(0xFF000000),
      duration: const Duration(seconds: 2),
    );
  }

  // Handle completion of all sessions
  void _onAllSessionsCompleted() async {
    savingMessage.value = 'All sessions completed!';
    
    // Call API to mark entire visualization session as complete
    await _saveCompletedVisualizationToAPI();
    
    Get.snackbar(
      'Congratulations!',
      'All ${totalSessions.value} visualization sessions completed!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFFFD700),
      colorText: const Color(0xFF000000),
      duration: const Duration(seconds: 3),
    );

    // Navigate back or reset
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
  }

  // API call to save completed visualization session
  Future<void> _saveCompletedVisualizationToAPI() async {
    try {
      isSaving.value = true;
      savingMessage.value = 'Saving completed visualization...';

      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id;
      final token = authController.accessToken.value;

      final requestData = {
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'visualizationComplete': {
          'totalSessions': totalSessions.value,
          'totalDuration': sessionDuration * totalSessions.value,
          'completedAt': DateTime.now().toIso8601String(),
          'type': 'box_breathing',
          'status': 'completed',
        }
      };

      print('Saving Completed Visualization:');
      print('Request Data: $requestData');

      // TODO: Replace with actual API call
      // final response = await ApiService.submitCompletedVisualization(
      //   request: requestData,
      //   token: token,
      // );

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      savingMessage.value = 'Visualization completed and saved!';

    } catch (e) {
      print('Error saving completed visualization: $e');
    } finally {
      isSaving.value = false;
    }
  }

  // Manual session completion (for testing)
  void completeCurrentSession() {
    remainingSeconds.value = 0;
    _onSessionCompleted();
  }
}
