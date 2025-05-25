import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// Use StatefulWidget for local state management (radio buttons, password visibility)
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Get or initialize the auth controller
  late final AuthController authController;
  
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Initialize AuthController if not already available
    if (Get.isRegistered<AuthController>()) {
      authController = Get.find<AuthController>();
    } else {
      authController = Get.put(AuthController());
    }
  }
  
  // State variables
  bool _isPasswordVisible = false;
  String? _selectedPlayerType; // To hold the selected player type
  String? _selectedJournalFrequency; // To hold the selected journal frequency
  String? _selectedLevelOfSport; // To hold the selected level of sport
  DateTime? _selectedBirthDate; // To hold the selected birth date
  final TextEditingController _threeWordsController = TextEditingController(); // Controller for three words field

  @override
  void dispose() {
    _threeWordsController.dispose();
    super.dispose();
  }

  // List of options for the Level of Sport dropdown
  final List<String> _levelOfSportOptions = [
    'School',
    'College',
    'Professional',
    'Other',
  ];

  // Handle signup process
  void _handleSignup() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate dropdown selections
    if (_selectedLevelOfSport == null) {
      Get.snackbar(
        'Validation Error',
        'Please select your level of sport',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_selectedPlayerType == null) {
      Get.snackbar(
        'Validation Error',
        'Please select your player type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_selectedJournalFrequency == null) {
      Get.snackbar(
        'Validation Error',
        'Please select how often you journal',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (_selectedBirthDate == null) {
      Get.snackbar(
        'Validation Error',
        'Please select your date of birth',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Map journal frequency to API format
    String journalFrequencyApi;
    switch (_selectedJournalFrequency) {
      case 'Never':
        journalFrequencyApi = 'Never tried it';
        break;
      case 'Dabbled':
        journalFrequencyApi = 'Dabbled a little';
        break;
      case 'Consistent':
        journalFrequencyApi = 'Pretty consistent';
        break;
      default:
        journalFrequencyApi = 'Never tried it';
    }

    // Call the signup method
    await authController.signup(
      name: authController.nameController.text.trim(),
      email: authController.emailController.text.trim(),
      password: authController.passwordController.text.trim(),
      levelOfSport: _selectedLevelOfSport!,
      playerType: _selectedPlayerType!,
      howOftenDoYouJournal: journalFrequencyApi,
      threeWordThtDescribeYou: _threeWordsController.text.trim().isNotEmpty 
          ? _threeWordsController.text.trim() 
          : null,
      birthDate: _selectedBirthDate,
    );
  }

  // Method to select birth date
  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedBirthDate ?? DateTime(2000), // Default to year 2000
      firstDate: DateTime(1950), // Earliest allowed date
      lastDate: DateTime.now().subtract(Duration(days: 365 * 10)), // Must be at least 10 years old
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppStyles.primaryColor,
              onPrimary: Colors.black,
              surface: AppStyles.cardColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

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
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Name ---
                      Text('Name', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h), // Consistent spacing
                      TextFormField(
                        controller: authController.nameController,
                        style: AppStyles.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'Enter your name...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 18.h,
                      ), // Increased spacing between fields
                      // --- Email ---
                      Text('Email', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: authController.emailController,
                        style: AppStyles.bodySmall,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value.trim())) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 18.h),

                      // --- Password ---
                      Text('Password', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: authController.passwordController,
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
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 18.h),

                      // --- Date of Birth ---
                      Text('Date of Birth', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () => _selectBirthDate(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedBirthDate != null
                                    ? '${_selectedBirthDate!.day}/${_selectedBirthDate!.month}/${_selectedBirthDate!.year}'
                                    : 'Select your birth date...',
                                style: AppStyles.bodySmall.copyWith(
                                  color: _selectedBirthDate != null 
                                      ? Colors.white 
                                      : Colors.white54,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: AppStyles.subtitleColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),

                      // --- Three Words That Describe You ---
                      Text('Three Words That Describe You (Optional)', style: AppStyles.bodyMedium),
                      SizedBox(height: 8.h),
                      TextFormField(
                        controller: _threeWordsController,
                        style: AppStyles.bodySmall,
                        decoration: InputDecoration(
                          hintText: 'e.g., Determined, Focused, Resilient...',
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
                                  level,
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
                            value: 'Pitcher',
                            groupValue: _selectedPlayerType,
                            onChanged:
                                (value) =>
                                    setState(() => _selectedPlayerType = value),
                          ),
                          SizedBox(width: 25.w),
                          _buildRadioOption<String>(
                            title: 'Position Player',
                            value: 'Position Player',
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
                      Obx(() => MyTextButton(
                        isOutline: false,
                        buttonText: authController.isSignupLoading.value 
                            ? 'Creating Account...' 
                            : 'Next',
                        onTap: () {
                          if (!authController.isSignupLoading.value) {
                            _handleSignup();
                          }
                        },
                      )),
                      SizedBox(height: 15.h),
                      // Login link for existing users
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppStyles.subtitleColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.toNamed(AppRoute.signIn),
                            child: Text(
                              'Login',
                              style: AppStyles.bodySmall.copyWith(
                                color: AppStyles.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
