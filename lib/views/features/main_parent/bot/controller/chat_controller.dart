import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:baseball_ai/core/models/chat_model.dart';
import 'package:baseball_ai/core/services/api_service.dart';
import 'package:baseball_ai/views/features/auth/controller/auth_controller.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  // Observable list of chat messages
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;

  // Get AuthController instance
  AuthController get authController => Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    // Add welcome message from bot
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    final welcomeMessage = ChatMessage.bot(
      "Hey there! I'm Coach PJ, your personal baseball AI coach. What's up? What do you got today?"
    );
    messages.add(welcomeMessage);
  }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    if (messageText.isEmpty || isSending.value) return;

    final user = authController.currentUser.value;
    if (user == null) {
      Get.snackbar(
        'Error',
        'Please login to send messages',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    try {
      isSending.value = true;

      // Add user message to the list
      final userMessage = ChatMessage.user(messageText);
      messages.add(userMessage);
      
      // Clear the input field
      messageController.clear();
      
      // Scroll to bottom
      _scrollToBottom();

      // Send message to API
      final response = await ApiService.sendChatMessage(
        token: authController.accessToken.value,
        userId: user.id,
        message: messageText,
      );

      if (response.success && response.data != null) {
        // Add bot response to the list
        final botResponseText = response.data!.response ?? response.data!.message;
        final botMessage = ChatMessage.bot(botResponseText);
        messages.add(botMessage);
        
        // Scroll to bottom to show new message
        _scrollToBottom();
      } else {
        // Add error message from bot
        final errorMessage = ChatMessage.bot(
          "Sorry, I'm having trouble responding right now. Please try again later."
        );
        messages.add(errorMessage);
        _scrollToBottom();
        
        Get.snackbar(
          'Error',
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      // Add error message from bot
      final errorMessage = ChatMessage.bot(
        "Sorry, something went wrong. Please try again."
      );
      messages.add(errorMessage);
      _scrollToBottom();
      
      Get.snackbar(
        'Error',
        'Failed to send message: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSending.value = false;
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
