class PlayerPerformanceStats {
  final int gameRating;
  final String sessionType;
  final String gameResults;
  final String primaryTakeaway;

  PlayerPerformanceStats({
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

  factory PlayerPerformanceStats.fromJson(Map<String, dynamic> json) {
    return PlayerPerformanceStats(
      gameRating: json['gameRating'] ?? 0,
      sessionType: json['sessionType'] ?? '',
      gameResults: json['gameResults'] ?? '',
      primaryTakeaway: json['primaryTakeaway'] ?? '',
    );
  }
}

class DailyLogSubmission {
  final String userId;
  final DateTime date;
  final PlayerPerformanceStats postPerformance;

  DailyLogSubmission({
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

  factory DailyLogSubmission.fromJson(Map<String, dynamic> json) {
    return DailyLogSubmission(
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date']),
      postPerformance: PlayerPerformanceStats.fromJson(json['postPerformance'] ?? {}),
    );
  }
}

class DailyLogEntriesResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  DailyLogEntriesResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory DailyLogEntriesResponse.fromJson(Map<String, dynamic> json) {
    return DailyLogEntriesResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}

// New comprehensive model for daily logs retrieval API response
class VisualRepresentation {
  final bool gameEnvironment;
  final int gameEnvironmentTime;
  final bool gameExecution;
  final int gameExecutionTime;
  final bool pregameRoutine;
  final int pregameRoutineTime;
  final bool boxBreathing;
  final int boxBreathingTime;

  VisualRepresentation({
    required this.gameEnvironment,
    required this.gameEnvironmentTime,
    required this.gameExecution,
    required this.gameExecutionTime,
    required this.pregameRoutine,
    required this.pregameRoutineTime,
    required this.boxBreathing,
    required this.boxBreathingTime,
  });

  factory VisualRepresentation.fromJson(Map<String, dynamic> json) {
    return VisualRepresentation(
      gameEnvironment: json['gameEnvironment'] ?? false,
      gameEnvironmentTime: json['gameEnvironmentTime'] ?? 0,
      gameExecution: json['gameExecution'] ?? false,
      gameExecutionTime: json['gameExecutionTime'] ?? 0,
      pregameRoutine: json['pregameRoutine'] ?? false,
      pregameRoutineTime: json['pregameRoutineTime'] ?? 0,
      boxBreathing: json['boxBreathing'] ?? false,
      boxBreathingTime: json['boxBreathingTime'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameEnvironment': gameEnvironment,
      'gameEnvironmentTime': gameEnvironmentTime,
      'gameExecution': gameExecution,
      'gameExecutionTime': gameExecutionTime,
      'pregameRoutine': pregameRoutine,
      'pregameRoutineTime': pregameRoutineTime,
      'boxBreathing': boxBreathing,
      'boxBreathingTime': boxBreathingTime,
    };
  }
}

class WellnessAssessmentModel {
  final String feeling;
  final int soreness;
  final DateTime sleepTime;
  final DateTime wakeUpTime;
  final int hydrationLevel;
  final int readinessToCompete;

  WellnessAssessmentModel({
    required this.feeling,
    required this.soreness,
    required this.sleepTime,
    required this.wakeUpTime,
    required this.hydrationLevel,
    required this.readinessToCompete,
  });

  factory WellnessAssessmentModel.fromJson(Map<String, dynamic> json) {
    return WellnessAssessmentModel(
      feeling: json['feeling'] ?? '',
      soreness: json['soreness'] ?? 0,
      sleepTime: DateTime.parse(json['sleepTime'] ?? DateTime.now().toIso8601String()),
      wakeUpTime: DateTime.parse(json['wakeUpTime'] ?? DateTime.now().toIso8601String()),
      hydrationLevel: json['hydrationLevel'] ?? 0,
      readinessToCompete: json['readinessToCompete'] ?? 0,
    );
  }

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
}

class ThrowingActivityRecord {
  final List<String> drills;
  final String toolsDescription;
  final String setsAndReps;
  final int longTossDistance;
  final int pitchCount;
  final String focus;
  final String environment;

  ThrowingActivityRecord({
    required this.drills,
    required this.toolsDescription,
    required this.setsAndReps,
    required this.longTossDistance,
    required this.pitchCount,
    required this.focus,
    required this.environment,
  });

  factory ThrowingActivityRecord.fromJson(Map<String, dynamic> json) {
    return ThrowingActivityRecord(
      drills: List<String>.from(json['drills'] ?? []),
      toolsDescription: json['toolsDescription'] ?? '',
      setsAndReps: json['setsAndReps'] ?? '',
      longTossDistance: json['longTossDistance'] ?? 0,
      pitchCount: json['pitchCount'] ?? 0,
      focus: json['focus'] ?? '',
      environment: json['environment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drills': drills,
      'toolsDescription': toolsDescription,
      'setsAndReps': setsAndReps,
      'longTossDistance': longTossDistance,
      'pitchCount': pitchCount,
      'focus': focus,
      'environment': environment,
    };
  }
}

class NutritionalInfo {
  final double nutritionScore;
  final int proteinInGram;
  final double caloricScore;
  final bool consumedImpedingSubstances;

  NutritionalInfo({
    required this.nutritionScore,
    required this.proteinInGram,
    required this.caloricScore,
    required this.consumedImpedingSubstances,
  });

  factory NutritionalInfo.fromJson(Map<String, dynamic> json) {
    return NutritionalInfo(
      nutritionScore: (json['nutritionScore'] ?? 0).toDouble(),
      proteinInGram: json['proteinInGram'] ?? 0,
      caloricScore: (json['caloricScore'] ?? 0).toDouble(),
      consumedImpedingSubstances: json['consumedImpedingSubstances'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nutritionScore': nutritionScore,
      'proteinInGram': proteinInGram,
      'caloricScore': caloricScore,
      'consumedImpedingSubstances': consumedImpedingSubstances,
    };
  }
}

class ArmRecoveryMetrics {
  final List<String> focus;
  final String exerciseType;
  final List<String> recoveryModalities;
  final String exercisesLog;

  ArmRecoveryMetrics({
    required this.focus,
    required this.exerciseType,
    required this.recoveryModalities,
    required this.exercisesLog,
  });

  factory ArmRecoveryMetrics.fromJson(Map<String, dynamic> json) {
    return ArmRecoveryMetrics(
      focus: List<String>.from(json['focus'] ?? []),
      exerciseType: json['exerciseType'] ?? '',
      recoveryModalities: List<String>.from(json['recoveryModalities'] ?? []),
      exercisesLog: json['exercisesLog'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'focus': focus,
      'exerciseType': exerciseType,
      'recoveryModalities': recoveryModalities,
      'exercisesLog': exercisesLog,
    };
  }
}

class WeightliftingMetrics {
  final List<String> liftingType;
  final List<String> focus;
  final String? exercisesLog;

  WeightliftingMetrics({
    required this.liftingType,
    required this.focus,
    this.exercisesLog,
  });

  factory WeightliftingMetrics.fromJson(Map<String, dynamic> json) {
    return WeightliftingMetrics(
      liftingType: List<String>.from(json['liftingType'] ?? []),
      focus: List<String>.from(json['focus'] ?? []),
      exercisesLog: json['exercisesLog'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'liftingType': liftingType,
      'focus': focus,
      'exercisesLog': exercisesLog,
    };
  }
}

class HittingActivityLog {
  final int pregameEngagement;
  final String primaryFocus;
  final int atBats;
  final String atBatResults;
  final String positiveOutcome;
  final String? exercisesLog;

  HittingActivityLog({
    required this.pregameEngagement,
    required this.primaryFocus,
    required this.atBats,
    required this.atBatResults,
    required this.positiveOutcome,
    this.exercisesLog,
  });

  factory HittingActivityLog.fromJson(Map<String, dynamic> json) {
    return HittingActivityLog(
      pregameEngagement: json['pregameEngagement'] ?? 0,
      primaryFocus: json['primaryFocus'] ?? '',
      atBats: json['atBats'] ?? 0,
      atBatResults: json['atBatResults'] ?? '',
      positiveOutcome: json['positiveOutcome'] ?? '',
      exercisesLog: json['exercisesLog'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pregameEngagement': pregameEngagement,
      'primaryFocus': primaryFocus,
      'atBats': atBats,
      'atBatResults': atBatResults,
      'positiveOutcome': positiveOutcome,
      'exercisesLog': exercisesLog,
    };
  }
}

class DailyActivityLog {
  final VisualRepresentation? visualization;
  final WellnessAssessmentModel? dailyWellnessQuestionnaire;
  final ThrowingActivityRecord? throwingJournal;
  final NutritionalInfo? nutrition;
  final ArmRecoveryMetrics? armCare;
  final WeightliftingMetrics? lifting;
  final HittingActivityLog? hittingJournal;
  final PlayerPerformanceStats? postPerformance;
  final String id;
  final String userId;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyActivityLog({
    this.visualization,
    this.dailyWellnessQuestionnaire,
    this.throwingJournal,
    this.nutrition,
    this.armCare,
    this.lifting,
    this.hittingJournal,
    this.postPerformance,
    required this.id,
    required this.userId,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyActivityLog.fromJson(Map<String, dynamic> json) {
    return DailyActivityLog(
      visualization: json['visualization'] != null
          ? VisualRepresentation.fromJson(json['visualization'])
          : null,
      dailyWellnessQuestionnaire: json['dailyWellnessQuestionnaire'] != null
          ? WellnessAssessmentModel.fromJson(json['dailyWellnessQuestionnaire'])
          : null,
      throwingJournal: json['throwingJournal'] != null
          ? ThrowingActivityRecord.fromJson(json['throwingJournal'])
          : null,
      nutrition: json['nutrition'] != null
          ? NutritionalInfo.fromJson(json['nutrition'])
          : null,
      armCare: json['armCare'] != null
          ? ArmRecoveryMetrics.fromJson(json['armCare'])
          : null,
      lifting: json['Lifting'] != null // Note: API uses "Lifting" with capital L
          ? WeightliftingMetrics.fromJson(json['Lifting'])
          : null,
      hittingJournal: json['hittingJournal'] != null
          ? HittingActivityLog.fromJson(json['hittingJournal'])
          : null,
      postPerformance: json['postPerformance'] != null
          ? PlayerPerformanceStats.fromJson(json['postPerformance'])
          : null,
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visualization': visualization?.toJson(),
      'dailyWellnessQuestionnaire': dailyWellnessQuestionnaire?.toJson(),
      'throwingJournal': throwingJournal?.toJson(),
      'nutrition': nutrition?.toJson(),
      'armCare': armCare?.toJson(),
      'Lifting': lifting?.toJson(), // Note: API uses "Lifting" with capital L
      'hittingJournal': hittingJournal?.toJson(),
      'postPerformance': postPerformance?.toJson(),
      '_id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class DailyLogRetrievalResponse {
  final bool success;
  final String message;
  final DailyActivityLog? data;

  DailyLogRetrievalResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory DailyLogRetrievalResponse.fromJson(Map<String, dynamic> json) {
    return DailyLogRetrievalResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? DailyActivityLog.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}