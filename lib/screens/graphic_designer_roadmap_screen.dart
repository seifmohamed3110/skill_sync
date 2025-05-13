import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const GraphicDesignerRoadmapScreen());
}

class GraphicDesignerRoadmapScreen extends StatefulWidget {
  const GraphicDesignerRoadmapScreen({super.key});

  @override
  State<GraphicDesignerRoadmapScreen> createState() => _GraphicDesignerRoadmapScreenState();
}

class _GraphicDesignerRoadmapScreenState extends State<GraphicDesignerRoadmapScreen> {
  bool photoshopChecked = false;
  bool illustratorChecked = false;
  bool figmaChecked = false;

  double get progress {
    int completed = 0;
    if (photoshopChecked) completed++;
    if (illustratorChecked) completed++;
    if (figmaChecked) completed++;
    return completed / 3;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.06, 1],
            ),
          ),
          child: Center(
            child: Container(
              width: 375,
              height: 812,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
                  stops: [0.06, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
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
                                'Assessment Results',
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
                    left: 84,
                    top: 149,
                    child: Text(
                      'CAREER ROADMAP',
                      style: TextStyle(
                        color: Color(0xFF01497C),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 0.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 33,
                    top: 73,
                    child: Image.network(
                      'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F5078ba37-a7b2-42f5-b150-45ae2f9b3511.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 37,
                    top: 212,
                    child: Container(
                      width: 302,
                      height: 510,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF61A5C2), Color(0xFFEFEFEF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 93,
                    top: 393,
                    child: Text(
                      'Udemy: Adobe Photoshop Course',
                      style: TextStyle(
                        color: Color(0xD1003052),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 93,
                    top: 460,
                    child: Text(
                      'Udemy: Adobe Illustrator Course',
                      style: TextStyle(
                        color: Color(0xD1003052),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 93,
                    top: 522,
                    child: Text(
                      'Coursera: Figma Course',
                      style: TextStyle(
                        color: Color(0xD1003052),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 276,
                    top: 393,
                    child: Text(
                      '= 3 weeks',
                      style: TextStyle(
                        color: Color(0xD1003052),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 276,
                    top: 460,
                    child: Text(
                      '= 3 weeks',
                      style: TextStyle(
                        color: Color(0xD1003052),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 276,
                    top: 522,
                    child: Text(
                      '= 1 month',
                      style: TextStyle(
                        color: Color(0xD1003052),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 93,
                    top: 369,
                    child: Text(
                      'Photoshop',
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
                    left: 93,
                    top: 438,
                    child: Text(
                      'Illustrator',
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
                    left: 93,
                    top: 502,
                    child: Text(
                      'Figma',
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
                    left: 67,
                    top: 627,
                    child: Text(
                      'UX DESIGNER',
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
                    left: 67,
                    top: 656,
                    child: Text(
                      'Photo Editor',
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
                    left: 55,
                    top: 301,
                    child: Text(
                      'Graphic Designer',
                      style: TextStyle(
                        color: Color(0xFF01497C),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 0.5,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 135,
                    top: 226,
                    child: Text(
                      'Current progress:',
                      style: TextStyle(
                        color: Color(0xFF003052),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 67,
                    top: 570,
                    child: Text(
                      'ALTERNATIVE PATHS',
                      style: TextStyle(
                        color: Color(0xFF003052),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 0.8,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 68,
                    top: 256,
                    child: Container(
                      width: 240,
                      height: 13,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 68,
                    top: 256,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        width: 240 * progress,
                        height: 13,
                        color: const Color(0xFF01497C),
                      ),
                    ),
                  ),
                  // Vertical connecting line
                  Positioned(
                    left: 68.5,
                    top: 379,
                    child: Container(
                      width: 2,
                      height: 70,
                      color: const Color(0xFF01497C),
                    ),
                  ),
                  // Photoshop Checkbox (1)
                  Positioned(
                    left: 58,
                    top: 368,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          photoshopChecked = !photoshopChecked;
                        });
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: photoshopChecked ? const Color(0xFF01497C) : const Color(0xFFEDEEEE),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: const Color(0xFF01497C),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '1',
                            style: GoogleFonts.getFont(
                              'Cantora One',
                              color: photoshopChecked ? Colors.white : const Color(0xFF01497C),
                              fontSize: 16,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Illustrator Checkbox (2)
                  Positioned(
                    left: 58,
                    top: 437,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          illustratorChecked = !illustratorChecked;
                        });
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: illustratorChecked ? const Color(0xFF01497C) : const Color(0xFFEDEEEE),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: const Color(0xFF01497C),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: GoogleFonts.getFont(
                              'Cantora One',
                              color: illustratorChecked ? Colors.white : const Color(0xFF01497C),
                              fontSize: 16,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Vertical connecting line between 2 and 3
                  Positioned(
                    left: 68.5,
                    top: 459,
                    child: Container(
                      width: 2,
                      height: 55,
                      color: const Color(0xFF01497C),
                    ),
                  ),
                  // Figma Checkbox (3)
                  Positioned(
                    left: 58,
                    top: 501,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          figmaChecked = !figmaChecked;
                        });
                      },
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: figmaChecked ? const Color(0xFF01497C) : const Color(0xFFEDEEEE),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: const Color(0xFF01497C),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '3',
                            style: GoogleFonts.getFont(
                              'Cantora One',
                              color: figmaChecked ? Colors.white : const Color(0xFF01497C),
                              fontSize: 16,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 188,
                    top: 417,
                    child: Image.network(
                      'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F9d06a657-d127-4640-9e55-5ad84a46c075.png',
                      width: 0,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}