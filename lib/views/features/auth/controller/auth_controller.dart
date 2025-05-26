import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:baseball_ai/core/models/user_model.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/core/utils/const/app_route.dart';

class AuthController extends GetxController {
  // Storage instance
  final GetStorage _storage = GetStorage();
  
  // Loading states
  final RxBool isSignupLoading = false.obs;
  final RxBool isLoginLoading = false.obs;
  final RxBool isForgotPasswordLoading = false.obs;
  final RxBool isVerifyEmailLoading = false.obs;
  final RxBool isResetPasswordLoading = false.obs;

  // User data
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxString accessToken = ''.obs;
  
  // Forgot password flow data
  final RxString forgotPasswordEmail = ''.obs;
  final RxString resetCode = ''.obs;

  // Text controllers for forms
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgotPasswordEmailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordEmailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize storage and load saved token
    _loadSavedToken();
  }

  // Token storage methods
  void _saveToken(String token) {
    _storage.write('access_token', token);
    accessToken.value = token;
  }

  void _loadSavedToken() {
    final savedToken = _storage.read('access_token');
    if (savedToken != null) {

      accessToken.value = savedToken;
      print('Access Token Loaded: $savedToken');
      // If we have a saved token, fetch the user profile
      getProfile();
    }
  }

  void clearToken() {
    _storage.remove('access_token');
    accessToken.value = '';
    currentUser.value = null;
  }

  // Check if user is logged in
  bool get isLoggedIn => accessToken.value.isNotEmpty;

  /// Signup method
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String levelOfSport,
    required String playerType,
    required String howOftenDoYouJournal,
    String? threeWordThtDescribeYou,
    DateTime? birthDate,
  }) async {
    try {
      isSignupLoading.value = true;

      final signupRequest = SignupRequest(
        name: name,
        email: email,
        password: password,
        levelOfSport: levelOfSport,
        playerType: playerType,
        howOftenDoYouJournal: howOftenDoYouJournal,
        threeWordThtDescribeYou: threeWordThtDescribeYou,
        birthDate: birthDate,
      );

      final response = await ApiService.signup(signupRequest);

      if (response.success && response.data != null) {
        currentUser.value = response.data;
        
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to the next screen (e.g., OTP verification or home)
        // You can customize this based on your app flow
        Get.offAllNamed(AppRoute.main);
        
      } else {
        // Show error message
        Get.snackbar(
          'Signup Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSignupLoading.value = false;
    }
  }

  /// Login method
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoginLoading.value = true;

      final response = await ApiService.login(
        email: email,
        password: password,
      );

      if (response.success && response.data != null) {
        currentUser.value = response.data!.user;
        
        // Store access token securely
        _saveToken(response.data!.accessToken);
        print('Access Token Saved: ${response.data!.accessToken}');
        
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to home screen
        Get.offAllNamed(AppRoute.main);
        
      } else {
        // Show error message
        Get.snackbar(
          'Login Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoginLoading.value = false;
    }
  }

  /// Forgot Password method
  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      isForgotPasswordLoading.value = true;
      forgotPasswordEmail.value = email;

      final response = await ApiService.forgotPassword(
        email: email,
      );

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to OTP verification screen
        Get.toNamed(AppRoute.otp);
        
      } else {
        // Show error message
        Get.snackbar(
          'Request Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isForgotPasswordLoading.value = false;
    }
  }

  /// Verify Email method
  Future<void> verifyEmail({
    required String email,
    required String oneTimeCode,
  }) async {
    try {
      isVerifyEmailLoading.value = true;

      final response = await ApiService.verifyEmail(
        email: email,
        oneTimeCode: oneTimeCode,
      );

      if (response.success && response.data?.resetCode != null) {
        resetCode.value = response.data!.resetCode!;
        
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to reset password screen
        Get.toNamed(AppRoute.passSet);
        
      } else {
        // Show error message
        Get.snackbar(
          'Verification Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isVerifyEmailLoading.value = false;
    }
  }

  /// Reset password method
  Future<void> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isResetPasswordLoading.value = true;

      final response = await ApiService.resetPassword(
        resetCode: resetCode.value,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response.success) {
        // Show success message
        Get.snackbar(
          'Success',
          response.message,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to login screen
        Get.offAllNamed(AppRoute.signIn);
        
      } else {
        // Show error message
        Get.snackbar(
          'Password Reset Failed',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isResetPasswordLoading.value = false;
    }
  }

  // Profile methods
  Future<void> getProfile() async {
    try {
      if (accessToken.value.isEmpty) {
        Get.snackbar(
          'Error',
          'No access token found. Please login again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      final response = await ApiService.getProfile(accessToken.value);

      if (response.success && response.data != null) {
        currentUser.value = response.data;
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
        'Failed to get profile: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// Silent profile fetching for auto-login - doesn't show error snackbars
  Future<bool> getProfileSilently() async {
    try {
      if (accessToken.value.isEmpty) {
        print('🔓 No access token found for silent profile fetch');
        return false;
      }

      print('📡 Fetching profile silently...');
      final response = await ApiService.getProfile(accessToken.value);

      if (response.success && response.data != null) {
        currentUser.value = response.data;
        print('✅ Profile fetched successfully: ${response.data!.name}');
        return true;
      } else {
        print('❌ Failed to fetch profile: ${response.message}');
        return false;
      }
    } catch (e) {
      print('💥 Error fetching profile silently: ${e.toString()}');
      return false;
    }
  }

  // Logout method
  void logout() {
    clearToken();
    Get.offAllNamed(AppRoute.auth);
  }

  /// Helper method to get mapped journal frequency for API
  String mapJournalFrequencyForApi(String frequency) {
    switch (frequency) {
      case 'Never':
        return 'Never tried it';
      case 'Dabbled':
        return 'Dabbled a little';
      case 'Consistent':
        return 'Pretty consistent';
      default:
        return frequency;
    }
  }

  /// Helper method to get mapped player type for API
  String mapPlayerTypeForApi(String playerType) {
    switch (playerType) {
      case 'pitcher':
        return 'Pitcher';
      case 'position_player':
        return 'Position Player';
      default:
        return playerType;
    }
  }
}
