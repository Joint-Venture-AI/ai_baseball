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
  
  DateTime dateTime = DateTime.now();
  
  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();
    @override
  void onInit() async {
    super.onInit();
    loadUserData();
  }
  void loadUserData() {
    final user = authController.currentUser.value;
    if (user != null) {
      emailController.text = user.email;
      fullNameController.text = user.name ?? '';
    }
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> updateProfile() async {
    try {
      isUpdatingProfile.value = true;

      final response = await ApiService.updateProfile(
        token: authController.accessToken.value,
        name: fullNameController.text,
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
    super.onClose();
  }
}
