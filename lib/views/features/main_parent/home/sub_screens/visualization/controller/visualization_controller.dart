import 'dart:async';
import 'package:get/get.dart';

class VisualizationController extends GetxController {
  // --- Configuration ---
  final int totalDurationSeconds = 10 * 60; // 10 minutes

  // --- State Variables ---
  late RxInt remainingSeconds; // Use RxInt for reactivity
  RxBool isRunning = false.obs; // Timer running state
  Timer? _timer; // The actual timer instance

  // --- Static Data (from UI) ---
  final int currentSession = 0; // Example value
  final int totalSessions = 4; // Example value
  final String remainingBoxTime = "02:59s"; // Example value

  @override
  void onInit() {
    super.onInit();
    // Initialize remainingSeconds only once when the controller is created
    remainingSeconds = RxInt(totalDurationSeconds);
  }

  @override
  void onClose() {
    _timer?.cancel(); // IMPORTANT: Cancel timer when controller is disposed
    super.onClose();
  }

  // --- Computed Properties (Getters) ---
  // Calculates progress (0.0 to 1.0) based on remaining time for the circle painter
  double get progress =>
      remainingSeconds.value > 0
          ? remainingSeconds.value / totalDurationSeconds
          : 0.0;

  // Formats remaining time into MM:SS string
  String get formattedTime {
    int minutes = remainingSeconds.value ~/ 60;
    int seconds = remainingSeconds.value % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // --- Actions ---
  void _tick(Timer timer) {
    if (remainingSeconds.value > 0) {
      remainingSeconds.value--; // Decrement remaining time
    } else {
      // Timer finished
      pauseTimer(); // Stop the timer
      // Optionally: Add logic for completion (e.g., show dialog, next session)
      print("Timer Finished!");
    }
  }

  void startTimer() {
    if (isRunning.value || remainingSeconds.value == 0)
      return; // Don't start if already running or finished

    isRunning.value = true;
    // Create a periodic timer that calls _tick every second
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void pauseTimer() {
    if (!isRunning.value) return; // Don't pause if not running

    _timer?.cancel(); // Stop the timer ticks
    isRunning.value = false;
  }

  void togglePlayPause() {
    if (isRunning.value) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  void restartTimer() {
    pauseTimer(); // Stop current timer first
    remainingSeconds.value = totalDurationSeconds; // Reset time
    // Decide if restart should automatically play or just reset:
    // startTimer(); // Uncomment this line if restart should immediately play
  }

  void stopTimer() {
    pauseTimer();
    // Typically, stop would navigate back or show a summary screen
    Get.back(); // Example: Navigate back
  }
}
