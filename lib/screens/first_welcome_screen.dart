import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstWelcomeScreen extends StatefulWidget {
  const FirstWelcomeScreen({super.key});

  @override
  State<FirstWelcomeScreen> createState() => _FirstWelcomeScreenState();
}

class _FirstWelcomeScreenState extends State<FirstWelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _buttonAnimation;
  late Animation<Color?> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo animation (fade + scale)
    _logoAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOutBack),
      ),
    );

    // Text animation (slide up + fade)
    _textAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutQuart),
      ),
    );

    // Button animation (bounce effect)
    _buttonAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Gradient color animation
    _gradientAnimation = ColorTween(
      begin: const Color(0xFF3A85A5).withOpacity(0.5),
      end: const Color(0xFF3A85A5),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  _gradientAnimation.value ?? const Color(0xFF3A85A5),
                  const Color(0xFFEFEFEF),
                ],
                stops: const [0.01, 1],
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Logo with animation
                Positioned(
                  left: 93,
                  top: screenHeight * 0.33,
                  child: FadeTransition(
                    opacity: _logoAnimation,
                    child: ScaleTransition(
                      scale: _logoAnimation,
                      child: Image.asset(
                        'assets/logo.png',
                        width: 190,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_outline, size: 50, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                // Text with animation
                Positioned(
                  left: 91,
                  top: screenHeight * 0.46,
                  child: FadeTransition(
                    opacity: _textAnimation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(_textAnimation),
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
                            shadows: [
                              Shadow(
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Button with animation
                Positioned(
                  left: screenWidth * 0.78,
                  top: screenHeight * 0.89,
                  child: FadeTransition(
                    opacity: _buttonAnimation,
                    child: ScaleTransition(
                      scale: _buttonAnimation,
                      child: GestureDetector(
                        onTap: () {
                          // Add button press animation
                          _controller.reset();
                          _controller.forward();

                          // Navigate after animation completes
                          Future.delayed(const Duration(milliseconds: 300), () {
                            Navigator.pushNamed(context, '/second');
                          });
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
                                  errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.arrow_forward, size: 24),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}