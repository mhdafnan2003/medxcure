import 'dart:convert';
import 'package:http/http.dart' as http;
import 'medical_record.dart';

class GeminiService {
  final String apiKey = 'AIzaSyBqB36aOdroXVo4KtJOyBYVTs7aQgWUdLQ';
  final String apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  Future<String> generateResponse(String userInput, MedicalRecord patientRecord) async {
    final String enhancedPrompt = '''
Context: Patient ${patientRecord.patientName}, Age: ${patientRecord.age}
Conditions: ${patientRecord.conditions.join(', ')}
Medications: ${patientRecord.medications.join(', ')}
Allergies: ${patientRecord.allergies.join(', ')}

User Query: $userInput

Please provide medical advice considering the patient's history.
''';

    final response = await http.post(
      Uri.parse('$apiUrl?key=$apiKey'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {"parts": [{"text": enhancedPrompt}]}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to generate response: ${response.statusCode}');
    }
  }

  Future<String> generateRecoveryPlan(MedicalRecord patientRecord) async {
    // Implementation for generating recovery plan
    return "Recovery plan implementation";
  }
}
