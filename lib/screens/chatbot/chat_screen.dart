import 'package:flutter/material.dart';
import 'chat_theme.dart';
import 'medical_record.dart';
import 'chat_message.dart';
import 'gemini_service.dart';
import 'chat_message_bubble.dart';

// Enhanced theme constants
class EnhancedChatTheme {
  static const primaryTeal = Color(0xFF00BFA5);
  static const darkBlack = Color(0xFF121212);
  static const surfaceBlack = Color(0xFF1E1E1E);
  static const lightTeal = Color(0xFF64FFDA);
  static const darkGrey = Color(0xFF2D2D2D);
  static const white = Color(0xFFFFFFFF);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = GeminiService();
  final List<ChatMessage> messages = [];
  bool _isTyping = false;
  late MedicalRecord patientRecord;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    patientRecord = MedicalRecord(
      patientName: "John Doe",
      age: 45,
      conditions: ["Hypertension", "Type 2 Diabetes"],
      medications: ["Metformin", "Lisinopril"],
      allergies: ["Penicillin"],
      medicalHistory: [
        {"date": "2023-12-01", "event": "Annual Checkup"},
        {"date": "2023-10-15", "event": "Blood Work"},
      ],
    );
    _loadPatientSummary();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _loadPatientSummary() async {
    setState(() {
      messages.add(ChatMessage(
        text: "Patient Summary:\n" +
            "Name: ${patientRecord.patientName}\n" +
            "Age: ${patientRecord.age}\n" +
            "Conditions: ${patientRecord.conditions.join(', ')}\n" +
            "Current Medications: ${patientRecord.medications.join(', ')}",
        role: "bot",
        timestamp: DateTime.now(),
        type: MessageType.summary,
      ));
    });
    _fadeController.forward();
  }

  Future<void> sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text;
    setState(() {
      messages.add(ChatMessage(
        text: userMessage,
        role: "user",
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });
    _slideController.forward(from: 0.0);

    try {
      final response = await _geminiService.generateResponse(
        userMessage,
        patientRecord,
      );

      setState(() {
        messages.add(ChatMessage(
          text: response,
          role: "bot",
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });
      _fadeController.forward(from: 0.0);
    } catch (e) {
      setState(() {
        messages.add(ChatMessage(
          text: "Sorry, I encountered an error. Please try again.",
          role: "bot",
          timestamp: DateTime.now(),
        ));
        _isTyping = false;
      });
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EnhancedChatTheme.darkBlack,
      appBar: AppBar(
        leading: IconButton(color: Colors.white,onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new,)),
        backgroundColor: EnhancedChatTheme.surfaceBlack,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patientRecord.patientName,
              style: TextStyle(
                color: EnhancedChatTheme.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Medical Assistant',
              style: TextStyle(
                fontSize: 14,
                color: EnhancedChatTheme.primaryTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return ChatMessageBubble(message: messages[index]);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EnhancedChatTheme.surfaceBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyle(color: EnhancedChatTheme.white),
              decoration: InputDecoration(
                hintText: "Ask about medical condition...",
                hintStyle: TextStyle(color: EnhancedChatTheme.white.withOpacity(0.5)),
                filled: true,
                fillColor: EnhancedChatTheme.darkGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: EnhancedChatTheme.primaryTeal, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: EnhancedChatTheme.primaryTeal, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          FloatingActionButton(
            onPressed: sendMessage,
            child: Icon(Icons.send, color: EnhancedChatTheme.darkBlack),
            backgroundColor: EnhancedChatTheme.primaryTeal,
            mini: true,
          ),
        ],
      ),
    );
  }
}
