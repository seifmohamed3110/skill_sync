import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  bool _showRoles = false;

  final List<String> _roles = ['STUDENT', 'MENTOR'];
  final String _signUpUrl = 'https://skillsync-backend-production.up.railway.app/api/auth/register';

  Future<void> _signUpUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final body = jsonEncode({
        'name': fullNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'role': _selectedRole?.toLowerCase(),
      });

      debugPrint('Sending signup request to: $_signUpUrl');
      debugPrint('Request body: $body');

      final response = await http.post(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      ).timeout(const Duration(seconds: 20));

      // Added debug prints
      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Success
        Navigator.pushReplacementNamed(
          context,
          _selectedRole == 'STUDENT' ? '/student_home' : '/mentor_home',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
      } else {
        // Handle different error cases
        final errorMessage = _getErrorMessage(response);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } on TimeoutException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request timed out. Please try again.')),
      );
    } on http.ClientException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: ${e.message}')),
      );
    } catch (e) {
      debugPrint('Error during signup: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _getErrorMessage(http.Response response) {
    try {
      final responseData = jsonDecode(response.body);
      return responseData['message'] ??
          responseData['error'] ??
          'Registration failed (Status ${response.statusCode})';
    } catch (e) {
      return 'Registration failed (Status ${response.statusCode})';
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
                Image.asset(
                  'assets/logo.png',
                  width: 190,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 60),

                // Full Name Field
                _buildInputField(
                  controller: fullNameController,
                  hint: 'Full Name',
                  validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
                ),
                const SizedBox(height: 20),

                // Email Field
                _buildInputField(
                  controller: emailController,
                  hint: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                _buildInputField(
                  controller: passwordController,
                  hint: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter a password';
                    if (value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Role Selection
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _showRoles = !_showRoles),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF01497C),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedRole ?? 'SELECT ROLE',
                                style: GoogleFonts.getFont(
                                  'Cantora One',
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(
                                _showRoles ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (_showRoles)
                      Column(
                        children: _roles.map((role) => GestureDetector(
                          onTap: () => setState(() {
                            _selectedRole = role;
                            _showRoles = false;
                          }),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x19000000),
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  role,
                                  style: GoogleFonts.getFont(
                                    'Cantora One',
                                    color: const Color(0xFF01497C),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF01497C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _isLoading ? null : _signUpUser,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'CantoraOne',
                        color: Color(0xFFEFEFEF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // OR Divider
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFF01497C))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xFF01497C),
                          fontFamily: 'CantoraOne',
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFF01497C))),
                  ],
                ),
                const SizedBox(height: 20),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF01497C), width: 3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _isLoading ? null : () => Navigator.pushNamed(context, '/login'),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF01497C),
                        fontFamily: 'CantoraOne',
                      ),
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
            onPressed: () => setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            }),
          )
              : null,
        ),
      ),
    );
  }
}