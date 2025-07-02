import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Constants for maintainability
  static const _logoLeftPosition = 93.0;
  static const _logoWidth = 190.0;
  static const _logoHeight = 100.0;
  static const _logoTopPercentage = 0.33;
  static const _splashDuration = Duration(seconds: 3);
  static const _animationDuration = Duration(milliseconds: 1500);

  final _gradientColors = const [
    Color(0xFF3A85A5),
    Color(0xFFEFEFEF),
  ];

  final _gradientStops = const [0.01, 1.0];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    // Configure fade animation
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    // Configure scale animation
    _scaleAnimation = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    // Start animation
    _controller.forward();

    // Check auth token after delay
    Future.delayed(_splashDuration, _checkTokenAndNavigate);
  }

  Future<void> _checkTokenAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken'); // Change key name if needed

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/student_home'); // User is logged in
    } else {
      Navigator.pushReplacementNamed(context, '/first'); // User not logged in
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: _gradientColors,
            stops: _gradientStops,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: _logoLeftPosition,
              top: screenHeight * _logoTopPercentage,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: Image.asset(
                  'assets/logo.png',
                  width: _logoWidth,
                  height: _logoHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error_outline, size: 50, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
