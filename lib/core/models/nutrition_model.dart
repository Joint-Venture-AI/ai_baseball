class NutritionRequest {
  final String user;
  final int nutritionScore;
  final int proteinScore;
  final int caloricScore;
  final bool consumedImpedingSubstances;
  final DateTime date;

  NutritionRequest({
    required this.user,
    required this.nutritionScore,
    required this.proteinScore,
    required this.caloricScore,
    required this.consumedImpedingSubstances,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'nutritionScore': nutritionScore,
      'proteinScore': proteinScore,
      'caloricScore': caloricScore,
      'consumedImpedingSubstances': consumedImpedingSubstances,
      'date': date.toIso8601String(),
    };
  }
}

class NutritionResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  NutritionResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory NutritionResponse.fromJson(Map<String, dynamic> json) {
    return NutritionResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
