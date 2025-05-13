import 'dart:math';
import 'package:flutter/material.dart';

class ResumeCheckScreen extends StatelessWidget {
  const ResumeCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.06, 1],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 353,
                top: 28,
                child: Image.network(
                  'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F5a399cd3-8fc8-43ff-b1df-101ef72a01f3.png',
                  width: 1,
                  height: 4,
                  fit: BoxFit.contain,
                ),
              ),
              const Positioned(
                left: 83,
                top: 71,
                child: SizedBox(
                  width: 251,
                  height: 32,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: -1,
                        top: -1,
                        child: SizedBox(
                          width: 255,
                          height: 46,
                          child: Text(
                            'Resume Check',
                            style: TextStyle(
                              color: Color(0xFF01497C),
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.7,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Positioned(
                left: 75,
                top: 237,
                child: SizedBox(
                  width: 251,
                  height: 32,
                ),
              ),
              Positioned(
                left: 31,
                top: 71,
                child: Transform.rotate(
                  angle: 180 * pi / 180,
                  child: Container(
                    width: 32,
                    height: 32,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 2,
                          top: 2,
                          child: Transform.rotate(
                            angle: 0 * pi / 180,
                            child: Image.network(
                              'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F59397550-8158-42a3-b3fc-c410dea919bb.png',
                              width: 28,
                              height: 28,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 130,
                child: Container(
                  width: 302,
                  height: 563,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2B6893), Color(0xFF61A5C2), Color(0xFFEFEFEF)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.75, 1],
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 565,
                child: Text(
                  'Languages if you know multi languages',
                  style: TextStyle(
                    color: Color(0xFFE7EBEC),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 596,
                child: Text(
                  'Presentation Skills',
                  style: TextStyle(
                    color: Color(0xFFE7EBEC),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 56,
                top: 260,
                child: Text(
                  'Personal Information:',
                  style: TextStyle(
                    color: Color(0xFF01497C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 56,
                top: 399,
                child: Text(
                  'Education:',
                  style: TextStyle(
                    color: Color(0xFF01497C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 57,
                top: 518,
                child: Text(
                  'Skills:',
                  style: TextStyle(
                    color: Color(0xFF01497C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 0.8,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 233,
                child: Image.network(
                  'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F5d55bf1b-d840-4bd6-8932-571873c697e8.png',
                  width: 0,
                  height: 357,
                  fit: BoxFit.contain,
                ),
              ),
              const Positioned(
                left: 28,
                top: 161,
                child: SizedBox(
                  width: 321,
                  height: 62,
                  child: Text(
                    'Edit suggestions to \nenhance your CV:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFEFEFEF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.6,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 301,
                child: Text(
                  'Phone number',
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 330,
                child: Text(
                  'Email address',
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 361,
                child: Text(
                  'Home address',
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 437,
                child: Text(
                  'High school name, graduation year',
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              const Positioned(
                left: 86,
                top: 474,
                child: Text(
                  'University name, graduation year',
                  style: TextStyle(
                    color: Color(0xFFEFEFEF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    fontFamily: 'Roboto',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}