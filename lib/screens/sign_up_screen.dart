import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            stops: [0.06, 1],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ======= STUDENT CONTAINER (clickable) =======
            Positioned(
              left: 0,
              top: screenHeight * 0.26,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/student_signup');
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth * 0.92,
                      height: screenHeight * 0.22,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(17),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x2D000000),
                            spreadRadius: 0,
                            offset: Offset(10.5, -12.2),
                            blurRadius: 35,
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF01497C),
                            Color(0xFF61A5C2),
                            Color(0xFFEFEFEF)
                          ],
                          stops: [0, 0.59, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.04,
                      top: screenHeight * 0.015,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fe9a4c9e4-f7a8-4e38-a1fd-509d8713a1ad.png',
                        width: screenWidth * 0.81,
                        height: screenHeight * 0.22,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.2,
                      top: screenHeight * 0.05,
                      child: SizedBox(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.05,
                        child: const Text(
                          'STUDENT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ======= FRESH GRADUATED CONTAINER (clickable) =======
            Positioned(
              left: 0,
              top: screenHeight * 0.47,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/student_signup');
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth * 0.86,
                      height: screenHeight * 0.22,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(17),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x2D000000),
                            spreadRadius: 0,
                            offset: Offset(10.5, -12.2),
                            blurRadius: 35,
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF01497C),
                            Color(0xFF61A5C2),
                            Color(0xFFEFEFEF)
                          ],
                          stops: [0, 0.59, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.02,
                      top: screenHeight * 0.01,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fa3da86f2-00a0-4ca2-bc33-f2e373fe4bb0.png',
                        width: screenWidth * 0.81,
                        height: screenHeight * 0.22,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.1,
                      top: screenHeight * 0.05,
                      child: SizedBox(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.05,
                        child: const Text(
                          'FRESH GRADUATED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ======= MENTOR (now clickable) =======
            Positioned(
              left: 0,
              top: screenHeight * 0.69,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/mentor_signup'); // Added navigation
                },
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth * 0.78,
                      height: screenHeight * 0.22,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(17),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x2D000000),
                            spreadRadius: 0,
                            offset: Offset(10.5, -12.2),
                            blurRadius: 35,
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF01497C),
                            Color(0xFF61A5C2),
                            Color(0xFFEFEFEF)
                          ],
                          stops: [0, 0.59, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.03,
                      top: screenHeight * 0.01,
                      child: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F7132e859-8b03-4a57-981a-8d1542bb4e8d.png',
                        width: screenWidth * 0.68,
                        height: screenHeight * 0.22,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.2,
                      top: screenHeight * 0.05,
                      child: SizedBox(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.05,
                        child: const Text(
                          'MENTOR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ======= HEADER =======
            const Positioned(
              left: 90,
              top: 98,
              child: SizedBox(
                width: 198,
                height: 83,
                child: Text(
                  'SIGNUP AS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF01497C),
                    fontSize: 40,
                    height: 1,
                    fontFamily: 'CantoraOne',
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