import 'package:baseball_ai/views/features/main_parent/home/sub_screens/notification_screen.dart'; // Assuming this path is correct
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Assuming GetX is used

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
  State<HittingJournalScreen> createState() => _HittingJournalScreenState(); // Renamed State class
}

class _HittingJournalScreenState extends State<HittingJournalScreen> {
  // State for the slider
  double _dialedInValue = 7.0; // Initial value based on the image

  // Controllers for text fields
  final TextEditingController _primaryFocusController = TextEditingController();
  final TextEditingController _atBatsController = TextEditingController();
  final TextEditingController _atBatsResultsController =
      TextEditingController();
  final TextEditingController _somethingPositiveController =
      TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    _primaryFocusController.dispose();
    _atBatsController.dispose();
    _atBatsResultsController.dispose();
    _somethingPositiveController.dispose();
    super.dispose();
  }

  bool showLogWidget = false;

  @override
  Widget build(BuildContext context) {
    // Ensure ScreenUtil is initialized if used in other parts of your app
    // If not, you might need to initialize it here or wrap your MaterialApp.
    // ScreenUtil.init(context, designSize: Size(360, 690)); // Example initialization

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
                color: Colors.grey.withOpacity(0.3), // Circle background
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_outlined, // Or Icons.notifications
                color: AppStyles.textColor,
                size: 24,
              ),
            ),
            onPressed: () {
              // Handle notification tap - Ensure NotificationScreen exists
              Get.to(() => NotificationScreen());
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
            // Introductory text (matches the image text)
            Text(
              'Track your arm care routines and recovery modalities', // Text from the image
              style: AppStyles.bodyText.copyWith(color: AppStyles.hintColor),
            ),
            SizedBox(height: 25.h),

            // --- Question 1: How dialed in were you... (Slider) ---
            Text(
              '1. How dialed in were you during your pregame routine today? (Batting practice. tee work. drills. movement prep. etc)',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                // Slider
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 8.h, // Adjust track height
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 10.0,
                      ), // Adjust thumb size
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 20.0,
                      ), // Adjust overlay size
                      activeTrackColor: AppStyles.primaryColor, // Yellow track
                      inactiveTrackColor:
                          AppStyles.cardColor, // Dark grey inactive track
                      thumbColor: AppStyles.textColor, // White thumb
                      overlayColor: AppStyles.primaryColor.withOpacity(
                        0.2,
                      ), // Yellow overlay
                      valueIndicatorColor:
                          AppStyles.primaryColor, // Value indicator color
                      valueIndicatorTextStyle:
                          AppStyles
                              .buttonTextStyle, // Value indicator text style
                    ),
                    child: Slider(
                      value: _dialedInValue,
                      min: 1.0, // Assuming a scale of 1 to 10
                      max: 10.0,
                      divisions: 9, // 1 through 10
                      label: _dialedInValue.round().toString(),
                      onChanged: (newValue) {
                        setState(() {
                          _dialedInValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10.w), // Space between slider and number
                // Display the current value
                Text(
                  _dialedInValue.round().toString(),
                  style: AppStyles.bodyText.copyWith(
                    fontSize: 18.sp,
                  ), // Larger text for number
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
              maxLines: 4, // Multiple lines
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
              hintText: '....', // Hint text from image
              maxLines: 1, // Single line
              keyboardType: TextInputType.numberWithOptions(
                decimal: false,
              ), // Suggest numeric keyboard
            ),
            SizedBox(height: 25.h),

            // --- Question 4: What were the results... (Text Input) ---
            Text(
              '4. What were the results of your at-bats?',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _atBatsResultsController,
              hintText: 'Enter today\'s results...', // Hint text from image
              maxLines: 4, // Multiple lines
            ),
            SizedBox(height: 25.h),

            // --- Question 5: What's something positive... (Text Input) ---
            Text(
              '5. What\'s something positive you can take away from today?',
              style: AppStyles.labelText,
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _somethingPositiveController,
              hintText:
                  'One positive thing about today...', // Hint text from image
              maxLines: 4, // Multiple lines
            ),
            SizedBox(height: 25.h), // Space before the Log Exercises button
            // --- Log Exercises Button (from image) ---
            SizedBox(height: 20.h),

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
            ), // Space before the final submit button (adjust as needed)
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
            // Handle submission - Access data from state and controllers
            print('Dialed In Value: ${_dialedInValue.round()}');
            print('Primary Focus: ${_primaryFocusController.text}');
            print('At Bats: ${_atBatsController.text}');
            print('At Bats Results: ${_atBatsResultsController.text}');
            print('Something Positive: ${_somethingPositiveController.text}');
            // Add logic to save or process the data
          },
          child: const Text('Submit', style: AppStyles.buttonTextStyle),
        ),
      ),
    );
  }

  // --- Helper Widget to build TextFields with consistent styling ---
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1, // Default to single line
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppStyles.inputTextStyle, // Use the new input text style
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.hintStyle,
        filled: true,
        fillColor: AppStyles.cardColor, // Dark grey background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r), // Rounded corners
          borderSide: BorderSide.none, // No visible border line
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
          ), // Highlight with yellow border when focused
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 12.h,
        ), // Adjust padding inside
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
