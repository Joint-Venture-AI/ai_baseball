class DailyWellnessRequest {
  final String userId;
  final DateTime date;
  final DailyWellnessQuestionnaire dailyWellnessQuestionnaire;

  DailyWellnessRequest({
    required this.userId,
    required this.date,
    required this.dailyWellnessQuestionnaire,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'dailyWellnessQuestionnaire': dailyWellnessQuestionnaire.toJson(),
    };
  }

  factory DailyWellnessRequest.fromJson(Map<String, dynamic> json) {
    return DailyWellnessRequest(
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date']),
      dailyWellnessQuestionnaire: DailyWellnessQuestionnaire.fromJson(
        json['dailyWellnessQuestionnaire'] ?? {},
      ),
    );
  }
}

class DailyWellnessQuestionnaire {
  final String feeling;
  final int soreness;
  final DateTime sleepTime;
  final DateTime wakeUpTime;
  final int hydrationLevel;
  final int readinessToCompete;

  DailyWellnessQuestionnaire({
    required this.feeling,
    required this.soreness,
    required this.sleepTime,
    required this.wakeUpTime,
    required this.hydrationLevel,
    required this.readinessToCompete,
  });

  Map<String, dynamic> toJson() {
    return {
      'feeling': feeling,
      'soreness': soreness,
      'sleepTime': sleepTime.toIso8601String(),
      'wakeUpTime': wakeUpTime.toIso8601String(),
      'hydrationLevel': hydrationLevel,
      'readinessToCompete': readinessToCompete,
    };
  }

  factory DailyWellnessQuestionnaire.fromJson(Map<String, dynamic> json) {
    return DailyWellnessQuestionnaire(
      feeling: json['feeling'] ?? '',
      soreness: json['soreness'] ?? 0,
      sleepTime: DateTime.parse(json['sleepTime']),
      wakeUpTime: DateTime.parse(json['wakeUpTime']),
      hydrationLevel: json['hydrationLevel'] ?? 0,
      readinessToCompete: json['readinessToCompete'] ?? 0,
    );
  }
}

class DailyWellnessResponse {
  final bool success;
  final String message;
  final DailyWellnessData? data;

  DailyWellnessResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory DailyWellnessResponse.fromJson(Map<String, dynamic> json) {
    return DailyWellnessResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null 
          ? DailyWellnessData.fromJson(json['data']) 
          : null,
    );
  }
}

class DailyWellnessData {
  final String id;
  final String userId;
  final DateTime date;
  final DailyWellnessQuestionnaire dailyWellnessQuestionnaire;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyWellnessData({
    required this.id,
    required this.userId,
    required this.date,
    required this.dailyWellnessQuestionnaire,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyWellnessData.fromJson(Map<String, dynamic> json) {
    return DailyWellnessData(
      id: json['_id'] ?? json['id'] ?? '',
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date']),
      dailyWellnessQuestionnaire: DailyWellnessQuestionnaire.fromJson(
        json['dailyWellnessQuestionnaire'] ?? {},
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}