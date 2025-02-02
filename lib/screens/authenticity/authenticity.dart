import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medxecure/screens/drug/drugdetail.dart';
 // Import the new screen

class MedicineAuthPage extends StatefulWidget {
  MedicineAuthPage({super.key});

  static const List<String> categories = [
    'Antibiotics',
    'Pain Relief',
    'Cardiovascular',
    'Diabetes',
    'Respiratory',
    'Vitamins',
    'Others'
  ];

  @override
  State<MedicineAuthPage> createState() => _MedicineAuthPageState();
}

class _MedicineAuthPageState extends State<MedicineAuthPage> {
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController lotController = TextEditingController();

  Future<void> checkCompanyData() async {
    String licenseNumber = licenseController.text.trim();
    String lotNumber = lotController.text.trim();
    if (licenseNumber.isEmpty || lotNumber.isEmpty) return;

    var url = Uri.parse("http://localhost:3000/api/auth/companyCheck");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"licenseNumber": licenseNumber, "lotNumber": lotNumber}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('Response Data: $responseData'); // Debugging log

      // Navigate to DrugDetailsScreen and pass response data
      if (!mounted) return; // Ensure the widget is still in the tree
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DrugDetailsScreen(),
        ),
      );

      licenseController.clear();
      lotController.clear();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No matching company found.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top bar with back button
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // Category selector
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: MedicineAuthPage.categories.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemBuilder: (context, index) =>
                      _buildCategoryButton(MedicineAuthPage.categories[index]),
                ),
              ),

              // Text fields
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildTextField('Enter License No', licenseController),
                    const SizedBox(height: 20),
                    _buildTextField('Enter Lot No', lotController),
                    const SizedBox(height: 20),

                    // Check Authenticity button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3EDBC9),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: checkCompanyData, // Call the function
                      child: const Text(
                        'Check Authenticity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3EDBC9),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {},
        child: Text(
          category,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
