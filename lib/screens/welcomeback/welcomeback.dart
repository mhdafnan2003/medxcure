import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medxecure/screens/admin/adminHome.dart';
import 'package:medxecure/screens/createaccount/create_account_page.dart';
import 'package:medxecure/screens/doctorhome/qr_code_scanner.dart';
import 'dart:convert';

import 'package:medxecure/screens/mainScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B2E),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Background image at the top
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              // Back Button
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // Login Form
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to your Account',
                        style: TextStyle(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 40),
                      const LoginForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedUserType;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool _isPasswordVisible = false;

  Future<void> userlogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) return;

    var url = Uri.parse("http://localhost:3000/api/auth/login");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim()
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Response Data: $responseData'); // Keep this for debugging

      emailController.clear();
      passwordController.clear();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Mainscreen()));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No matching company found.")));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if (selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a user type'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your username'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your password'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 6 characters long'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2B3E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // User Type Dropdown
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
                    child: Icon(Icons.arrow_drop_down, color: Colors.white70),
                  ),
                  items: ['Admin', 'Doctor', 'User']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(value,
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedUserType = newValue;
                    });
                    setState(() {
                      selectedUserType = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Username field
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white70),
                hintText: 'Username',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                // ignore: deprecated_member_use
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                errorStyle: const TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 16),

            // Password field
            TextField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.lock_outline, color: Colors.white70),
                hintText: 'Password',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                // ignore: deprecated_member_use
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                errorStyle: const TextStyle(color: Colors.red),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    userlogin();
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Remember me and Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value ?? false;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xFF00F7B1);
                          }
                          return Colors.white70;
                        },
                      ),
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Add forgot password navigation
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Login button with updated navigation
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (emailController.text == 'admin@gmail.com' &&
                      passwordController.text == '123456') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => MedicineAdmin()));
                  }
                  if (emailController.text == 'doctor@gmail.com' &&
                      passwordController.text == '123456') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => DoctorHomePage()));
                  } else {
                    await userlogin();
                  }
                  ;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F7B1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sign up link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CreateAccountPage()));
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF00F7B1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
