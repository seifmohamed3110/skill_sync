// assessment_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AssessmentIntroScreen();
  }
}

class AssessmentIntroScreen extends StatelessWidget {
  const AssessmentIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            stops: [0.06, 1],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 353,
              top: 28,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F121bf069-9911-4be6-a227-1b6c7628b472.png',
                width: 1,
                height: 4,
                fit: BoxFit.contain,
              ),
            ),
            const Positioned(
              left: 82,
              top: 70,
              child: Text(
                'Career Assessment',
                style: TextStyle(
                  color: Color(0xFF01497C),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const Positioned(
              left: 55,
              top: 272,
              child: SizedBox(
                width: 268,
                child: Text(
                  'Are you ready for the \nassessment?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF01497C),
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 24,
              top: 391,
              child: SizedBox(
                width: 327,
                child: Text(
                  'Please answer all the questions carefully.\nThis will help us understand your interests and recommend a suitable career path for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    letterSpacing: 0.5,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: 549,
              child: SizedBox(
                width: 327,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01497C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/assessment/questions');
                  },
                  child: const Text(
                    'Start Assessment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'CantoraOne',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 31,
              top: 71,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/student_home',
                        (Route<dynamic> route) => false,
                  );
                },
                child: Transform.rotate(
                  angle: 0,
                  child: Image.asset(
                    'assets/back_arrow.png',                 width: 32,
                    height: 32,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AssessmentQuestionsScreen extends StatefulWidget {
  const AssessmentQuestionsScreen({super.key});

  @override
  State<AssessmentQuestionsScreen> createState() => _AssessmentQuestionsScreenState();
}

class _AssessmentQuestionsScreenState extends State<AssessmentQuestionsScreen> {
  final Map<String, String?> answers = {
    'interest': null,
    'experience': null,
    'commitment': null,
    'work_preference': null,
  };

  final Map<String, List<String>> dropdownOptions = {
    'interest': [
      'Technology and Programming',
      'Business and Finance',
      'Arts and Design',
      'Healthcare',
      'Education',
      'Engineering',
      'Other'
    ],
    'experience': [
      'No experience',
      'Beginner (less than 1 year)',
      'Intermediate (1-3 years)',
      'Advanced (3+ years)',
      'Professional'
    ],
    'commitment': [
      'Less than 5 hours per week',
      '5-10 hours per week',
      '10-20 hours per week',
      '20-30 hours per week',
      'More than 30 hours per week'
    ],
    'work_preference': [
      'Office work',
      'Remote work',
      'Hybrid (both office and remote)',
      'Field work',
      'Flexible (any of the above)'
    ],
  };

  void updateAnswer(String key, String? value) {
    setState(() {
      answers[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.06, 1],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset(
                        'assets/back_arrow.png',
                        width: 28,
                        height: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Career Assessment',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF01497C),
                        fontFamily: 'Roboto',
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Please select answers from the dropdown menus:',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildDropdownQuestion(
                        key: 'interest',
                        question: 'What field interests you the most?',
                        iconUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F9b8277c3-b24f-4c61-9af5-42777d2bdcb7.png',
                        hint: 'Select your interest area',
                      ),
                      const SizedBox(height: 20),
                      _buildDropdownQuestion(
                        key: 'experience',
                        question: 'What is your experience level?',
                        iconUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F70c5fac5-8f52-4c3e-900a-8c2e603aa33e.png',
                        hint: 'Select your experience level',
                      ),
                      const SizedBox(height: 20),
                      _buildDropdownQuestion(
                        key: 'commitment',
                        question: 'How much time can you commit weekly?',
                        iconUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fafc4aebb-d00e-48a7-b3ab-568b696e2478.png',
                        hint: 'Select your weekly commitment',
                      ),
                      const SizedBox(height: 20),
                      _buildDropdownQuestion(
                        key: 'work_preference',
                        question: 'What is your preferred work environment?',
                        iconUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fafc4aebb-d00e-48a7-b3ab-568b696e2478.png',
                        hint: 'Select work preference',
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/assessment/results');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFF01497C),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Submit Assessment',
                      style: GoogleFonts.getFont(
                        'Cantora One',
                        fontSize: 25,
                        color: const Color(0xFFEFEFEF),
                        height: 0.7,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownQuestion({
    required String key,
    required String question,
    required String iconUrl,
    required String hint,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF01497C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            offset: Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  question,
                  style: GoogleFonts.getFont(
                    'Cantora One',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: answers[key],
              onChanged: (value) => updateAnswer(key, value),
              items: dropdownOptions[key]!
                  .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
                  .toList(),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
              style: const TextStyle(color: Colors.black),
              dropdownColor: Colors.white,
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}

class AssessmentResultsScreen extends StatefulWidget {
  const AssessmentResultsScreen({super.key});

  @override
  _AssessmentResultsScreenState createState() => _AssessmentResultsScreenState();
}

class _AssessmentResultsScreenState extends State<AssessmentResultsScreen> {
  bool isGraphicDesignerExpanded = false;
  bool isFrontendDeveloperExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            stops: [0.06, 1],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 83,
              top: 71,
              child: SizedBox(
                width: 251,
                height: 32,
                child: Text(
                  'Assessment Results',
                  style: GoogleFonts.roboto(
                    color: Color(0xFF01497C),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 33,
              top: 73,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/back_arrow.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: 102,
              top: 121,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.roboto(
                    color: Color(0xFF01497C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                  children: const [
                    TextSpan(text: 'CAREER ROADMAP\nSUGGESTION'),
                    TextSpan(text: 'S')
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: 183,
              child: Column(
                children: [
                  // Graphic Designer Section
                  Column(
                    children: [
                      Container(
                        width: 327,
                        height: 57,
                        decoration: BoxDecoration(
                          color: Color(0xFFC0D2DE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 40,
                              top: 19,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/grahic_designer_roadmap');
                                },
                                child: Text(
                                  'GRAPHIC DESIGNER',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 0.8,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 20,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isGraphicDesignerExpanded = !isGraphicDesignerExpanded;
                                  });
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Icon(
                                  isGraphicDesignerExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isGraphicDesignerExpanded)
                        Container(
                          width: 327,
                          decoration: BoxDecoration(
                            color: Color(0xFF01497C),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 327,
                                height: 80,
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x16000000),
                                      spreadRadius: 0,
                                      offset: Offset(0, 10),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 15,
                                      child: Text(
                                        'Graphic Design Software',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          height: 0.9,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 45,
                                      child: Container(
                                        width: 293,
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: 0.2,
                                                backgroundColor: Color(0xFFD9D9D9),
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF024372)),
                                                minHeight: 10,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '20%',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 327,
                                height: 69,
                                margin: EdgeInsets.only(top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      spreadRadius: 0,
                                      offset: Offset(0, 2),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 15,
                                      child: Text(
                                        'Design Principles',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          height: 0.9,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 45,
                                      child: Container(
                                        width: 293,
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: 0.57,
                                                backgroundColor: Color(0xFFD9D9D9),
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF024372)),
                                                minHeight: 10,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '57%',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      // Frontend Developer Section
                      Container(
                        width: 327,
                        height: 57,
                        decoration: BoxDecoration(
                          color: Color(0xFFC0D2DE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 40,
                              top: 19,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/frontend_roadmap');
                                },
                                child: Text(
                                  'FRONTEND DEVELOPER',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 0.8,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              top: 20,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFrontendDeveloperExpanded = !isFrontendDeveloperExpanded;
                                  });
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Icon(
                                  isFrontendDeveloperExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isFrontendDeveloperExpanded)
                        Container(
                          width: 327,
                          decoration: BoxDecoration(
                            color: Color(0xFF01497C),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 327,
                                height: 80,
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x16000000),
                                      spreadRadius: 0,
                                      offset: Offset(0, 10),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 15,
                                      child: Text(
                                        'Programming Fundamentals',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          height: 0.9,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 45,
                                      child: Container(
                                        width: 293,
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: 0.86,
                                                backgroundColor: Color(0xFFD9D9D9),
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF024372)),
                                                minHeight: 10,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '86%',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 327,
                                height: 69,
                                margin: EdgeInsets.only(top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      spreadRadius: 0,
                                      offset: Offset(0, 2),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 15,
                                      child: Text(
                                        'Data Structures and Algorithms',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          height: 0.9,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 15,
                                      top: 45,
                                      child: Container(
                                        width: 293,
                                        height: 20,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: LinearProgressIndicator(
                                                value: 0.62,
                                                backgroundColor: Color(0xFFD9D9D9),
                                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF024372)),
                                                minHeight: 10,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '62%',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}