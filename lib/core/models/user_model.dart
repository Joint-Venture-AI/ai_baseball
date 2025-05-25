class User {
  final String id;
  final String name;
  final String? firstName; // For login response
  final String? lastName;  // For login response
  final String email;
  final String? password;
  final String levelOfSport;
  final String playerType;
  final String howOftenDoYouJournal;
  final String threeWordThtDescribeYou;
  final String role;
  final DateTime? birthDate;
  final String? image;
  final String? fcmToken;
  final String status;
  final bool verified;
  final AuthenticationData authentication;
  final DateTime? passwordChangedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    required this.id,
    required this.name,
    this.firstName,
    this.lastName,
    required this.email,
    this.password,
    required this.levelOfSport,
    required this.playerType,
    required this.howOftenDoYouJournal,
    required this.threeWordThtDescribeYou,
    required this.role,
    this.birthDate,
    this.image,
    this.fcmToken,
    required this.status,
    required this.verified,
    required this.authentication,
    this.passwordChangedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      firstName: json['firstName'], // For login response
      lastName: json['lastName'],   // For login response  
      email: json['email'] ?? '',
      password: json['password'],
      levelOfSport: json['levelOfSport'] ?? '',
      playerType: json['playerType'] ?? '',
      howOftenDoYouJournal: json['HowOftenDoYouJournal'] ?? '',
      threeWordThtDescribeYou: json['ThreeWordThtDescribeYou'] ?? '',
      role: json['role'] ?? 'USER',
      birthDate: json['birthDate'] != null 
          ? DateTime.parse(json['birthDate']) 
          : null,
      image: json['image'],
      fcmToken: json['fcmToken'],
      status: json['status'] ?? 'active',
      verified: json['verified'] ?? false,
      authentication: AuthenticationData.fromJson(
        json['authentication'] ?? {},
      ),
      passwordChangedAt: json['passwordChangedAt'] != null
          ? DateTime.parse(json['passwordChangedAt'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'levelOfSport': levelOfSport,
      'playerType': playerType,
      'HowOftenDoYouJournal': howOftenDoYouJournal,
      'ThreeWordThtDescribeYou': threeWordThtDescribeYou,
      'role': role,
      'birthDate': birthDate?.toIso8601String(),
      'image': image,
      'fcmToken': fcmToken,
      'status': status,
      'verified': verified,
      'authentication': authentication.toJson(),
      'passwordChangedAt': passwordChangedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class AuthenticationData {
  final bool isResetPassword;
  final String? oneTimeCode;
  final DateTime? expireAt;

  AuthenticationData({
    required this.isResetPassword,
    this.oneTimeCode,
    this.expireAt,
  });

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      isResetPassword: json['isResetPassword'] ?? false,
      oneTimeCode: json['oneTimeCode'],
      expireAt: json['expireAt'] != null 
          ? DateTime.parse(json['expireAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isResetPassword': isResetPassword,
      'oneTimeCode': oneTimeCode,
      'expireAt': expireAt?.toIso8601String(),
    };
  }
}

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : json['data'],
      error: json['error'],
    );
  }
}

class SignupRequest {
  final String name;
  final String email;
  final String password;
  final String levelOfSport;
  final String playerType;
  final String howOftenDoYouJournal;
  final String? threeWordThtDescribeYou;
  final DateTime? birthDate;

  SignupRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.levelOfSport,
    required this.playerType,
    required this.howOftenDoYouJournal,
    this.threeWordThtDescribeYou,
    this.birthDate,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'levelOfSport': levelOfSport,
      'playerType': playerType,
      'HowOftenDoYouJournal': howOftenDoYouJournal,
      'ThreeWordThtDescribeYou': threeWordThtDescribeYou?.isNotEmpty == true 
          ? threeWordThtDescribeYou 
          : "I am a Null",
      if (birthDate != null) 'birthDate': birthDate!.toIso8601String(),
    };
  }
}

class LoginResponse {
  final String accessToken;
  final User user;

  LoginResponse({
    required this.accessToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'user': user.toJson(),
    };
  }
}

class ForgotPasswordResponse {
  final bool success;
  final String message;

  ForgotPasswordResponse({
    required this.success,
    required this.message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}

class VerifyEmailResponse {
  final bool success;
  final String message;
  final String? resetCode;

  VerifyEmailResponse({
    required this.success,
    required this.message,
    this.resetCode,
  });

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      resetCode: json['data'],
    );
  }
}

class ResetPasswordResponse {
  final bool success;
  final String message;

  ResetPasswordResponse({
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
