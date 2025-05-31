import 'package:baseball_ai/views/features/main_parent/home/sub_screens/notification_screen.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/services/api_service.dart';

// Assuming AppStyles exists in your project like this:
class AppStyles {
  static const Color backgroundColor = Color(0xFF1A1A1A); // Dark background
  static const Color primaryColor = Colors.yellow; // Yellow accent
  static const Color textColor = Colors.white;
  static const Color hintColor = Colors.grey;
  static const Color cardColor = Color(
    0xFF2C2C2C,
  ); // Slightly lighter grey for inputs/buttons
  static const Color checkboxActiveColor = primaryColor;
  static const Color checkboxInactiveColor =
      Colors.grey; // Border color when unchecked

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

  static const TextStyle smallBodyText = TextStyle(
    // For text inside parentheses
    color: textColor,
    fontSize: 14, // Slightly smaller
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
}

class LiftingScreen extends StatefulWidget {
  const LiftingScreen({super.key});

  @override
  State<LiftingScreen> createState() => _LiftingScreenState();
}

class _LiftingScreenState extends State<LiftingScreen> {
  // Text controller for logging exercises
  final TextEditingController logExerciseController = TextEditingController();

  // Updated to match backend validation - exact enum values
  Map<String, bool> liftTypeOptions = {
    'Upper Body': false,      // ✓ Matches backend
    'Total Body': false,      // ✓ Matches backend  
    'Speed & Agility': false, // ✓ Matches backend
    'Lower Body': false,      // ✓ Matches backend
    'Plyometrics': false,     // ✓ Matches backend
  };

  // Updated to match backend validation - simplified keys for exact enum matching
  Map<String, bool> focusOptions = {
    'Speed': false,       // Backend expects: "Speed" (not "Speed (fast movement execution)")
    'Eccentric': false,   // Backend expects: "Eccentric" (not "Eccentric (slow lowering phase)")
    'Isometric': false,   // Backend expects: "Isometric" (not "Isometric (holding position)")
    'Concentric': false,  // Backend expects: "Concentric" (not "Concentric (lifting phase emphasis)")
  };

  bool showLogWidget = false;
  bool isSubmitting = false;

  @override
  void dispose() {
    logExerciseController.dispose();
    super.dispose();
  }

  // Validate form data
  bool _validateForm() {
    // Check if at least one lift type is selected
    if (!liftTypeOptions.values.any((selected) => selected)) {
      Get.snackbar(
        'Validation Error',
        'Please select at least one lift type',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    // Check if at least one focus is selected
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

    return true;
  }

  // Get selected options as lists
  List<String> getSelectedLiftTypes() {
    return liftTypeOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  List<String> getSelectedFocus() {
    return focusOptions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  // Submit lifting data
  Future<void> submitLiftingData() async {
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
        'Lifting': {  // Note: Backend uses capital 'L' in 'Lifting'
          'liftingType': getSelectedLiftTypes(),  // Backend expects 'liftingType' (not 'liftTypes')
          'focus': getSelectedFocus(),            // Backend expects 'focus' (not 'variableFocus')
          'exercisesLog': showLogWidget && logExerciseController.text.trim().isNotEmpty
              ? logExerciseController.text.trim()
              : null,
        }
      };

      // Print for debugging
      print('Lifting Data:');
      print('Lifting Types: ${getSelectedLiftTypes()}');
      print('Focus: ${getSelectedFocus()}');
      print('Exercises Log: ${logExerciseController.text}');
      print('Request Data: $requestData');

      // Call API
      final response = await ApiService.submitLiftingData(
        request: requestData,
        token: token,
      );

      if (response == null || !response.success) {
        Get.snackbar(
          'Error',
          response?.message ?? 'Failed to submit lifting data',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }else if (response.message.isNotEmpty) {
        print('Response Message: ${response.message}');
         // Show success message
        Get.snackbar(
          'Success',
          'Lifting data submitted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }

     

      // Reset form
      _resetForm();

      // Navigate back
      // Get.back();

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
      // Reset all checkbox options
      for (String key in liftTypeOptions.keys) {
        liftTypeOptions[key] = false;
      }
      for (String key in focusOptions.keys) {
        focusOptions[key] = false;
      }

      // Reset text controller and widget visibility
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
        title: const Text('Lifting', style: AppStyles.headingTitle),
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
              'Log your strength training and conditioning work',
              style: AppStyles.bodyText.copyWith(color: AppStyles.hintColor),
            ),
            SizedBox(height: 25.h),

            // --- Lift Type Section ---
            _buildCheckboxSection(
              title: "What type of lifting did you perform today?",
              options: liftTypeOptions,
              childAspectRatio: 4 / 1,
            ),

            // --- Focus Section (Updated title to match simplified options) ---
            _buildCheckboxSection(
              title: "What was the focus of your lifting session?",
              options: focusOptions,
              childAspectRatio: 4 / 1, // Simplified text, so normal ratio is fine
            ),

            SizedBox(height: 30.h),

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
          onPressed: isSubmitting ? null : submitLiftingData,
          child: Text(
            isSubmitting ? 'Submitting...' : 'Submit',
            style: AppStyles.buttonTextStyle,
          ),
        ),
      ),
    );
  }

  // --- Helper Widget for Checkbox Sections ---
  Widget _buildCheckboxSection({
    required String title,
    required Map<String, bool> options,
    double childAspectRatio = 4 / 1, // Default aspect ratio
  }) {
    List<String> keys = options.keys.toList();

    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.labelText),
          SizedBox(height: 15.h),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              String key = keys[index];
              return _buildCheckboxTile(key, options);
            },
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for a single Checkbox Tile ---
  Widget _buildCheckboxTile(String key, Map<String, bool> optionsMap) {
    return GestureDetector(
      onTap: () {
        setState(() {
          optionsMap[key] = !(optionsMap[key] ?? false);
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: optionsMap[key] ?? false,
            onChanged: (bool? newValue) {
              setState(() {
                optionsMap[key] = newValue ?? false;
              });
            },
            activeColor: AppStyles.checkboxActiveColor,
            checkColor: Colors.black,
            side: MaterialStateBorderSide.resolveWith(
              (states) {
                if (states.contains(MaterialState.selected)) {
                  return const BorderSide(
                    color: AppStyles.checkboxActiveColor,
                    width: 2,
                  );
                }
                return const BorderSide(
                  color: AppStyles.checkboxInactiveColor,
                  width: 2,
                );
              },
            ),
            visualDensity: const VisualDensity(
              horizontal: -4,
              vertical: -4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Flexible(
            child: Text(
              key,
              style: AppStyles.bodyText, // Use normal body text since options are simpler now
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
          style: AppStyles.bodyText,
          decoration: const InputDecoration(
            hintText: 'List the exercise, and reps you performed today...',
            hintStyle: AppStyles.hintStyle,
            filled: true,
            fillColor: AppStyles.cardColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
