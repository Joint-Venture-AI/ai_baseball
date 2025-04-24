import 'package:baseball_ai/views/features/main_parent/home/sub_screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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

class ArmCareScreen extends StatefulWidget {
  const ArmCareScreen({super.key});

  @override
  State<ArmCareScreen> createState() => _ArmCareScreenState();
}

class _ArmCareScreenState extends State<ArmCareScreen> {
  // State maps for checkboxes
  Map<String, bool> focusOptions = {
    'Scapular Emphasis': false,
    'Shoulder Emphasis': false,
    'Forearms': false,
    'Biceps/Triceps': false,
  };

  Map<String, bool> exerciseFocusOptions = {
    'Isometric': false,
    'Eccentric': false,
    'Oscillating': false,
  };

  Map<String, bool> recoveryOptions = {
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
  };

  bool showLogWidget = false;

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
        title: const Text('Arm Care', style: AppStyles.headingTitle),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3), // Circle background
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined, // Or Icons.notifications
                color: AppStyles.textColor,
                size: 24, // Adjust size
              ),
            ),
            onPressed: () {
              // Handle notification tap
              Get.to(NotificationScreen());
            },
          ),
          SizedBox(width: 10.w), // Add some padding
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track your arm care routines and recovery modalities',
              style: AppStyles.bodyText.copyWith(color: AppStyles.hintColor),
            ),
            SizedBox(height: 25.h),

            // --- Focus Section ---
            _buildCheckboxSection(
              title: "What was your focus for today's arm care?",
              options: focusOptions,
            ),

            // --- Exercise Focus Section ---
            _buildCheckboxSection(
              title:
                  "Was there an isometric, oscillating, or eccentric focus to these exercises?",
              options: exerciseFocusOptions,
            ),

            // --- Recovery Modalities Section ---
            _buildCheckboxSection(
              title: "What type of recovery modalities did you perform today?",
              options: recoveryOptions,
              showOthers: true, // Add the "Others" option here
            ),

            SizedBox(height: 10.h),

            // --- Log Exercises Button ---
            showLogWidget
                ? _buildLogWidget()
                : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.cardColor, // Darker background
                    foregroundColor: AppStyles.primaryColor, // Yellow text
                    minimumSize: Size(double.infinity, 50.h), // Full width
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25.r,
                      ), // Rounded corners
                    ),
                    elevation: 0, // No shadow
                  ),
                  onPressed: () {
                    // Handle Log Exercises tap
                    setState(() {
                      showLogWidget = !showLogWidget;
                    });
                    print("Log Exercises Tapped");
                  },
                  child: const Text(
                    'Log Exercises for Future Ref.',
                    style: AppStyles.secondaryButtonTextStyle,
                  ),
                ),

            SizedBox(
              height: 20.h,
            ), // Space before the final submit button if needed
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
        ), // Adjust padding
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppStyles.primaryColor,
            foregroundColor: Colors.black, // Text color
            minimumSize: Size(double.infinity, 50.h), // Full width
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r), // Rounded corners
            ),
          ),
          onPressed: () {
            // Handle submission
            print('Focus Options: $focusOptions');
            print('Exercise Focus: $exerciseFocusOptions');
            print('Recovery Options: $recoveryOptions');
          },
          child: const Text('Submit', style: AppStyles.buttonTextStyle),
        ),
      ),
    );
  }

  // --- Helper Widget for Checkbox Sections ---
  Widget _buildCheckboxSection({
    required String title,
    required Map<String, bool> options,
    bool showOthers = false,
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
            padding: EdgeInsets.zero, // Remove default GridView padding
            shrinkWrap: true, // Important for GridView inside Column/ScrollView
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              childAspectRatio:
                  4 / 1, // Adjust aspect ratio (width/height) for item size
              crossAxisSpacing: 10.w, // Horizontal spacing
              mainAxisSpacing: 10.h, // Vertical spacing
            ),
            itemCount:
                keys.length +
                (showOthers ? 1 : 0), // Add 1 for "Others" if needed
            itemBuilder: (context, index) {
              if (showOthers && index == keys.length) {
                // Build the "Others" item
                return _buildOthersOption();
              }
              // Build regular checkbox item
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
      // Make text tappable
      onTap: () {
        setState(() {
          optionsMap[key] = !(optionsMap[key] ?? false);
        });
      },
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Prevent row from expanding unnecessarily
        children: [
          Checkbox(
            value: optionsMap[key] ?? false,
            onChanged: (bool? newValue) {
              setState(() {
                optionsMap[key] = newValue ?? false;
              });
            },
            activeColor: AppStyles.checkboxActiveColor,
            checkColor: Colors.black, // Color of the checkmark
            side: MaterialStateBorderSide.resolveWith(
              // Border style
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
            ), // Compact size
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ), // Slightly rounded square
          ),
          // SizedBox(width: 4.w), // Optional small space
          Flexible(
            // Allow text to wrap if needed, though unlikely with aspect ratio
            child: Text(
              key,
              style: AppStyles.bodyText,
              overflow: TextOverflow.ellipsis, // Prevent overflow issues
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for the "Others" option ---
  Widget _buildOthersOption() {
    return GestureDetector(
      onTap: () {
        // Handle "Others" tap - e.g., show a dialog or navigate
        print("Others Tapped");
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add padding to align with checkbox visually
          SizedBox(width: 12.w),
          Icon(Icons.add, color: AppStyles.textColor, size: 20.sp),
          SizedBox(width: 8.w),
          Text('Others', style: AppStyles.bodyText),
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
              icon: Icon(Icons.cancel, color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'List the exercise, and reps you performed today...',
          ),
        ),
      ],
    );
  }
}
