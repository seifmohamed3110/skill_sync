import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'screens/first_welcome_screen.dart';
import 'screens/second_welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/forget_password_screen.dart';
import 'screens/student_homepage_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/mentor_chat_screen.dart';
import 'screens/upload_resume_screen.dart';
import 'screens/assessment_screen.dart';
import 'screens/forntend_roadmap_screen.dart';
import 'screens/graphic_designer_roadmap_screen.dart';
import 'screens/career_roadmap-screen.dart'; // Make sure this import points to your RoadmapProgressScreen
import 'screens/get_premium_screen.dart';
import 'screens/mentor_chat_list_screen.dart';
import 'screens/resume_check_screen.dart';
import 'screens/mentor_homepage_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/first': (context) => FirstWelcomeScreen(),
        '/second': (context) => const SecondWelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forget_password': (context) => ForgetPasswordScreen(),
        '/student_home': (context) => StudentHomePageScreen(),
        '/mentor_chat_list': (context) => MentorChatListScreen(),
        '/mentor_chat': (context) => MentorChatScreen(),
        '/profile': (context) => ProfileScreen(),
        '/assessment': (context) => AssessmentScreen(),
        '/assessment/questions': (context) => const AssessmentQuestionsScreen(),
        '/assessment/results': (context) => AssessmentResultsScreen(),
        '/upload_resume': (context) => UploadResumeScreen(),
        '/resume_check': (context) => const ResumeCheckScreen(),
        '/frontend_roadmap': (context) => FrontendRoadmapScreen(),
        '/grahic_designer_roadmap': (context) => GraphicDesignerRoadmapScreen(),
        '/get_premium': (context) => PremiumFeaturesScreen(),
        '/mentor_home': (context) => MentortHomePageScreen(),
        '/career_roadmap': (context) {
          // Enhanced argument handling with type checking and fallbacks
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args is Map<String, dynamic>) {
            return RoadmapProgressScreen(
              careerName: args['careerName']?.toString() ?? 'Unknown Career',
              skills: args['skills'] is List ? List<dynamic>.from(args['skills']) : [],
            );
          } else {
            // Fallback if arguments are not provided
            return const RoadmapProgressScreen(
              careerName: 'Unknown Career',
              skills: [],
            );
          }
        },
      },
      // Add a fallback for unknown routes
      onGenerateRoute: (settings) {
        // You could return a "Route not found" screen here
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('Route ${settings.name} not found')),
          ),
        );
      },
    );
  }
}