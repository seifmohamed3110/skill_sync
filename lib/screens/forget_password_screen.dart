import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Widget _buildInputBox(String hintText, TextEditingController controller, {bool obscureText = false, VoidCallback? toggleVisibility}) {
    return Container(
      width: 327,
      height: 57,
      decoration: BoxDecoration(
        color: const Color(0x7F61A5C2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Color(0x16000000),
            offset: Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: Colors.white,
        style: GoogleFonts.getFont(
          'Cantora One',
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.getFont(
            'Cantora One',
            color: const Color(0xFFEFEFEF),
            fontSize: 18,
          ),
          border: InputBorder.none,
          suffixIcon: toggleVisibility != null
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70,
            ),
            onPressed: toggleVisibility,
          )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(),
          gradient: const LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF3A85A5), Color(0xFFEFEFEF)],
            stops: [0.01, 1],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 58,
              top: MediaQuery.of(context).size.height * 0.25,
              child: SizedBox(
                width: 262,
                height: 83,
                child: Text(
                  'FORGET PASSWORD ?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Cantora One',
                    color: const Color(0xFF01497C),
                    fontSize: 40,
                    height: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: MediaQuery.of(context).size.height * 0.40,
              child: _buildInputBox('EMAIL', _emailController),
            ),
            Positioned(
              left: 24,
              top: MediaQuery.of(context).size.height * 0.50,
              child: _buildInputBox(
                'PASSWORD',
                _passwordController,
                obscureText: _obscurePassword,
                toggleVisibility: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            Positioned(
              left: 24,
              top: MediaQuery.of(context).size.height * 0.60,
              child: _buildInputBox(
                'CONFIRM PASSWORD',
                _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                toggleVisibility: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            Positioned(
              left: 24,
              top: MediaQuery.of(context).size.height * 0.72,
              child: GestureDetector(
                onTap: () {
                  // Add your confirm logic here
                  print('Email: ${_emailController.text}');
                  print('Password: ${_passwordController.text}');
                  print('Confirm Password: ${_confirmPasswordController.text}');
                },
                child: Container(
                  width: 327,
                  height: 57,
                  decoration: BoxDecoration(
                    color: const Color(0xFF01497C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'CONFIRM',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.getFont(
                        'Cantora One',
                        color: const Color(0xFFEFEFEF),
                        fontSize: 25,
                        height: 0.7,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
