import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medxecure/screens/admin/adminHome.dart';
import 'package:medxecure/screens/doctor/doctorHome.dart';
import 'package:medxecure/screens/home/home.dart';
import 'package:medxecure/screens/welcomeback/welcomeback.dart';


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isEmailValid = true;

  // Validation patterns
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final phoneRegex = RegExp(r'^\+?[\d\s-]{10,12}$');

  // Add this field at the start of the class
  String? selectedUserType;

  void validateEmail(String value) {
    setState(() {
      _isEmailValid = emailRegex.hasMatch(value);
    });
  }

  void validatePhone(String value) {
    String cleanPhone = value.replaceAll(RegExp(r'[\s-]'), '');
    setState(() {});
  }

  void validatePasswords() {
    setState(() {
      passwordController.text == _confirmPasswordController.text;
    });
  }

  bool validateForm() {
    return _isEmailValid &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        selectedUserType != null;
  }

  InputDecoration getInputDecoration({
    required String hintText,
    required IconData icon,
    String? errorText,
  }) {
    return InputDecoration(
      filled: true,
      // ignore: deprecated_member_use
      fillColor: Colors.white.withOpacity(0.08),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF00BFAE), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      errorText: errorText,
      errorStyle: const TextStyle(color: Colors.red),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      // ignore: deprecated_member_use
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> userSignUp() async {
      if (!validateForm()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields correctly")),
        );
        return;
      }

      if (selectedUserType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a user type")),
        );
        return;
      }

      try {
        var url = Uri.parse("http://localhost:3000/api/auth/signup");
        print('Attempting to connect to: $url');

        var requestBody = {
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "name": nameController.text.trim(),
          "role": selectedUserType?.toLowerCase(),
        };
        print('Sending request with data: ${jsonEncode(requestBody)}');

        var response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
          body: jsonEncode(requestBody),
        );

        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 201 || response.statusCode == 200) {
          emailController.clear();
          passwordController.clear();
          nameController.clear();
          _confirmPasswordController.clear();

          // Navigate based on user role
          // ignore: use_build_context_synchronously
          switch (selectedUserType?.toLowerCase()) {
            case 'Admin':
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const MedicineAdmin()));
              break;
            case 'Doctor':
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const Doctorhome()));
              break;
            case 'User':
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const HomePage()));
              break;
            default:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
          }
        } else {
          var errorMessage = response.body;
          try {
            var jsonResponse = jsonDecode(response.body);
            errorMessage = jsonResponse['message'] ?? response.body;
          } catch (e) {
            print('Error parsing response: $e');
          }

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration failed: $errorMessage"),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      } catch (e) {
        print('Error details: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connection Error: $e"),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please fill the input below here',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedUserType,
                        hint: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Select User Type',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        dropdownColor: const Color(0xFF2A2B3E),
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.arrow_drop_down,
                              color: Colors.white70),
                        ),
                        items: ['Admin', 'Doctor', 'User']
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(value,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedUserType = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: getInputDecoration(
                      hintText: 'FULL NAME',
                      icon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: getInputDecoration(
                      hintText: 'EMAIL',
                      icon: Icons.email_outlined,
                      errorText:
                          !_isEmailValid && emailController.text.isNotEmpty
                              ? 'Invalid email address'
                              : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: getInputDecoration(
                      hintText: 'PASSWORD',
                      icon: Icons.lock_outline,
                    ),
                    onChanged: (value) => validatePasswords(),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await userSignUp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFAE),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                color: Color(0xFF00F7B1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
