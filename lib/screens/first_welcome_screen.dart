import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstWelcomeScreen extends StatelessWidget {
  const FirstWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              left: 91,
              top: screenHeight * 0.46,
              child: SizedBox(
                width: 193,
                height: 34,
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
              left: screenWidth * 0.78,
              top: screenHeight * 0.89,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Container(
                  width: 62,
                  height: 56,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        spreadRadius: 2,
                        offset: Offset.zero,
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 17,
                        top: 16,
                        child: Image.network(
                          'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fbdedfe0a-a478-4fc0-abaf-c1ed88ce4c58.png',
                          width: 29,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 93,
              top: screenHeight * 0.33,
              child: Image.asset(
                'assets/logo.png', // Ensure correct path for local asset
                width: 190,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
