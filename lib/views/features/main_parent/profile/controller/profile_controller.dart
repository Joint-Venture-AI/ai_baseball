import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class ProfileController extends GetxController {
  Rx<File?> pickedImage = Rx<File?>(null);
  final RxBool isUpdatingProfile = false.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  
  // Observable for selected date
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  
  DateTime dateTime = DateTime.now();
  
  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();
  
  @override
  void onInit() async {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    final user = authController.currentUser.value;
    if (user != null) {
      firstNameController.text = user.firstName ?? '';
      lastNameController.text = user.lastName ?? '';
      emailController.text = user.email;
      fullNameController.text = user.name.trim();
      
      // Load birth date if available
      if (user.birthDate != null) {
        selectedDate.value = user.birthDate;
      }
    }
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    
    // Show options to pick from camera or gallery
    final ImageSource? source = await Get.bottomSheet<ImageSource>(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Image Source',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.white),
              title: Text('Camera', style: TextStyle(color: Colors.white)),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.white),
              title: Text('Gallery', style: TextStyle(color: Colors.white)),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
            if (pickedImage.value != null)
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Remove Image', style: TextStyle(color: Colors.red)),
                onTap: () {
                  clearPickedImage();
                  Get.back();
                },
              ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );

    if (source != null) {
      try {
        final XFile? image = await picker.pickImage(
          source: source,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 85,
        );
        
        if (image != null) {
          pickedImage.value = File(image.path);
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to pick image: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  void clearPickedImage() {
    pickedImage.value = null;
  }

  Future<void> updateProfile() async {
    try {
      isUpdatingProfile.value = true;

      // Validate required fields
      if (fullNameController.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Name is required',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      final response = await ApiService.updateProfile(
        token: authController.accessToken.value,
        name: fullNameController.text.trim(),
        birthDate: selectedDate.value,
        imageFile: pickedImage.value,
      );

      if (response.success && response.data != null) {
        // Update the current user data
        authController.currentUser.value = response.data;
        
        // Clear picked image after successful upload
        pickedImage.value = null;
        
        // Show success message
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );

        // Go back to profile screen
        Get.back();
        
      } else {
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isUpdatingProfile.value = false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    nickNameController.dispose();
    dobController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
