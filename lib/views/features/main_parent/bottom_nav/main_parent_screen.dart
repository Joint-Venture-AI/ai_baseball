// main_parent_screen.dart
import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart'; // Assuming styles are defined here
import 'package:baseball_ai/views/features/main_parent/bottom_nav/controllers/main_parent_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // If you use it for sizing
import 'package:get/get.dart';

class MainParentScreen extends StatelessWidget {
  MainParentScreen({super.key});

  // Instantiate the controller
  final mainParentController = Get.put(MainParentController());

  @override
  Widget build(BuildContext context) {
    // Define colors (adjust as needed to match the image)
    const Color activeColor = Color(0xFFFFEB3B); // Yellowish
    const Color inactiveColor = Colors.white70; // Greyish white
    const Color fabColor = Color(0xFFFFEB3B); // Yellowish
    const Color barBackgroundColor = Color(0xFF212121); // Dark grey/black
    const Color scaffoldBackgroundColor = Color(
      0xFF121212,
    ); // Very dark background

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor, // Set overall background
      // Use Obx to rebuild the body when currentIndex changes
      body: Obx(() => mainParentController.currentScreen),

      // Floating Action Button configuration
      floatingActionButton: FloatingActionButton(
        onPressed: mainParentController.fabAction,
        backgroundColor: fabColor,
        elevation: 4.0, // Add some shadow
        shape: const CircleBorder(), // Make it perfectly circular
        child: SvgPicture.asset(
          AppIcons.bot, // Your bot icon path
          width: 28.w, // Adjust size as needed using ScreenUtil or fixed values
          height: 28.h,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ), // Color of the icon itself
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar configuration
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Creates the notch
        notchMargin: 8.0, // Space around the FAB
        color: barBackgroundColor,
        elevation: 8.0, // Add shadow to the bar
        child: Obx(
          // Use Obx here to rebuild the bar when index changes
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Left side tab items
              _buildTabItem(
                iconPath: mainParentController.tabIcons[0],
                label: mainParentController.tabLabels[0],
                index: 0,
                isActive: mainParentController.currentIndex.value == 0,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => mainParentController.changeNav(0),
              ),
              _buildTabItem(
                iconPath: mainParentController.tabIcons[1],
                label: mainParentController.tabLabels[1],
                index: 1,
                isActive: mainParentController.currentIndex.value == 1,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => mainParentController.changeNav(1),
              ),
              // Spacer for the notch area
              SizedBox(width: 40.w), // Adjust width to provide space for FAB
              // Right side tab items
              _buildTabItem(
                iconPath: mainParentController.tabIcons[2],
                label: mainParentController.tabLabels[2],
                index: 2, // Corresponds to Nutrition
                isActive: mainParentController.currentIndex.value == 2,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => mainParentController.changeNav(2),
              ),
              _buildTabItem(
                iconPath: mainParentController.tabIcons[3],
                label: mainParentController.tabLabels[3],
                index: 3, // Corresponds to Profile
                isActive: mainParentController.currentIndex.value == 3,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                onTap: () => mainParentController.changeNav(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required String iconPath,
    required String label,
    required int index,
    required bool isActive,
    required Color activeColor,
    required Color inactiveColor,
    required VoidCallback onTap,
  }) {
    final Color color = isActive ? activeColor : inactiveColor;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        // Optional: Make the tap area fill the space better
        // splashColor: activeColor.withOpacity(0.1),
        // highlightColor: activeColor.withOpacity(0.05),
        child: Padding(
          // *** Reduce Vertical Padding EVEN MORE or remove if necessary ***
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
            horizontal: 2.w,
          ), // Minimum padding
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Crucial: Column takes minimum space
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            children: <Widget>[
              SvgPicture.asset(
                iconPath,
                width: 22.w, // *** Reduce icon size ***
                height: 22.h, // *** Reduce icon size ***
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              // *** Reduce or Remove Space Below Icon ***
              // You might not even need a SizedBox if padding/margins handle it
              // SizedBox(height: 1.h), // Let's try removing it for now

              // *** Wrap Text to prevent it pushing height if label is long ***
              // Not strictly needed for overflow *yet*, but good practice
              FittedBox(
                // Optional: scales text down if it's too wide
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    // *** Reduce Font Size ***
                    fontSize: 9.sp, // Reduced from 10.sp
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    // Maybe remove extra height from TextStyle if needed
                    // height: 1.0, // Force line height closer to font size
                  ),
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis, // Use ellipsis if text scales down too much
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
