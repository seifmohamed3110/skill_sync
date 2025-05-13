import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MentorSignUpScreen extends StatefulWidget {
  const MentorSignUpScreen({super.key});

  @override
  _MentorSignUpScreenState createState() => _MentorSignUpScreenState();
}

class _MentorSignUpScreenState extends State<MentorSignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController currentjobtitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController yearofexperienceController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController LINKEDINController = TextEditingController();

  bool _isPasswordVisible = false;

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

              // Full Name field
              _buildInputField(controller: fullNameController, hint: 'Full Name'),
              const SizedBox(height: 20),

              // Email field
              _buildInputField(controller: emailController, hint: 'Email'),
              const SizedBox(height: 20),

              // Password field
              _buildInputField(controller: passwordController, hint: 'Password', isPassword: true),
              const SizedBox(height: 20),

              // Phone field
              _buildInputField(controller: phoneController, hint: 'Phone Number'),
              const SizedBox(height: 20),

              // University field
              _buildInputField(controller: currentjobtitleController, hint: 'Current Job Title'),
              const SizedBox(height: 20),

              // Faculty field
              _buildInputField(controller: companyController, hint: 'Company'),
              const SizedBox(height: 20),

              // Graduation Year field
              _buildInputField(controller: yearofexperienceController, hint: 'Year Of Experience'),
              const SizedBox(height: 20),

              _buildInputField(controller: LINKEDINController, hint: 'Linkedin Profile Link'),
              const SizedBox(height: 20),



              // Sign Up button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF01497C),
                  minimumSize: const Size(double.infinity, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // TODO: Handle SignUp
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

              // Login button
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
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
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
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !_isPasswordVisible : false,
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
