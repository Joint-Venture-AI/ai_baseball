// main_parent_controller.dart
import 'package:baseball_ai/core/utils/const/app_icons.dart';
// Ensure these paths are correct for your project structure
import 'package:baseball_ai/views/features/main_parent/bot/screens/bot_screen.dart';
import 'package:baseball_ai/views/features/main_parent/home/screens/home_screen.dart';
import 'package:baseball_ai/views/features/main_parent/nutrution/screens/nutrition_screen.dart';
import 'package:baseball_ai/views/features/main_parent/profile/screens/profile_screen.dart';
import 'package:baseball_ai/views/features/main_parent/progress/screens/progress_screen.dart';
import 'package:flutter/material.dart'; // Import material
import 'package:get/get.dart';

class MainParentController extends GetxController {
  // --- State ---
  var currentIndex = 0.obs; // Reactive index for the selected tab

  // --- Data ---

  final List<Widget> screens = [
    HomeScreen(),
    ProgressScreen(),
    NutritionScreen(),
    ProfileScreen(),
  ];

  // Icons for the bottom tabs
  final List<String> tabIcons = [
    AppIcons.home,
    AppIcons.progress,
    AppIcons.nutrition, // Use nutrition icon here
    AppIcons.person,
  ];

  // Labels for the bottom tabs
  final List<String> tabLabels = ["Home", "Progress", "Nutrition", "Profile"];

  void changeNav(int index) {
    // Prevent changing index if the same tab is tapped again (optional)
    if (currentIndex.value == index) return;
    currentIndex.value = index;
  }

  void fabAction() {
    print("FAB Tapped! Opening Bot Screen...");
    // Example: Navigate to the Bot Screen using GetX
    Get.to(() => ChatBotScreen());
  }

  Widget get currentScreen => screens[currentIndex.value];
}
