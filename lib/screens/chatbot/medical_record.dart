class MedicalRecord {
  final String patientName;
  final int age;
  final List<String> conditions;
  final List<String> medications;
  final List<String> allergies;
  final List<Map<String, dynamic>> medicalHistory;

  MedicalRecord({
    required this.patientName,
    required this.age,
    required this.conditions,
    required this.medications,
    required this.allergies,
    required this.medicalHistory,
  });
}
