class ChatMessage {
  final String text;
  final String role;
  final DateTime timestamp;
  final MessageType type;

  ChatMessage({
    required this.text,
    required this.role,
    required this.timestamp,
    this.type = MessageType.text,
  });
}

enum MessageType { text, summary, recommendation }
