import 'package:flutter/material.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();

  // Define colors for easy reuse and modification
  static const Color darkBackground = Color(0xFF121212); // Very dark grey
  static const Color inputBackground = Color(
    0xFF3A3A3C,
  ); // Darker grey for input
  static const Color primaryYellow = Color(0xFFFFD60A); // Same yellow as before
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey; // Grey text
  static const Color hintColor = Color(0xFF8E8E93); // Lighter grey for hint

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textPrimary),
          onPressed: () {
            // Handle back navigation
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'AI Chat',
          style: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true, // Center the title
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 8.0,
            ), // Adjust padding slightly
            child: CircleAvatar(
              radius: 18,
              backgroundColor: inputBackground, // Use input bg for consistency
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: textPrimary,
                  size: 22,
                ),
                onPressed: () {
                  // Handle notification tap
                },
                tooltip: 'Notifications', // Add tooltip for accessibility
                padding: EdgeInsets.zero, // Remove default padding
                constraints: const BoxConstraints(), // Remove constraints
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            // This makes the welcome message area take up available space
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Size column to its children
                  children: [
                    const Text(
                      'Welcome to Your Personal',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: textPrimary, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: '"', // Opening quote
                        style: const TextStyle(
                          color: primaryYellow,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Ask Coach PJ'), // Yellow text
                          const TextSpan(text: '"'), // Closing quote
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '"What\'s up Simi! What do you got today?"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 16,
                        // fontStyle: FontStyle.italic, // Optional: if you want italic
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Input field area at the bottom
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      // Use Container for padding and potential background/border styling
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color:
          darkBackground, // Match scaffold background or specific color if needed
      child: Container(
        decoration: BoxDecoration(
          color: inputBackground,
          borderRadius: BorderRadius.circular(25.0), // Rounded corners
        ),
        child: TextField(
          controller: _controller,
          style: const TextStyle(
            color: textPrimary,
            fontSize: 16,
          ), // Input text color
          cursorColor: primaryYellow, // Cursor color
          decoration: InputDecoration(
            hintText: 'Message with coach PJ...',
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: 16,
            ), // Hint text color
            border: InputBorder.none, // Remove default border
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 14.0,
            ), // Padding inside the input field
            suffixIcon: IconButton(
              icon: const Icon(Icons.send, color: textPrimary),
              onPressed: () {
                // Handle message sending logic
                String message = _controller.text;
                if (message.isNotEmpty) {
                  print('Sending message: $message');
                  // Add your logic to send the message
                  _controller.clear(); // Clear the input field after sending
                  FocusScope.of(context).unfocus(); // Hide keyboard
                }
              },
            ),
          ),
          onSubmitted: (message) {
            // Handle message sending logic when user presses 'send' on keyboard
            if (message.isNotEmpty) {
              print('Sending message (submitted): $message');
              // Add your logic to send the message
              _controller.clear(); // Clear the input field after sending
              FocusScope.of(context).unfocus(); // Hide keyboard
            }
          },
        ),
      ),
    );
  }
}
