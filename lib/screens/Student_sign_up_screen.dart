import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({super.key});

  @override
  _StudentSignUpScreenState createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController graduationYearController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController degreeormajorController = TextEditingController();

  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> signUpStudent() async {
    final url = Uri.parse('https://skillsync-backend-production.up.railway.app/api/signup'); // Adjust to your actual endpoint

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': fullNameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'university': universityController.text.trim(),
          'faculty': facultyController.text.trim(),
          'graduationYear': graduationYearController.text.trim(),
          'password': passwordController.text,
          'degreeOrMajor': degreeormajorController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup Successful')),
        );
        print('Response: ${response.body}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup Failed: ${response.statusCode}')),
        );
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.06, 1],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2F5fbeb6c0e59e0710bf956727527a49dd80030b0eAsset%209logooo%201.png?alt=media&token=876fd11d-1791-4d72-9b73-6885a79aad57',
                  width: 190,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 60),

                _buildInputField(
                  controller: fullNameController,
                  hint: 'Full Name',
                  validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: emailController,
                  hint: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: passwordController,
                  hint: 'Password',
                  isPassword: true,
                  validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: phoneController,
                  hint: 'Phone Number',
                  validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: universityController,
                  hint: 'University',
                  validator: (value) => value!.isEmpty ? 'Please enter your university' : null,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: facultyController,
                  hint: 'Faculty Name',
                  validator: (value) => value!.isEmpty ? 'Please enter your faculty' : null,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: graduationYearController,
                  hint: 'Graduation Year',
                  validator: (value) => value!.isEmpty ? 'Please enter your graduation year' : null,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: degreeormajorController,
                  hint: 'Degree/major',
                  validator: (value) => value!.isEmpty ? 'Please enter your degree/major' : null,
                ),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01497C),
                    minimumSize: const Size(double.infinity, 58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      signUpStudent();
                    }
                  },
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'CantoraOne',
                      color: Color(0xFFEFEFEF),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xFF01497C),
                    fontFamily: 'CantoraOne',
                  ),
                ),
                const SizedBox(height: 20),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 58),
                    side: const BorderSide(color: Color(0xFF01497C), width: 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF01497C),
                      fontFamily: 'CantoraOne',
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0x7F61A5C2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !_isPasswordVisible : false,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.getFont(
            'Cantora One',
            fontSize: 20,
            color: const Color(0xFFEFEFEF),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
