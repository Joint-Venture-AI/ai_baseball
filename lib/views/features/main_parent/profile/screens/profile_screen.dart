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

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // ========>>>>>>> Image selector <<<<<<<<==========
              InkWell(
                onTap: () async {
                  await controller.pickImage();
                },
                child: Obx(() {
                  final pickedImage = controller.pickedImage.value;

                  return Stack(
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child:
                              pickedImage != null
                                  ? Image.file(pickedImage, fit: BoxFit.cover)
                                  : Image.asset(
                                    AppImages.avatarLogo,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppStyles.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              // ========>>>>>>> Name Email <<<<<<<<==========
              Text('John David', style: AppStyles.headingLarge),
              Text(
                'john@gmail.com',
                style: AppStyles.bodySmall.copyWith(
                  color: AppStyles.primaryColor,
                ),
              ),
              Divider(),
              SizedBox(height: 5.h),
              // ========>>>>>>> Profile Options <<<<<<<<==========
              _buildProfileOption(
                icon: Icon(Icons.person_3_outlined, color: Colors.white),
                title: "Edit Profile",
                ontap: () => Get.to(EditProfile()),
              ),

              _buildProfileOption(
                icon: SvgPicture.asset(AppIcons.passIcon, color: Colors.white),
                title: "Privacy Policy",
                ontap: () => Get.to(() => PrivacyPolicyScreen()),
              ),

              _buildProfileOption(
                icon: SvgPicture.asset(AppIcons.logout, color: Colors.red),
                title: "Logout",
                hasLast: false,
                ontap: () => ProfileComponents.showLogOutSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({icon, title, ontap, hasLast = true}) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: icon,
        title: Text(title, style: AppStyles.bodySmall),
        trailing:
            hasLast
                ? Icon(
                  Icons.chevron_right_outlined,
                  size: 30,
                  color: Colors.white,
                )
                : null,
      ),
    );
  }
}
