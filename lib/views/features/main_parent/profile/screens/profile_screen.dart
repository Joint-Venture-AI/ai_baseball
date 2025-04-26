import 'dart:io'; // Import for File type

import 'package:baseball_ai/core/utils/const/app_icons.dart';
import 'package:baseball_ai/core/utils/const/app_images.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/views/features/main_parent/profile/components/profile_components.dart';
import 'package:baseball_ai/views/features/main_parent/profile/controller/profile_controller.dart';
import 'package:baseball_ai/views/features/main_parent/profile/screens/edit_profile.dart';
import 'package:baseball_ai/views/features/main_parent/profile/screens/privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// A screen displaying the user's profile information and options.
class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  // Use Get.find if the controller is already initialized elsewhere (e.g., Binding)
  // Or use Get.put if this is the first place it's needed.
  // Assuming it's put here for simplicity based on original code.
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center content horizontally
            children: [
              // ======== Profile Picture Section ========
              _buildProfilePicture(),
              SizedBox(height: 10.h), // Add space after picture
              // ======== User Info Section (Name & Email) ========
              _buildUserInfo(),
              SizedBox(height: 20.h), // Add space after user info
              // ======== Divider ========
              const Divider(),
              SizedBox(height: 20.h), // Add space after divider
              // ======== Profile Options List ========
              Expanded(
                // Use Expanded to push options down or manage space
                child: ListView(
                  // Use ListView for scrollability if options grow
                  padding: EdgeInsets.zero, // Remove default ListView padding
                  children: [
                    _buildProfileOption(
                      icon: const Icon(
                        Icons.person_3_outlined,
                        color: Colors.white,
                      ),
                      title: "Edit Profile",
                      ontap: () => Get.to(() => EditProfile()),
                    ),
                    _buildProfileOption(
                      icon: SvgPicture.asset(
                        AppIcons.passIcon,
                        color: Colors.white,
                        width: 24.w,
                        height: 24.h,
                      ), // Explicit size for SVG
                      title: "Privacy Policy",
                      ontap: () => Get.to(() => PrivacyPolicyScreen()),
                    ),
                    _buildProfileOption(
                      icon: SvgPicture.asset(
                        AppIcons.logout,
                        color: Colors.red,
                        width: 24.w,
                        height: 24.h,
                      ), // Explicit size for SVG
                      title: "Logout",
                      hasLast: false, // No trailing icon for logout
                      ontap: () => ProfileComponents.showLogOutSheet(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the profile picture area with image selection functionality.
  Widget _buildProfilePicture() {
    return Obx(() {
      final pickedImage = controller.pickedImage.value;
      return InkWell(
        onTap: () async {
          await controller.pickImage();
        },
        borderRadius: BorderRadius.circular(
          100.r,
        ), // Apply border radius to InkWell for visual feedback
        child: Stack(
          alignment: Alignment.center, // Center the image within the stack
          children: [
            // Container to define the size and apply the circle crop
            Container(
              width: 100.w,
              height: 100.w, // Use width for height to ensure a square
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Ensure a circle shape
                border: Border.all(
                  color: AppStyles.primaryColor,
                  width: 2,
                ), // Optional border
                color:
                    AppStyles
                        .cardColor, // Background color while loading/default
              ),
              child: ClipOval(
                // Use ClipOval for a perfect circle crop
                child:
                    pickedImage != null
                        ? Image.file(
                          File(
                            pickedImage.path,
                          ), // Ensure pickedImage is treated as a File
                          fit: BoxFit.cover,
                        )
                        : Image.asset(
                          AppImages.avatarLogo, // Default avatar image
                          fit: BoxFit.cover,
                        ),
              ),
            ),
            // Positioned edit icon
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(5.w), // Consistent padding
                decoration: BoxDecoration(
                  color: AppStyles.primaryColor,
                  shape:
                      BoxShape.circle, // Make the edit icon background circular
                  border: Border.all(
                    color: AppStyles.backgroundColor,
                    width: 2,
                  ), // Small border to lift from image
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18.w,
                ), // Scaled icon size
              ),
            ),
          ],
        ),
      );
    });
  }

  /// Builds the user's name and email display section.
  Widget _buildUserInfo() {
    // Use Obx here if name/email were coming from controller and could change
    return Column(
      children: [
        // TODO: Replace with actual user name from controller/model
        Text('John David', style: AppStyles.headingLarge),
        SizedBox(height: 4.h),
        // TODO: Replace with actual user email from controller/model
        Text(
          'john@gmail.com',
          style: AppStyles.bodySmall.copyWith(color: AppStyles.primaryColor),
        ),
      ],
    );
  }

  /// Builds a single row for a profile option.
  Widget _buildProfileOption({
    required Widget icon,
    required String title,
    required VoidCallback ontap,
    bool hasLast = true, // Whether to show the trailing arrow
  }) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: SizedBox(
          width: 24.w,
          height: 24.h,
          child: Center(child: icon),
        ), // Ensure leading icon has space and is centered
        title: Text(title, style: AppStyles.bodySmall),
        trailing:
            hasLast
                ? Icon(
                  Icons.chevron_right_outlined,
                  size: 30.w, // Scaled icon size
                  color: Colors.white,
                )
                : null, // No trailing icon if hasLast is false
        contentPadding: EdgeInsets.zero, // Remove default ListTile padding
        dense: true, // Make the list tile a bit more compact
      ),
    );
  }
}
