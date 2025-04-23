import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();

  // Define colors for easy reuse and modification
  static const Color darkBackground = Color(0xFF121212); // Very dark grey
  static const Color inputBackground = Color(
    0xFF3A3A3C,
  ); // Darker grey for input
  static const Color primaryYellow = Color(0xFFFFD60A); // Same yellow as before
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey; // Grey text
  static const Color hintColor = Color(0xFF8E8E93); // Lighter grey for hint

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textPrimary),
          onPressed: () {
            // Handle back navigation
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'AI Chat',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true, // Center the title
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
            ), // Adjust padding slightly
            child: CircleAvatar(
              radius: 18,
              backgroundColor: inputBackground, // Use input bg for consistency
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: textPrimary,
                  size: 22,
                ),
                onPressed: () {
                  // Handle notification tap
                },
                tooltip: 'Notifications', // Add tooltip for accessibility
                padding: EdgeInsets.zero, // Remove default padding
                constraints: const BoxConstraints(), // Remove constraints
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // This makes the welcome message area take up available space
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Size column to its children
                  children: [
                    const Text(
                      'Welcome to Your Personal',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textPrimary, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: '"', // Opening quote
                        style: const TextStyle(
                          color: primaryYellow,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Ask Coach PJ'), // Yellow text
                          const TextSpan(text: '"'), // Closing quote
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '"What\'s up Simi! What do you got today?"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 16,
                        // fontStyle: FontStyle.italic, // Optional: if you want italic
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Input field area at the bottom
          Container(
            decoration: BoxDecoration(
              color: AppStyles.cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25..h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TextField(
                  scrollPadding: EdgeInsets.symmetric(horizontal: 10.w),
                  style: AppStyles.bodySmall.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    hintText: 'Message with coach Pj...',
                    hintStyle: AppStyles.bodySmall.copyWith(
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppIcons.send,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
