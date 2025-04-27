import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/boarding/screens/core_values_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
// remove if not needed: import 'package:flutter/widgets.dart'; // Redundant import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// remove if not needed: import 'package:get/get_core/src/get_main.dart'; // Redundant import

// Use StatefulWidget for local state management (radio buttons, password visibility)
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // State variables
  bool _isPasswordVisible = false;
  String? _selectedPlayerType; // To hold the selected player type
  String? _selectedJournalFrequency; // To hold the selected journal frequency
  String? _selectedLevelOfSport; // To hold the selected level of sport

  // List of options for the Level of Sport dropdown
  final List<String> _levelOfSportOptions = [
    'school',
    'college',
    'professional',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Padding(
        // Consistent padding
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          // Use bottom: false if the button should be edge-to-edge at the bottom outside safe area
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h), // Top padding inside safe area
                Text(
                  'Welcome',
                  // Match font size from image more closely if needed
                  style: AppStyles.headingLarge.copyWith(
                    fontSize: 55.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Select 6 words that best represent your core\nvalues.', // Added line break for better fit
                  style: AppStyles.bodySmall.copyWith(
                    color: AppStyles.subtitleColor,
                    fontSize: 16.sp, // Slightly larger subtitle
                    height: 1.4, // Line height
                  ),
                ),
                SizedBox(height: 30.h),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Name ---
                      Text('Name', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h), // Consistent spacing
                      TextFormField(
                        style: AppStyles.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Enter your name...',
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ), // Increased spacing between fields
                      // --- Email ---
                      Text('Email', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),
                      TextFormField(
                        style: AppStyles.bodySmall,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email...',
                        ),
                      ),
                      SizedBox(height: 18.h),

                      // --- Password ---
                      Text('Password', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),
                      TextFormField(
                        style: AppStyles.bodySmall,
                        obscureText: !_isPasswordVisible, // Toggle visibility
                        decoration: InputDecoration(
                          hintText: 'Enter your password...',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppStyles.subtitleColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Text('Level of Sport', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),

                      DropdownButtonFormField<String>(
                        value: _selectedLevelOfSport, // Bind to state variable
                        style: AppStyles.bodySmall.copyWith(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'school, college etc...', // Hint text
                          // Style for the hint text (can make it slightly less opaque like in the image)
                          hintStyle: TextStyle(color: Colors.white),
                          labelStyle: AppStyles.bodySmall.copyWith(
                            color:
                                Colors
                                    .white, // Styles a potential labelText, not the label above
                          ),
                          // --- ADDED: Border Styling to match the image ---
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white54,
                              width: 1.0,
                            ), // Light grey border
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ), // Rounded corners
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ), // White border when focused
                            borderRadius: BorderRadius.circular(8.0),
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 12.0,
                          ), // Adjust padding if needed
                        ),
                        icon: Icon(
                          // Custom dropdown icon
                          Icons.keyboard_arrow_down_rounded,
                          color:
                              AppStyles
                                  .subtitleColor, // Use your subtitle color

                          size: 28.0, // Assuming 28.sp resolves to roughly 28.0
                        ),
                        isExpanded:
                            true, // Make the dropdown take the full width
                        dropdownColor:
                            AppStyles
                                .backgroundColor, // Set dropdown menu background
                        items:
                            _levelOfSportOptions.map((String level) {
                              return DropdownMenuItem<String>(
                                value: level,
                                child: Text(
                                  level.capitalizeFirst!,
                                  style: AppStyles.bodySmall.copyWith(
                                    color:
                                        Colors
                                            .white, // Set text color explicitly for the dropdown items
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis, // Prevent overflow
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLevelOfSport = newValue;
                          });
                        },
                      ),
                      SizedBox(height: 18.h),

                      // --- Player Type ---
                      Text('Player Type', style: AppStyles.bodyMedium),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          _buildRadioOption<String>(
                            title: 'Pitcher',
                            value: 'pitcher',
                            groupValue: _selectedPlayerType,
                            onChanged:
                                (value) =>
                                    setState(() => _selectedPlayerType = value),
                          ),
                          SizedBox(width: 25.w),
                          _buildRadioOption<String>(
                            title: 'Position Player',
                            value: 'position_player',
                            groupValue: _selectedPlayerType,
                            onChanged:
                                (value) =>
                                    setState(() => _selectedPlayerType = value),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),

                      // --- Journal Frequency ---
                      Text(
                        'How often do you journal?',
                        style: AppStyles.bodyMedium,
                      ),
                      SizedBox(height: 10.h),
                      // Use Column for vertical stacking or adjust Row wrapping if needed
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // First row of radio buttons
                            children: [
                              _buildRadioOption<String>(
                                title: 'Never tried it',
                                value: 'Never',
                                groupValue: _selectedJournalFrequency,
                                onChanged:
                                    (value) => setState(
                                      () => _selectedJournalFrequency = value,
                                    ),
                              ),
                              SizedBox(width: 25.w),
                              _buildRadioOption<String>(
                                title: 'Dabbled a little',
                                value: 'Dabbled',
                                groupValue: _selectedJournalFrequency,
                                onChanged:
                                    (value) => setState(
                                      () => _selectedJournalFrequency = value,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ), // Space before the next radio button
                          _buildRadioOption<String>(
                            // Second row (single button)
                            title: 'Pretty consistent',
                            value: 'Consistent',
                            groupValue: _selectedJournalFrequency,
                            onChanged:
                                (value) => setState(
                                  () => _selectedJournalFrequency = value,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h), // Space before AI Guidance card
                      // --- AI Guidance ---
                      Container(
                        width: double.infinity, // Take full width
                        decoration: BoxDecoration(
                          color:
                              AppStyles.cardColor, // Use card color from styles
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w, // Inner padding
                            vertical: 15.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Guidance',
                                style: AppStyles.bodyMedium.copyWith(
                                  fontSize: 18.sp,
                                ),
                              ), // Slightly larger title
                              SizedBox(height: 8.h),
                              Text(
                                // Ensure text matches image - use exact text if possible
                                'Prism Sports Joumal is designed to empower athletes to log their daily habits and workloads, ensuring they can track their progress and reflect on their performance throughout a long, challenging season. Meanwhile, Coach PJ, your AI coach, continuously monitors and logs this information on the backend to provide guidance, keep you consistent, and offer support when you\'re feeling lost',
                                style: AppStyles.bodySmall.copyWith(
                                  color: AppStyles.subtitleColor,
                                  height:
                                      1.5, // Adjust line height for readability
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h), // Space before Button
                      // --- Next Button ---
                      MyTextButton(
                        isOutline: false,
                        buttonText: 'Next',
                        onTap: () {
                          // Add form validation here if needed before navigating
                          // Access selected values like:
                          // print('Name: ${nameController.text}'); // (if using controllers)
                          // print('Email: ${emailController.text}'); // (if using controllers)
                          // print('Password: ${passwordController.text}'); // (if using controllers)
                          print('Level of Sport: $_selectedLevelOfSport');
                          print('Player Type: $_selectedPlayerType');
                          print(
                            'Journal Frequency: $_selectedJournalFrequency',
                          );

                          Get.to(
                            () => const CoreValuesScreen(),
                          ); // Ensure CoreValuesScreen is imported
                        },
                      ),
                      SizedBox(height: 20.h), // Bottom padding
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to build styled radio buttons
  Widget _buildRadioOption<T>({
    required String title,
    required T value,
    required T? groupValue,
    required ValueChanged<T?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(value), // Allow tapping the whole area
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Prevent row from taking excessive space
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppStyles.primaryColor, // Yellow when selected
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return AppStyles.primaryColor; // Yellow inner circle
              }
              return AppStyles.subtitleColor; // Grey border when unselected
            }),
            visualDensity: VisualDensity.compact, // Make it smaller
          ),
          // SizedBox(width: 4.w), // Reduced space between radio and text
          Text(
            title,
            style: AppStyles.bodyMedium.copyWith(
              color:
                  groupValue == value ? Colors.white : AppStyles.subtitleColor,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
