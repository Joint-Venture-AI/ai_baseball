import 'package:baseball_ai/core/utils/const/app_route.dart';
import 'package:baseball_ai/views/features/boarding/screens/welcome_screen.dart';
import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define the data for each onboarding screen
final List<Map<String, String>> onboardingData = [
  {
    'title': 'Define your foundation',
    'description':
        'Every aspiring athlete-s journey starts with knowing who they are— define your strengths, identify your gaps, and build your game with intention.',
    'quote':
        '"When the lights go off and the crowd is gone, your identity needs to be stronger than the jersey you wear."',
    'author': '-Inky Johnson',
  },

  {
    'title': 'Discover your athletic identity',
    'description':
        'Understand what drives you-your core values are your compass when is on and everybody\'s watching.',
    'quote':
        '"I never let winning define me. I define myself by how I carry my character and values, whether I win or lose."',
    'author': '-Simone Biles',
  },
  {
    'title': 'Peak performance starts here',
    'description':
        'It\'s time to lock it in, define your direction, and take the first step towards finding your daily blueprint',
    'quote': '"...Results come when you commit to the work nobody sees."',
    'author': '-Alex Rodriguez',
  },
];

// Using a simple RxInt to manage the current page index within the widget
final RxInt currentPageIndex = 0.obs;

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background
      body: SafeArea(
        // Use SafeArea to avoid status bar/notch
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Add padding around the content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch the button
            children: [
              // The Spacers in this outer column are fine because the Scaffold
              // body provides a bounded height.
              const Spacer(flex: 2), // Flexible space pushing content down
              // Use Obx to react to changes in the page index
              Obx(() {
                // Get the data for the current page
                final data = onboardingData[currentPageIndex.value];

                // This inner Column now uses SizedBox for spacing
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // Set mainAxisSize to min so it only takes up necessary vertical space
                  // This can sometimes help with layout issues inside flexible parents,
                  // though removing the inner Spacer was the primary fix here.
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      data['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20), // Spacing below title
                    // Description
                    Text(
                      data['description']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(
                          0.8,
                        ), // Slightly less opaque
                        fontSize: 16,
                      ),
                    ),

                    // --- FIX START ---
                    // Replaced Spacer with SizedBox to add space
                    const SizedBox(
                      height: 200,
                    ), // Add space between description and quote
                    // --- FIX END ---

                    // Quote
                    Text(
                      data['quote']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(
                          0.7,
                        ), // Even less opaque
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8), // Spacing below quote
                    // Author
                    Text(
                      data['author']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              }),

              // This Spacer is fine in the outer Column
              const Spacer(flex: 3), // Flexible space pushing button down
              // Next Button
              MyTextButton(
                buttonText: 'Next',
                onTap: () {
                  if (currentPageIndex.value < onboardingData.length - 1) {
                    // Not the last page, increment index to show next content
                    currentPageIndex.value++;
                  } else {
                    // This is the last page, navigate away using Get.toNamed
                    // Use the AppRoute constant you imported
                    Get.to(WelcomeScreen());
                    // If AppRoute.welcome is just a string like '/welcome', this is correct.
                    // If you prefer the widget directly as in your original code: Get.to(WelcomeScreen());
                    // But Get.toNamed is standard for routing tables.

                    // You might want to reset the index if the user could return (less common for onboarding)
                    // currentPageIndex.value = 0; // Optional: Reset index
                  }
                },
                isOutline: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
