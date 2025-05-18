import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
                child: Image.asset(
                  'assets/back_arrow.png',
                  width: 32,
                  height: 32,
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
  final List<Map<String, dynamic>> questions = [
    {
      'id': 'q1',
      'question': 'Which activity do you enjoy the most?',
      'category': 'interests',
      'options': [
        {'text': 'Designing user-friendly interfaces', 'score': 1, 'category': 'uiux'},
        {'text': 'Solving complex algorithmic problems', 'score': 1, 'category': 'programming'},
        {'text': 'Analyzing and visualizing data trends', 'score': 1, 'category': 'data'},
        {'text': 'Developing mobile applications', 'score': 1, 'category': 'mobile'},
        {'text': 'Building scalable APIs and systems', 'score': 1, 'category': 'backend'},
      ],
    },
    {
      'id': 'q2',
      'question': 'Which tool or language are you most comfortable with?',
      'category': 'skills',
      'options': [
        {'text': 'HTML/CSS', 'score': 1, 'category': 'frontend'},
        {'text': 'Python', 'score': 1, 'category': 'data'},
        {'text': 'SQL', 'score': 1, 'category': 'data'},
        {'text': 'Figma', 'score': 1, 'category': 'uiux'},
        {'text': 'Dart/Flutter', 'score': 1, 'category': 'mobile'},
      ],
    },
    {
      'id': 'q3',
      'question': 'What motivates you the most?',
      'category': 'motivation',
      'options': [
        {'text': 'Creating visually appealing designs', 'score': 1, 'category': 'uiux'},
        {'text': 'Solving real-world data problems', 'score': 1, 'category': 'data'},
        {'text': 'Developing applications from scratch', 'score': 1, 'category': 'programming'},
        {'text': 'Making apps accessible across devices', 'score': 1, 'category': 'mobile'},
        {'text': 'Building smart, AI-driven systems', 'score': 1, 'category': 'ai'},
      ],
    },
    {
      'id': 'q4',
      'question': 'Which soft skill best describes you?',
      'category': 'personality',
      'options': [
        {'text': 'Attention to detail', 'score': 1, 'category': 'uiux'},
        {'text': 'Analytical thinking', 'score': 1, 'category': 'data'},
        {'text': 'Empathy with users', 'score': 1, 'category': 'uiux'},
        {'text': 'Creativity', 'score': 1, 'category': 'design'},
        {'text': 'Persistence in debugging', 'score': 1, 'category': 'programming'},
      ],
    },
    {
      'id': 'q5',
      'question': 'Which task sounds most exciting to you?',
      'category': 'preferences',
      'options': [
        {'text': 'Designing wireframes and prototypes', 'score': 1, 'category': 'uiux'},
        {'text': 'Training machine learning models', 'score': 1, 'category': 'ai'},
        {'text': 'Optimizing backend performance', 'score': 1, 'category': 'backend'},
        {'text': 'Building dashboards with charts', 'score': 1, 'category': 'data'},
        {'text': 'Developing Android/iOS apps', 'score': 1, 'category': 'mobile'},
      ],
    },
    {
      'id': 'q6',
      'question': 'How comfortable are you with math and statistics?',
      'category': 'skills',
      'options': [
        {'text': 'Very comfortable', 'score': 1, 'category': 'data'},
        {'text': 'Somewhat comfortable', 'score': 0.5, 'category': 'data'},
        {'text': 'Not comfortable', 'score': 0, 'category': 'data'},
      ],
    },
    {
      'id': 'q7',
      'question': 'Do you enjoy working on team-based projects?',
      'category': 'personality',
      'options': [
        {'text': 'Yes', 'score': 1, 'category': 'teamwork'},
        {'text': 'Sometimes', 'score': 0.5, 'category': 'teamwork'},
        {'text': 'No', 'score': 0, 'category': 'teamwork'},
      ],
    },
    {
      'id': 'q8',
      'question': 'Which environment do you prefer working in?',
      'category': 'preferences',
      'options': [
        {'text': 'Design tools', 'score': 1, 'category': 'uiux'},
        {'text': 'Terminal and code editor', 'score': 1, 'category': 'programming'},
        {'text': 'Spreadsheet and data tools', 'score': 1, 'category': 'data'},
        {'text': 'App builders like Flutter', 'score': 1, 'category': 'mobile'},
      ],
    },
    {
      'id': 'q9',
      'question': 'Which of these would you rather do in your free time?',
      'category': 'interests',
      'options': [
        {'text': 'Design logos', 'score': 1, 'category': 'design'},
        {'text': 'Build a chatbot', 'score': 1, 'category': 'ai'},
        {'text': 'Make a mobile app', 'score': 1, 'category': 'mobile'},
        {'text': 'Visualize data', 'score': 1, 'category': 'data'},
      ],
    },
    {
      'id': 'q10',
      'question': 'Are you more interested in front-end or back-end development?',
      'category': 'preferences',
      'options': [
        {'text': 'Front-end', 'score': 1, 'category': 'frontend'},
        {'text': 'Back-end', 'score': 1, 'category': 'backend'},
        {'text': 'Both', 'score': 1, 'category': 'fullstack'},
        {'text': 'Neither', 'score': 0, 'category': 'other'},
      ],
    },
  ];

  final Map<String, Map<String, dynamic>?> answers = {};

  @override
  void initState() {
    super.initState();
    // Initialize answers map with null values for each question
    for (var question in questions) {
      answers[question['id']] = null;
    }
  }

  void updateAnswer(String key, Map<String, dynamic>? value) {
    setState(() {
      answers[key] = value;
    });
  }

  bool get allQuestionsAnswered {
    return answers.values.every((answer) => answer != null);
  }

  Future<void> _submitAssessment() async {
    if (!allQuestionsAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please answer all questions before submitting'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Authentication required. Please login again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Prepare answers in the required format
      final answersList = answers.entries.map((entry) {
        final question = questions.firstWhere((q) => q['id'] == entry.key);
        final selectedOption = entry.value;
        return {
          'question': question['question'],
          'answer': selectedOption?['text'],
          'category': selectedOption?['category'] ?? question['category'],
          'score': selectedOption?['score'] ?? 1,
        };
      }).toList();
      final response = await http.post(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/assessment/submit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'answers': answersList,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Assessment submitted successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Request career suggestion after submission
        final suggestionResponse = await http.get(
          Uri.parse('https://skillsync-backend-production.up.railway.app/api/assessment/suggest'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (suggestionResponse.statusCode == 200) {
          final suggestion = jsonDecode(suggestionResponse.body);
          Navigator.pushNamed(
            context,
            '/assessment/results',
            arguments: suggestion,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to get suggestion: ${suggestionResponse.body}'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit assessment: ${response.statusCode} - ${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting assessment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                      ...questions.map((question) => Column(
                        children: [
                          _buildDropdownQuestion(
                            key: question['id'],
                            question: question['question'],
                            category: question['category'],
                            options: question['options'],
                            hint: 'Select your answer',
                          ),
                          const SizedBox(height: 20),
                        ],
                      )),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: GestureDetector(
                  onTap: _submitAssessment,
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
    required String category,
    required List<Map<String, dynamic>> options,
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
            child: DropdownButtonFormField<Map<String, dynamic>>(
              value: answers[key],
              onChanged: (value) => updateAnswer(key, value),
              items: options
                  .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option['text']),
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
  List<dynamic> careerSuggestions = [];
  bool isLoading = true;
  String errorMessage = '';
  Map<String, bool> expandedStates = {};

  @override
  void initState() {
    super.initState();
    _fetchAssessmentResults();
  }

  Future<void> _fetchAssessmentResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'Authentication required. Please login again.';
        });
        return;
      }

      final response = await http.get(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/assessment/results'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          careerSuggestions = data['careerSuggestions'] ?? [];
          // Initialize expanded states
          for (var career in careerSuggestions) {
            expandedStates[career['careerName']] = false;
          }
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load results: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching results: $e';
      });
    }
  }

  void _toggleExpand(String careerName) {
    setState(() {
      expandedStates[careerName] = !(expandedStates[careerName] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
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
                    color: const Color(0xFF01497C),
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
                onTap: () => Navigator.pop(context),
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
                    color: const Color(0xFF01497C),
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
              right: 24,
              bottom: 20,
              child: _buildResultsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsContent() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF01497C),
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          errorMessage,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (careerSuggestions.isEmpty) {
      return const Center(
        child: Text(
          'No career suggestions available',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ...careerSuggestions.map((career) => _buildCareerSuggestionCard(career)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCareerSuggestionCard(Map<String, dynamic> career) {
    final careerName = career['careerName'] ?? 'Unknown Career';
    final skills = List<Map<String, dynamic>>.from(career['skills'] ?? []);
    final isExpanded = expandedStates[careerName] ?? false;

    return Column(
      children: [
        Container(
          width: 327,
          height: 57,
          decoration: BoxDecoration(
            color: const Color(0xFFC0D2DE),
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
                    Navigator.pushNamed(
                      context,
                      '/career_roadmap',
                      arguments: {
                        'careerName': careerName,
                        'skills': skills,
                      },
                    );
                  },
                  child: Text(
                    careerName.toUpperCase(),
                    style: const TextStyle(
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
                  onTap: () => _toggleExpand(careerName),
                  behavior: HitTestBehavior.opaque,
                  child: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isExpanded)
          Container(
            width: 327,
            decoration: BoxDecoration(
              color: const Color(0xFF01497C),
              borderRadius: const BorderRadius.only(
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
                ...skills.map((skill) => _buildSkillProgress(skill)),
                const SizedBox(height: 8),
              ],
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSkillProgress(Map<String, dynamic> skill) {
    final skillName = skill['skillName'] ?? 'Unknown Skill';
    final progress = (skill['proficiency'] ?? 0.0).toDouble();
    final progressPercentage = (progress * 100).round();

    return Container(
      width: 327,
      height: 80,
      margin: const EdgeInsets.only(top: 8),
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
              skillName,
              style: const TextStyle(
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
                      value: progress,
                      backgroundColor: const Color(0xFFD9D9D9),
                      valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF024372)),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$progressPercentage%',
                    style: const TextStyle(
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
    );
  }
}