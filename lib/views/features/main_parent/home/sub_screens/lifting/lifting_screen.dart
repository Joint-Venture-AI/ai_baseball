import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  // State maps for checkboxes
  Map<String, bool> liftTypeOptions = {
    'Upper Body': false,
    'Lower Body': false,
    'Total Body': false,
    'Plyometrics': false,
    'Speed & Agility': false,
  };

  // Using descriptive keys for easier identification later
  Map<String, bool> variableFocusOptions = {
    'Speed (fast movement execution)': false,
    'Eccentric (slow lowering phase)': false,
    'Isometric (holding position)': false,
    'Concentric (lifting phase emphasis)': false,
  };

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
              'Log your strength training and conditioning work',
              style: AppStyles.bodyText.copyWith(color: AppStyles.hintColor),
            ),
            SizedBox(height: 25.h),

            // --- Lift Type Section ---
            _buildCheckboxSection(
              title: "What type of lifting did you perform today?",
              options: liftTypeOptions,
              // Adjust aspect ratio if needed based on number of items
              childAspectRatio: 4 / 1,
            ),

            // --- Variable Focus Section ---
            _buildCheckboxSection(
              title: "Did the lift focus on any variables?",
              options: variableFocusOptions,
              // This group has longer text, potentially needing more height
              childAspectRatio: 4.5 / 1, // Increase height slightly
            ),

            SizedBox(height: 30.h),

            // --- Log Exercises Button ---
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.cardColor, // Darker background
                foregroundColor: AppStyles.primaryColor, // Yellow text
                minimumSize: Size(double.infinity, 50.h), // Full width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r), // Rounded corners
                ),
                elevation: 0, // No shadow
              ),
              onPressed: () {
                // Handle Log Exercises tap
                print("Log Exercises and Set/Reps Tapped");
              },
              child: const Text(
                'Log Exercises and Set/Reps',
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
            print('Lift Type Options: $liftTypeOptions');
            print('Variable Focus Options: $variableFocusOptions');
          },
          child: const Text('Submit', style: AppStyles.buttonTextStyle),
        ),
      ),
    );
  }

  // --- Helper Widget for Checkbox Sections (Reused from ArmCareScreen) ---
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
            padding: EdgeInsets.zero, // Remove default GridView padding
            shrinkWrap: true, // Important for GridView inside Column/ScrollView
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView scrolling
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              childAspectRatio: childAspectRatio, // Use parameter
              crossAxisSpacing: 10.w, // Horizontal spacing
              mainAxisSpacing: 12.h, // Vertical spacing adjusted slightly
            ),
            itemCount: keys.length, // No "Others" option here
            itemBuilder: (context, index) {
              String key = keys[index];
              return _buildCheckboxTile(
                key,
                options,
              ); // Build regular checkbox item
            },
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for a single Checkbox Tile (Reused from ArmCareScreen) ---
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
            // Allow text to wrap
            child: Text(
              key,
              style:
                  AppStyles
                      .smallBodyText, // Use slightly smaller text for checkbox labels
              overflow:
                  TextOverflow
                      .visible, // Allow text to wrap onto next line if needed
            ),
          ),
        ],
      ),
    );
  }
}
