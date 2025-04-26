import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  // Initialize with a default value (e.g., 0 or 5, depending on preference)
  final todayScale = 0.obs; // Reactive integer for the slider value

  // Initialize with an empty string or a default value
  final workloadType = ''.obs; // Reactive string for the selected radio button

  // You will also need TextEditingControllers for the TextFormFields
  final resultsController = TextEditingController();
  final takeawayController = TextEditingController();

  @override
  void onClose() {
    resultsController.dispose();
    takeawayController.dispose();
    super.onClose();
  }

  void submitProgress() {
    final scale = todayScale.value;
    final type = workloadType.value;
    final results = resultsController.text;
    final takeaway = takeawayController.text;
    // Process or save the data
    print(
      'Scale: $scale, Workload: $type, Results: $results, Takeaway: $takeaway',
    );
    // Maybe navigate back or show a success message
  }
}
