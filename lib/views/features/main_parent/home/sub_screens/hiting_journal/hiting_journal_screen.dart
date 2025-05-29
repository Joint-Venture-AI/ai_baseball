import 'package:baseball_ai/views/features/main_parent/home/sub_screens/notification_screen.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/services/api_service.dart';

// Assuming AppStyles exists in your project and contains the necessary definitions:
class AppStyles {
  static const Color backgroundColor = Color(0xFF1A1A1A); // Dark background
  static const Color primaryColor = Colors.yellow; // Yellow accent
  static const Color textColor = Colors.white;
  static const Color hintColor = Colors.grey;
  static const Color cardColor = Color(
    0xFF2C2C2C,
  ); // Slightly lighter grey for inputs/buttons
  static const Color checkboxActiveColor =
      primaryColor; // Not used in Hitting Journal UI
  static const Color checkboxInactiveColor =
      Colors.grey; // Not used in Hitting Journal UI

  static const TextStyle headingTitle = TextStyle(
    color: textColor,
    fontSize: 20, // Adjust as needed
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText = TextStyle(
    color: textColor,
    fontSize: 15, // Adjust as needed
  );

  static const TextStyle labelText = TextStyle(
    color: textColor,
    fontSize: 16, // Adjust as needed
    fontWeight: FontWeight.w500,
  );

  static const TextStyle hintStyle = TextStyle(
    color: hintColor,
    fontSize: 14, // Adjust as needed
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.black, // Text color on yellow button
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle secondaryButtonTextStyle = TextStyle(
    color: primaryColor, // Text color on dark button
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  // New style for text field input text
  static const TextStyle inputTextStyle = TextStyle(
    color: textColor,
    fontSize: 15, // Match body text size
  );
}

class HittingJournalScreen extends StatefulWidget {
  const HittingJournalScreen({super.key});

  @override
  State<HittingJournalScreen> createState() => _HittingJournalScreenState();
}

class _HittingJournalScreenState extends State<HittingJournalScreen> {
  // State for the slider - matches backend field name
  double _pregameEngagementValue = 7.0; // Backend expects 'pregameEngagement'

  // Controllers for text fields - updated to match backend field names
  final TextEditingController _primaryFocusController = TextEditingController(); // ✓ Matches backend
  final TextEditingController _atBatsController = TextEditingController(); // ✓ Matches backend
  final TextEditingController _atBatResultsController = TextEditingController(); // Backend expects 'atBatResults' (singular)
  final TextEditingController _positiveOutcomeController = TextEditingController(); // Backend expects 'positiveOutcome'
  final TextEditingController logExerciseController = TextEditingController(); // Backend expects 'exercisesLog'

  // State variables
  bool showLogWidget = false;
  bool isSubmitting = false;

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _primaryFocusController.dispose();
    _atBatsController.dispose();
    _atBatResultsController.dispose();
    _positiveOutcomeController.dispose();
    logExerciseController.dispose();
    super.dispose();
  }

  // Validate form data
  bool _validateForm() {
    // Check if primary focus is filled (required)
    if (_primaryFocusController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your primary focus for today',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if at-bats number is filled and valid (required)
    if (_atBatsController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter the number of at-bats',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Validate at-bats is a valid number (min 0)
    final atBatsText = _atBatsController.text.trim();
    final atBatsNumber = int.tryParse(atBatsText);
    if (atBatsNumber == null || atBatsNumber < 0) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid number for at-bats (0 or greater)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if at-bat results is filled (required)
    if (_atBatResultsController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter the results of your at-bats',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if positive outcome is filled (required)
    if (_positiveOutcomeController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter something positive about today',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // Submit hitting journal data
  Future<void> submitHittingJournal() async {
    if (!_validateForm()) return;

    try {
      setState(() {
        isSubmitting = true;
      });

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

      // Create request data matching backend schema exactly
      final requestData = {
        'userId': userId,
        'date': DateTime.now().toIso8601String(),
        'hittingJournal': {
          'pregameEngagement': _pregameEngagementValue.round(), // Backend expects this field name
          'primaryFocus': _primaryFocusController.text.trim(), // ✓ Matches backend
          'atBats': int.parse(_atBatsController.text.trim()), // ✓ Matches backend
          'atBatResults': _atBatResultsController.text.trim(), // Backend expects singular 'atBatResults'
          'positiveOutcome': _positiveOutcomeController.text.trim(), // Backend expects 'positiveOutcome'
          'exercisesLog': showLogWidget && logExerciseController.text.trim().isNotEmpty
              ? logExerciseController.text.trim()
              : null, // Backend expects 'exercisesLog' (optional)
        }
      };

      // Print for debugging
      print('Hitting Journal Data:');
      print('Pregame Engagement: ${_pregameEngagementValue.round()}');
      print('Primary Focus: ${_primaryFocusController.text.trim()}');
      print('At Bats: ${_atBatsController.text.trim()}');
      print('At Bat Results: ${_atBatResultsController.text.trim()}');
      print('Positive Outcome: ${_positiveOutcomeController.text.trim()}');
      print('Exercises Log: ${logExerciseController.text.trim()}');
      print('Request Data: $requestData');

      // Call API
      final response = await ApiService.submitHittingJournal(
        request: requestData,
        token: token,
      );

      if (response == null || !response.success) {
        Get.snackbar(
          'Error',
          response?.message ?? 'Failed to submit hitting journal',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Show success message
      Get.snackbar(
        'Success',
        'Hitting journal submitted successfully!',
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
      setState(() {
        isSubmitting = false;
      });
    }
  }

  // Reset form to default values
  void _resetForm() {
    setState(() {
      _pregameEngagementValue = 7.0;
      _primaryFocusController.clear();
      _atBatsController.clear();
      _atBatResultsController.clear();
      _positiveOutcomeController.clear();
      logExerciseController.clear();
      showLogWidget = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppStyles.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Hitting Journal', style: AppStyles.headingTitle),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined,
                color: AppStyles.textColor,
                size: 24,
              ),
            ),
            onPressed: () {
              Get.to(() => NotificationScreen());
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your hitting performance and daily progress',
              style: AppStyles.bodyText.copyWith(color: AppStyles.hintColor),
            ),
            SizedBox(height: 25.h),

            // --- Question 1: How dialed in were you... (Slider) ---
            Text(
              '1. How dialed in were you during your pregame routine today? (Batting practice, tee work, drills, movement prep, etc)',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 8.h,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 10.0,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20.0,
                      ),
                      activeTrackColor: AppStyles.primaryColor,
                      inactiveTrackColor: AppStyles.cardColor,
                      thumbColor: AppStyles.textColor,
                      overlayColor: AppStyles.primaryColor.withOpacity(0.2),
                      valueIndicatorColor: AppStyles.primaryColor,
                      valueIndicatorTextStyle: AppStyles.buttonTextStyle,
                    ),
                    child: Slider(
                      value: _pregameEngagementValue,
                      min: 1.0,
                      max: 10.0,
                      divisions: 9,
                      label: _pregameEngagementValue.round().toString(),
                      onChanged: (newValue) {
                        setState(() {
                          _pregameEngagementValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  _pregameEngagementValue.round().toString(),
                  style: AppStyles.bodyText.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
            SizedBox(height: 25.h),

            // --- Question 2: What was your primary focus... (Text Input) ---
            Text(
              '2. What was your primary focus going into today?',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _primaryFocusController,
              hintText: 'Describe today\'s focus...',
              maxLines: 4,
            ),
            SizedBox(height: 25.h),

            // --- Question 3: How many at-bats... (Text Input) ---
            Text(
              '3. How many at-bats did you have today?',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _atBatsController,
              hintText: 'Enter number of at-bats...',
              maxLines: 1,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
            ),
            SizedBox(height: 25.h),

            // --- Question 4: What were the results... (Text Input) ---
            Text(
              '4. What were the results of your at-bats?',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _atBatResultsController,
              hintText: 'Enter today\'s results...',
              maxLines: 4,
            ),
            SizedBox(height: 25.h),

            // --- Question 5: What's something positive... (Text Input) ---
            Text(
              '5. What\'s something positive you can take away from today?',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _positiveOutcomeController,
              hintText: 'One positive thing about today...',
              maxLines: 4,
            ),
            SizedBox(height: 25.h),

            // --- Log Exercises Button ---
            showLogWidget
                ? _buildLogWidget()
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.cardColor,
                    foregroundColor: AppStyles.primaryColor,
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    setState(() {
                      showLogWidget = !showLogWidget;
                    });
                  },
                  child: const Text(
                    'Log Exercises for Future Ref.',
                    style: AppStyles.secondaryButtonTextStyle,
                  ),
                ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
      // --- Submit Button (Fixed at Bottom) ---
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          bottom: 20.h,
          top: 10.h,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.primaryColor,
            foregroundColor: Colors.black,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
          onPressed: isSubmitting ? null : submitHittingJournal,
          child: Text(
            isSubmitting ? 'Submitting...' : 'Submit',
            style: AppStyles.buttonTextStyle,
          ),
        ),
      ),
    );
  }

  // --- Helper Widget to build TextFields with consistent styling ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppStyles.inputTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.hintStyle,
        filled: true,
        fillColor: AppStyles.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: AppStyles.primaryColor,
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 12.h,
        ),
      ),
    );
  }

  Widget _buildLogWidget() {
    return Column(
      children: [
        Row(
          children: [
            Text('Log your exercise: ', style: AppStyles.bodyText),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  showLogWidget = !showLogWidget;
                });
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: logExerciseController,
          maxLines: 4,
          style: AppStyles.inputTextStyle,
          decoration: InputDecoration(
            hintText: 'List the exercises and reps you performed today...',
            hintStyle: AppStyles.hintStyle,
            filled: true,
            fillColor: AppStyles.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: AppStyles.primaryColor,
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }
}
