import 'package:baseball_ai/views/glob_widgets/my_button.dart';
import 'package:baseball_ai/views/features/main_parent/profile/controller/profile_controller.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';
import 'package:baseball_ai/core/utils/theme/app_styles.dart';
import 'package:baseball_ai/core/utils/image_utils.dart'; // Add this import
import 'package:baseball_ai/core/utils/const/app_images.dart'; // Add this import
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileController controller = Get.find<ProfileController>();
  final AuthController authController = Get.find<AuthController>();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize selectedDate from user's birth date
    final user = authController.currentUser.value;
    if (user?.birthDate != null) {
      selectedDate = user!.birthDate;
    }
    // Ensure user data is loaded into controllers
    controller.loadUserData();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: AppStyles.bodyMedium.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image Section
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    final pickedImage = controller.pickedImage.value;
                    final user = authController.currentUser.value;
                    
                    return Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppStyles.cardColor,
                        border: Border.all(color: AppStyles.primaryColor, width: 2),
                      ),
                      child: ClipOval(
                        child: pickedImage != null
                            ? Image.file(
                                pickedImage,
                                fit: BoxFit.cover,
                              )
                            : user?.image != null && user!.image!.isNotEmpty
                                ? Image.network(
                                    ImageUtils.getProfileImageUrl(user.image!),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.person,
                                        size: 50.w,
                                        color: AppStyles.primaryColor,
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: AppStyles.primaryColor,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                  loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 50.w,
                                    color: AppStyles.primaryColor,
                                  ),
                      ));
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppStyles.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 16.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            
            // First Name
            Text(
              'Full Name',
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              style: AppStyles.bodySmall,
              controller: controller.fullNameController,
              decoration: InputDecoration(
                hintText: 'Enter your full name...',
                hintStyle: TextStyle(color: AppStyles.hintTextColor),
                filled: true,
                fillColor: AppStyles.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppStyles.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppStyles.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Date of Birth
            Text(
              'Date of Birth',
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  color: AppStyles.cardColor,
                  border: Border.all(color: AppStyles.borderColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate == null
                          ? 'Date of Birth'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: AppStyles.bodySmall.copyWith(
                        color: selectedDate == null 
                            ? AppStyles.hintTextColor 
                            : AppStyles.textPrimaryColor,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today, 
                      color: AppStyles.primaryColor, 
                      size: 20.w
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Email (readonly)
            Text(
              'Email',
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            TextFormField(
              style: AppStyles.bodySmall,
              controller: controller.emailController,
              enabled: false, // Email should not be editable
              decoration: InputDecoration(
                hintText: 'Email address',
                hintStyle: TextStyle(color: AppStyles.hintTextColor),
                filled: true,
                fillColor: AppStyles.cardColor.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: AppStyles.borderColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: AppStyles.borderColor.withOpacity(0.5)
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            
            // Submit Button
            Obx(() => MyTextButton(
              buttonText: controller.isUpdatingProfile.value 
                  ? 'Updating...' 
                  : 'Update Profile',
              onTap: () {
                if (!controller.isUpdatingProfile.value) {
                  controller.updateProfile();
                }
              },
              isOutline: false,
            )),
          ],
        ),
      ),
    );
  }
}
