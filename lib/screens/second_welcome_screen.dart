import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondWelcomeScreen extends StatelessWidget {
  const SecondWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen height and width
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(0),
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
              left: screenWidth * 0.06,
              top: screenHeight * 0.69,
              child: SizedBox(
                width: screenWidth * 0.88,
                height: screenHeight * 0.038,
                child: Text(
                  'Do you have an account?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Cantora One',
                    color: const Color(0xFF01497C),
                    fontSize: 25,
                    height: 0.7,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.06,
              top: screenHeight * 0.75,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Container(
                  width: screenWidth * 0.87,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: const Color(0xFF01497C),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'LOGIN',
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
            Positioned(
              left: screenWidth * 0.06,
              top: screenHeight * 0.84,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Container(
                  width: screenWidth * 0.87,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: const Color(0xFF01497C),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'SIGN UP',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Cantora One',
                      color: const Color(0xFF01497C),
                      fontSize: 25,
                      height: 0.7,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: screenHeight * 0.03,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2F682b0301915643ec0b6daa6bf36165081595d91dAsset%2012logo%20finalll%202.png?alt=media&token=fcb2b02f-fcbc-488c-a0d4-ac299def7219',
                width: 1,
                height: 4,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: screenWidth * 0.23,
              top: screenHeight * 0.47,
              child: SizedBox(
                width: screenWidth * 0.55,
                height: screenHeight * 0.04,
                child: Text(
                  'Closer Than You Think',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Cantora One',
                    color: const Color(0xFF01497C),
                    fontSize: 20,
                    height: 1.1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.23,
              top: screenHeight * 0.32,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2F5fbeb6c0e59e0710bf956727527a49dd80030b0eAsset%209logooo%201.png?alt=media&token=876fd11d-1791-4d72-9b73-6885a79aad57',
                width: screenWidth * 0.6,
                height: screenHeight * 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
