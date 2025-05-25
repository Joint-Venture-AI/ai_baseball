import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:baseball_ai/core/utils/const/api_constants.dart';
import 'package:baseball_ai/core/models/user_model.dart';

class ApiService {
  static Future<ApiResponse<User>> signup(SignupRequest request) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.createUser}');
      
      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse<User>.fromJson(
          responseData,
          (data) => User.fromJson(data),
        );
      } else {
        return ApiResponse<User>(
          success: false,
          message: responseData['message'] ?? 'Signup failed',
          error: responseData['error'] ?? 'Unknown error occurred',
        );
      }
    } on SocketException {
      return ApiResponse<User>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<User>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Signup failed',
        error: e.toString(),
      );
    }
  }
  static Future<ApiResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginUser}');
      
      final requestBody = {
        'email': email,
        'password': password,
      };

      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<LoginResponse>.fromJson(
          responseData,
          (data) => LoginResponse.fromJson(data),
        );
      } else {
        return ApiResponse<LoginResponse>(
          success: false,
          message: responseData['message'] ?? 'Login failed',
          error: responseData['error'] ?? 'Invalid credentials',
        );
      }
    } on SocketException {
      return ApiResponse<LoginResponse>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<LoginResponse>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<LoginResponse>(
        success: false,
        message: 'Login failed',
        error: e.toString(),
      );
    }
  }
  static Future<ApiResponse<ForgotPasswordResponse>> forgotPassword({
    required String email,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.forgotPassword}');
      
      final requestBody = {
        'email': email,
      };

      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<ForgotPasswordResponse>.fromJson(
          responseData,
          (data) => ForgotPasswordResponse.fromJson(responseData),
        );
      } else {
        return ApiResponse<ForgotPasswordResponse>(
          success: false,
          message: responseData['message'] ?? 'Request failed',
          error: responseData['error'] ?? 'Unknown error occurred',
        );
      }
    } on SocketException {
      return ApiResponse<ForgotPasswordResponse>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<ForgotPasswordResponse>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<ForgotPasswordResponse>(
        success: false,
        message: 'Request failed',
        error: e.toString(),
      );
    }
  }

  static Future<ApiResponse<VerifyEmailResponse>> verifyEmail({
    required String email,
    required String oneTimeCode,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.verifyEmail}');
      
      final requestBody = {
        'email': email,
        'oneTimeCode': oneTimeCode,
      };

      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<VerifyEmailResponse>.fromJson(
          responseData,
          (data) => VerifyEmailResponse.fromJson(responseData),
        );
      } else {
        return ApiResponse<VerifyEmailResponse>(
          success: false,
          message: responseData['message'] ?? 'Verification failed',
          error: responseData['error'] ?? 'Invalid code',
        );
      }
    } on SocketException {
      return ApiResponse<VerifyEmailResponse>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<VerifyEmailResponse>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<VerifyEmailResponse>(
        success: false,
        message: 'Verification failed',
        error: e.toString(),
      );
    }
  }
  static Future<ApiResponse<ResetPasswordResponse>> resetPassword({
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.resetPassword}');
      
      final requestBody = {
        'resetCode': resetCode,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      };

      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: jsonEncode(requestBody),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<ResetPasswordResponse>.fromJson(
          responseData,
          (data) => ResetPasswordResponse.fromJson(responseData),
        );
      } else {
        return ApiResponse<ResetPasswordResponse>(
          success: false,
          message: responseData['message'] ?? 'Password reset failed',
          error: responseData['error'] ?? 'Unknown error occurred',
        );
      }
    } on SocketException {
      return ApiResponse<ResetPasswordResponse>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<ResetPasswordResponse>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<ResetPasswordResponse>(
        success: false,
        message: 'Password reset failed',
        error: e.toString(),
      );
    }
  }

  // Profile API methods
  static Future<ApiResponse<User>> getProfile(String token) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getProfile}');
      
      final response = await http.get(
        url,
        headers: ApiConstants.getAuthHeaders(token),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<User>.fromJson(
          responseData,
          (data) => User.fromJson(data),
        );
      } else {
        return ApiResponse<User>(
          success: false,
          message: responseData['message'] ?? 'Failed to get profile',
          error: responseData['error'] ?? 'Unknown error occurred',
        );
      }
    } on SocketException {
      return ApiResponse<User>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<User>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Failed to get profile',
        error: e.toString(),
      );
    }
  }

  static Future<ApiResponse<User>> updateProfile({
    required String token,
    String? firstName,
    String? lastName,
    File? imageFile,
  }) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.updateProfile}');
      
      var request = http.MultipartRequest('PATCH', url);
      request.headers.addAll(ApiConstants.getFormDataHeaders(token));
      
      // Prepare the data object
      Map<String, dynamic> dataObject = {};
      if (firstName != null) dataObject['firstName'] = firstName;
      if (lastName != null) dataObject['lastName'] = lastName;
      
      // Add the data field as JSON string
      if (dataObject.isNotEmpty) {
        request.fields['data'] = jsonEncode(dataObject);
      }
      
      // Add image file if provided
      if (imageFile != null) {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile(
          'image',
          stream,
          length,
          filename: imageFile.path.split('/').last,
        );
        request.files.add(multipartFile);
      }
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse<User>.fromJson(
          responseData,
          (data) => User.fromJson(data),
        );
      } else {
        return ApiResponse<User>(
          success: false,
          message: responseData['message'] ?? 'Failed to update profile',
          error: responseData['error'] ?? 'Unknown error occurred',
        );
      }
    } on SocketException {
      return ApiResponse<User>(
        success: false,
        message: 'No internet connection',
        error: 'Please check your internet connection and try again',
      );
    } on FormatException {
      return ApiResponse<User>(
        success: false,
        message: 'Invalid response format',
        error: 'Server returned invalid data',
      );
    } catch (e) {
      return ApiResponse<User>(
        success: false,
        message: 'Failed to update profile',
        error: e.toString(),
      );
    }
  }
}
