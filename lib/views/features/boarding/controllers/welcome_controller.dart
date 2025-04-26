import 'package:baseball_ai/core/utils/const/app_route.dart'; // Ensure this path is correct
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  // Use an index to track the current screen content
  var contentIndex = 0.obs;

  // Content for the multi-step screens
  final List<Map<String, String>> onboardingContent = [
    {
      'title': 'Define your foundation',
      'subtitle':
          'Every aspiring athlete a journey starts with knowing who they are- define your strengths, identify your gaps, and build your game with intention.',
      'quote':
          '"When the lights go off and the crowd is gone, your identity needs to be stronger than the jersey you wear."',
      'author': '-Jaby Johnson',
    },
    {
      'title': 'Discover your athletic identity',
      'subtitle':
          'Understand what drives you-your core values are your compass when is on and everybody’s watching.',
      'quote':
          '"l never let winning define me. I define myself by how I carry my character and values, whether I win or lose."',
      'author': '-Simone Biles',
    },
    {
      'title': 'Peak performance starts here',
      'subtitle':
          'It\'s time to lock it in, define your direction, and take the first step towards finding your daily blueprint',
      'quote': '"...Results come when you commit to the work nobody sees."',
      'author': '-Alex Rodriguez',
    },
  ];

  // Method to handle "Next" button taps
  void changeContent() {
    // Check if the current index is the last index
    if (contentIndex.value < onboardingContent.length - 1) {
      // Not on the last screen yet, just increment the index
      contentIndex.value++;
      print("Moving to welcome screen index: ${contentIndex.value}");
    } else {
      // On the last screen, navigate away from onboarding
      print("Onboarding finished. Navigating to Sign Up or Main App...");
      // TODO: Navigate to the actual Sign Up screen or main app flow
      // Example: Get.offAllNamed(AppRoute.signUp); // Or whatever your signup route is
      // For now, let's navigate back, you need to replace this with your actual flow
      Get.back(); // Replace this with your intended navigation
    }
  }

  // Method to navigate back (e.g., if you add a back button)
  void goBack() {
    if (contentIndex.value > 0) {
      contentIndex.value--;
      print("Going back to welcome screen index: ${contentIndex.value}");
    } else {
      // If on the first welcome screen, maybe navigate back to AuthScreen
      Get.back(); // Or Get.offNamed(AppRoute.auth);
    }
  }
}
