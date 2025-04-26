import 'package:baseball_ai/views/features/main_parent/home/sub_screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters
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
  ); // Slightly lighter grey for inputs
  static const Color radioActiveColor =
      primaryColor; // Yellow for selected radio
  static const Color radioInactiveColor = Colors.grey;

  static const TextStyle headingTitle = TextStyle(
    color: textColor,
    fontSize: 20, // Adjust as needed
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText = TextStyle(
    color: textColor,
    fontSize: 15, // Adjust as needed
    height: 1.4, // Improve readability for multi-line text
  );

  static const TextStyle labelText = TextStyle(
    color: textColor,
    fontSize: 16, // Adjust as needed
    fontWeight: FontWeight.w500,
  );

  static const TextStyle smallLabelText = TextStyle(
    // For text above text fields
    color: textColor,
    fontSize: 14, // Adjust as needed
    fontWeight: FontWeight.normal,
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
}

// Enum for the radio button choices
enum WorkloadEnvironment { controlled, inGame }

class HomeThrowingJournalScreen extends StatefulWidget {
  const HomeThrowingJournalScreen({super.key});

  @override
  State<HomeThrowingJournalScreen> createState() =>
      _HomeThrowingJournalScreenState();
}

class _HomeThrowingJournalScreenState extends State<HomeThrowingJournalScreen> {
  // Text Editing Controllers
  final _drillsController = TextEditingController();
  final _toolsController = TextEditingController();
  final _setsRepsController = TextEditingController();
  final _longTossDistController = TextEditingController();
  final _pitchCountController = TextEditingController();
  final _focusController = TextEditingController();

  // Radio Button State
  WorkloadEnvironment? _selectedEnvironment =
      WorkloadEnvironment.controlled; // Default selection

  @override
  void dispose() {
    // Dispose controllers
    _drillsController.dispose();
    _toolsController.dispose();
    _setsRepsController.dispose();
    _longTossDistController.dispose();
    _pitchCountController.dispose();
    _focusController.dispose();
    super.dispose();
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
        title: const Text('Throwing Journal', style: AppStyles.headingTitle),
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
              'Track your throwing sessions',
              style: AppStyles.bodyText.copyWith(color: AppStyles.hintColor),
            ),
            SizedBox(height: 25.h),

            // --- What drills ---
            _buildTextFieldSection(
              label: 'What drills did you do today?',
              controller: _drillsController,
              hint: 'List the drills you performed...',
              maxLines: 4,
              keyboardType: TextInputType.multiline,
            ),

            // --- Training tools ---
            _buildTextFieldSection(
              label:
                  '"Did you use any training tools or instruments today?\nExamples such as: plyo balls, Tidaltank, towel drills, Core Velocity Belt, etc-T"',
              controller: _toolsController,
              hint:
                  'Describe any tool or requipment used...', // Typo "requipment" kept from image
              maxLines: 4,
              keyboardType: TextInputType.multiline,
            ),

            // --- Sets and Reps ---
            _buildTextFieldSection(
              label:
                  'How many sets and reps did you perform for each exercise or drill?',
              controller: _setsRepsController,
              hint: 'Details of your sets and reps...',
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),

            // --- Long Toss Distance ---
            _buildTextFieldSection(
              label: 'If you long-tossed, how far did you throw? (in feet)',
              controller: _longTossDistController,
              hint: 'e.g., 120',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ], // Allow only numbers
              suffixIcon:
                  Icons.access_time, // As per image, though maybe not logical
            ),

            // --- Pitch Count ---
            _buildTextFieldSection(
              label:
                  'If you threw off the mound today, how many pitches did you throw in your bullpen or in game today?',
              controller: _pitchCountController,
              hint: 'e.g., 120',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ], // Allow only numbers
              suffixIcon: Icons.access_time, // As per image
            ),

            // --- Focus ---
            _buildTextFieldSection(
              label: 'What was your focus?',
              controller: _focusController,
              hint:
                  'Describe what you focused on today...', // Quote marks included as per image hint
              maxLines: 3,
              keyboardType: TextInputType.multiline,
            ),

            // --- Workload Environment ---
            Text(
              'Was your workload in a controlled environment or in-game?',
              style: AppStyles.smallLabelText, // Smaller label style
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _buildRadioButton(
                  title: 'Controlled(Bullpen/ Practice)',
                  value: WorkloadEnvironment.controlled,
                ),
                SizedBox(width: 20.w), // Space between radio buttons
                _buildRadioButton(
                  title: 'In Game',
                  value: WorkloadEnvironment.inGame,
                ),
              ],
            ),

            SizedBox(height: 40.h), // Space before button
          ],
        ),
      ),
      // --- Submit Button (Fixed at Bottom) ---
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
            print('Drills: ${_drillsController.text}');
            print('Tools: ${_toolsController.text}');
            print('Sets/Reps: ${_setsRepsController.text}');
            print('Long Toss: ${_longTossDistController.text}');
            print('Pitch Count: ${_pitchCountController.text}');
            print('Focus: ${_focusController.text}');
            print('Environment: ${_selectedEnvironment?.toString()}');
          },
          child: const Text('Submit', style: AppStyles.buttonTextStyle),
        ),
      ),
    );
  }

  // --- Helper Widget for Text Field Sections ---
  Widget _buildTextFieldSection({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h), // Space below each section
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.smallLabelText,
          ), // Use smaller label style
          SizedBox(height: 10.h),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: AppStyles.bodyText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppStyles.hintStyle,
              filled: true,
              fillColor: AppStyles.cardColor, // Input background
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 12.h,
              ), // Adjust padding
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Colors.grey.shade700,
                ), // Border color
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppStyles.primaryColor,
                ), // Focused border
              ),
              suffixIcon:
                  suffixIcon != null
                      ? Icon(suffixIcon, color: AppStyles.hintColor, size: 20)
                      : null,
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for Radio Button ---
  Widget _buildRadioButton({
    required String title,
    required WorkloadEnvironment value,
  }) {
    return GestureDetector(
      // Make the text tappable as well
      onTap: () {
        setState(() {
          _selectedEnvironment = value;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min, // Keep row tight
        children: [
          Radio<WorkloadEnvironment>(
            value: value,
            groupValue: _selectedEnvironment,
            onChanged: (WorkloadEnvironment? newValue) {
              setState(() {
                _selectedEnvironment = newValue;
              });
            },
            activeColor: AppStyles.radioActiveColor,
            fillColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return AppStyles.radioActiveColor; // Color of the dot
              }
              return AppStyles
                  .radioInactiveColor; // Color of the circle border when unselected
            }),
            visualDensity: const VisualDensity(
              horizontal: -4,
              vertical: -4,
            ), // Make radio smaller
          ),
          // SizedBox(width: 4.w), // Small space between radio and text
          Text(title, style: AppStyles.bodyText),
        ],
      ),
    );
  }
}
