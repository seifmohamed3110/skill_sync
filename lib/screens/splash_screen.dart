import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to first welcome screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'first');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xFF3A85A5), Color(0xFFEFEFEF)],
            stops: [0.01, 1],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',  // Ensure this path is correct
            width: 190,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
