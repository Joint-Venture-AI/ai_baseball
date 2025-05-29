import 'dart:convert';

// Helper function to decode JSON
T? _decode<T>(dynamic value, T Function(Map<String, dynamic>) decode) {
  if (value == null) return null;
  return decode(value as Map<String, dynamic>);
}

// Helper function for list decoding (can be more specific if needed)
List<T>? _decodeList<T>(dynamic value, T Function(dynamic) decodeItem) {
  if (value == null) return null;
  return (value as List).map((item) => decodeItem(item)).toList();
}

class DailyLogApiResponse {
  final bool success;
  final String message;
  final DataModel data;

  DailyLogApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DailyLogApiResponse.fromJson(Map<String, dynamic> json) {
    return DailyLogApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: DataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class DataModel {
  final Visualization visualization;
  final DailyWellnessQuestionnaire dailyWellnessQuestionnaire;
  final ThrowingJournal throwingJournal;
  final Nutrition nutrition;
  final ArmCare armCare;
  final LiftingData lifting; // Renamed for Dart conventions
  final HittingJournal hittingJournal;
  final PostPerformance postPerformance;
  final String id;
  final String userId;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  DataModel({
    required this.visualization,
    required this.dailyWellnessQuestionnaire,
    required this.throwingJournal,
    required this.nutrition,
    required this.armCare,
    required this.lifting,
    required this.hittingJournal,
    required this.postPerformance,
    required this.id,
    required this.userId,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      visualization: Visualization.fromJson(json['visualization'] as Map<String, dynamic>),
      dailyWellnessQuestionnaire: DailyWellnessQuestionnaire.fromJson(json['dailyWellnessQuestionnaire'] as Map<String, dynamic>),
      throwingJournal: ThrowingJournal.fromJson(json['throwingJournal'] as Map<String, dynamic>),
      nutrition: Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>),
      armCare: ArmCare.fromJson(json['armCare'] as Map<String, dynamic>),
      lifting: LiftingData.fromJson(json['Lifting'] as Map<String, dynamic>), // Key is "Lifting"
      hittingJournal: HittingJournal.fromJson(json['hittingJournal'] as Map<String, dynamic>),
      postPerformance: PostPerformance.fromJson(json['postPerformance'] as Map<String, dynamic>),
      id: json['_id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visualization': visualization.toJson(),
      'dailyWellnessQuestionnaire': dailyWellnessQuestionnaire.toJson(),
      'throwingJournal': throwingJournal.toJson(),
      'nutrition': nutrition.toJson(),
      'armCare': armCare.toJson(),
      'Lifting': lifting.toJson(), // Key is "Lifting"
      'hittingJournal': hittingJournal.toJson(),
      'postPerformance': postPerformance.toJson(),
      '_id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Visualization {
  final bool gameEnvironment;
  final int gameEnvironmentTime;
  final bool gameExecution;
  final int gameExecutionTime;
  final bool pregameRoutine;
  final int pregameRoutineTime;
  final bool boxBreathing;
  final int boxBreathingTime;

  Visualization({
    required this.gameEnvironment,
    required this.gameEnvironmentTime,
    required this.gameExecution,
    required this.gameExecutionTime,
    required this.pregameRoutine,
    required this.pregameRoutineTime,
    required this.boxBreathing,
    required this.boxBreathingTime,
  });

  factory Visualization.fromJson(Map<String, dynamic> json) {
    return Visualization(
      gameEnvironment: json['gameEnvironment'] as bool,
      gameEnvironmentTime: json['gameEnvironmentTime'] as int,
      gameExecution: json['gameExecution'] as bool,
      gameExecutionTime: json['gameExecutionTime'] as int,
      pregameRoutine: json['pregameRoutine'] as bool,
      pregameRoutineTime: json['pregameRoutineTime'] as int,
      boxBreathing: json['boxBreathing'] as bool,
      boxBreathingTime: json['boxBreathingTime'] as int,
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

  factory DailyWellnessQuestionnaire.fromJson(Map<String, dynamic> json) {
    return DailyWellnessQuestionnaire(
      feeling: json['feeling'] as String,
      soreness: json['soreness'] as int,
      sleepTime: DateTime.parse(json['sleepTime'] as String),
      wakeUpTime: DateTime.parse(json['wakeUpTime'] as String),
      hydrationLevel: json['hydrationLevel'] as int,
      readinessToCompete: json['readinessToCompete'] as int,
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

class ThrowingJournal {
  final List<String> drills;
  final String toolsDescription;
  final String setsAndReps;
  final int longTossDistance;
  final int pitchCount;
  final String focus;
  final String environment;

  ThrowingJournal({
    required this.drills,
    required this.toolsDescription,
    required this.setsAndReps,
    required this.longTossDistance,
    required this.pitchCount,
    required this.focus,
    required this.environment,
  });

  factory ThrowingJournal.fromJson(Map<String, dynamic> json) {
    return ThrowingJournal(
      drills: List<String>.from(json['drills'] as List),
      toolsDescription: json['toolsDescription'] as String,
      setsAndReps: json['setsAndReps'] as String,
      longTossDistance: json['longTossDistance'] as int,
      pitchCount: json['pitchCount'] as int,
      focus: json['focus'] as String,
      environment: json['environment'] as String,
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

class Nutrition {
  final double nutritionScore;
  final int proteinInGram; // Assuming int based on value 20
  final double caloricScore;
  final bool consumedImpedingSubstances;

  Nutrition({
    required this.nutritionScore,
    required this.proteinInGram,
    required this.caloricScore,
    required this.consumedImpedingSubstances,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      nutritionScore: (json['nutritionScore'] as num).toDouble(),
      proteinInGram: json['proteinInGram'] as int,
      caloricScore: (json['caloricScore'] as num).toDouble(),
      consumedImpedingSubstances: json['consumedImpedingSubstances'] as bool,
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

class ArmCare {
  final List<String> focus;
  final String exerciseType;
  final List<String> recoveryModalities;
  final String exercisesLog;

  ArmCare({
    required this.focus,
    required this.exerciseType,
    required this.recoveryModalities,
    required this.exercisesLog,
  });

  factory ArmCare.fromJson(Map<String, dynamic> json) {
    return ArmCare(
      focus: List<String>.from(json['focus'] as List),
      exerciseType: json['exerciseType'] as String,
      recoveryModalities: List<String>.from(json['recoveryModalities'] as List),
      exercisesLog: json['exercisesLog'] as String,
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

class LiftingData { // Renamed from "Lifting"
  final List<String> liftingType;
  final List<String> focus;
  final String? exercisesLog; // Nullable

  LiftingData({
    required this.liftingType,
    required this.focus,
    this.exercisesLog, // Nullable
  });

  factory LiftingData.fromJson(Map<String, dynamic> json) {
    return LiftingData(
      liftingType: List<String>.from(json['liftingType'] as List),
      focus: List<String>.from(json['focus'] as List),
      exercisesLog: json['exercisesLog'] as String?, // Nullable
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

class HittingJournal {
  final int pregameEngagement;
  final String primaryFocus;
  final int atBats;
  final String atBatResults;
  final String positiveOutcome;
  final String? exercisesLog; // Nullable

  HittingJournal({
    required this.pregameEngagement,
    required this.primaryFocus,
    required this.atBats,
    required this.atBatResults,
    required this.positiveOutcome,
    this.exercisesLog, // Nullable
  });

  factory HittingJournal.fromJson(Map<String, dynamic> json) {
    return HittingJournal(
      pregameEngagement: json['pregameEngagement'] as int,
      primaryFocus: json['primaryFocus'] as String,
      atBats: json['atBats'] as int,
      atBatResults: json['atBatResults'] as String,
      positiveOutcome: json['positiveOutcome'] as String,
      exercisesLog: json['exercisesLog'] as String?, // Nullable
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

  factory PostPerformance.fromJson(Map<String, dynamic> json) {
    return PostPerformance(
      gameRating: json['gameRating'] as int,
      sessionType: json['sessionType'] as String,
      gameResults: json['gameResults'] as String,
      primaryTakeaway: json['primaryTakeaway'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameRating': gameRating,
      'sessionType': sessionType,
      'gameResults': gameResults,
      'primaryTakeaway': primaryTakeaway,
    };
  }
}

// Example Usage:
void main() {
  const String jsonString = '''
  {
      "success": true,
      "message": "Daily log retrieved successfully",
      "data": {
          "visualization": {
              "gameEnvironment": false,
              "gameEnvironmentTime": 0,
              "gameExecution": false,
              "gameExecutionTime": 0,
              "pregameRoutine": false,
              "pregameRoutineTime": 0,
              "boxBreathing": true,
              "boxBreathingTime": 0
          },
          "dailyWellnessQuestionnaire": {
              "feeling": "rtyrty",
              "soreness": 4,
              "sleepTime": "2025-05-29T09:41:00.000Z",
              "wakeUpTime": "2025-05-29T04:41:00.000Z",
              "hydrationLevel": 3,
              "readinessToCompete": 5
          },
          "throwingJournal": {
              "drills": [
                  "erter"
              ],
              "toolsDescription": "erter",
              "setsAndReps": "ertert",
              "longTossDistance": 22,
              "pitchCount": 25,
              "focus": "ert",
              "environment": "InGame"
          },
          "nutrition": {
              "nutritionScore": 6.666666666666666,
              "proteinInGram": 20,
              "caloricScore": 2.2222222222222223,
              "consumedImpedingSubstances": true
          },
          "armCare": {
              "focus": [
                  "Scapular",
                  "Forearms"
              ],
              "exerciseType": "Isometric",
              "recoveryModalities": [
                  "Hot tub",
                  "dsfsd"
              ],
              "exercisesLog": "sdfsdf"
          },
          "Lifting": {
              "liftingType": [
                  "Upper Body"
              ],
              "focus": [
                  "Speed"
              ],
              "exercisesLog": null
          },
          "hittingJournal": {
              "pregameEngagement": 4,
              "primaryFocus": "dsfs",
              "atBats": 222,
              "atBatResults": "sdfsdf",
              "positiveOutcome": "sdfsdf",
              "exercisesLog": null
          },
          "postPerformance": {
              "gameRating": 4,
              "sessionType": "Bullpen/Live at-bats",
              "gameResults": "skip",
              "primaryTakeaway": "nothing's"
          },
          "_id": "6837c663f90c344364e4abe9",
          "userId": "6833ce9bfc148b0f93e81f5b",
          "date": "2025-05-29T08:28:49.725Z",
          "createdAt": "2025-05-29T02:28:51.641Z",
          "updatedAt": "2025-05-29T08:34:29.875Z"
      }
  }
  ''';

  final Map<String, dynamic> jsonData = json.decode(jsonString) as Map<String, dynamic>;
  final apiResponse = DailyLogApiResponse.fromJson(jsonData);

  print('Success: ${apiResponse.success}');
  print('Message: ${apiResponse.message}');
  print('User ID: ${apiResponse.data.userId}');
  print('Lifting Exercise Log: ${apiResponse.data.lifting.exercisesLog}'); // Should be null
  print('Hitting Exercise Log: ${apiResponse.data.hittingJournal.exercisesLog}'); // Should be null
  print('Sleep Time: ${apiResponse.data.dailyWellnessQuestionnaire.sleepTime}');
  print('Nutrition Score: ${apiResponse.data.nutrition.nutritionScore}');

  // Example of converting back to JSON
  final String newJsonString = json.encode(apiResponse.toJson());
  print('\nRe-encoded JSON:');
  print(newJsonString);
}