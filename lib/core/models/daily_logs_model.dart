class PostPerformance {
  final int gameRating;
  final String sessionType;
  final String gameResults;
  final String primaryTakeaway;

  PostPerformance({
    required this.gameRating,
    required this.sessionType,
    required this.gameResults,
    required this.primaryTakeaway,
  });

  Map<String, dynamic> toJson() {
    return {
      'gameRating': gameRating,
      'sessionType': sessionType,
      'gameResults': gameResults,
      'primaryTakeaway': primaryTakeaway,
    };
  }

  factory PostPerformance.fromJson(Map<String, dynamic> json) {
    return PostPerformance(
      gameRating: json['gameRating'] ?? 0,
      sessionType: json['sessionType'] ?? '',
      gameResults: json['gameResults'] ?? '',
      primaryTakeaway: json['primaryTakeaway'] ?? '',
    );
  }
}

class DailyLogsRequest {
  final String userId;
  final DateTime date;
  final PostPerformance postPerformance;

  DailyLogsRequest({
    required this.userId,
    required this.date,
    required this.postPerformance,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'date': date.toIso8601String(),
      'postPerformance': postPerformance.toJson(),
    };
  }

  factory DailyLogsRequest.fromJson(Map<String, dynamic> json) {
    return DailyLogsRequest(
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date']),
      postPerformance: PostPerformance.fromJson(json['postPerformance'] ?? {}),
    );
  }
}

class DailyLogsResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  DailyLogsResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory DailyLogsResponse.fromJson(Map<String, dynamic> json) {
    return DailyLogsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
