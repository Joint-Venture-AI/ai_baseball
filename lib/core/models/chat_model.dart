class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      message: json['message'] ?? '',
      isUser: json['isUser'] ?? false,
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create user message
  factory ChatMessage.user(String message) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      isUser: true,
      timestamp: DateTime.now(),
    );
  }

  // Create bot message
  factory ChatMessage.bot(String message) {
    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}

class ChatRequest {
  final String userId;
  final String message;

  ChatRequest({
    required this.userId,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'message': message,
    };
  }
}

class ChatResponse {
  final bool success;
  final String message;
  final String? response;
  final String? error;

  ChatResponse({
    required this.success,
    required this.message,
    this.response,
    this.error,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      response: json['response'] ?? json['data'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'response': response,
      'error': error,
    };
  }
}
