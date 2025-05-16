import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentortHomePageScreen extends StatefulWidget {
  const MentortHomePageScreen({super.key});

  @override
  State<MentortHomePageScreen> createState() => _MentortHomePageScreenState();
}

class _MentortHomePageScreenState extends State<MentortHomePageScreen> {
  bool assessmentDone = false;
  String userName = 'Rohan';
  File? profileImage;
  final String _defaultImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=558c6ac5-1b80-4dd6-bb4a-3455eadf5304';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('profile_name') ?? 'Rohan';
      final imagePath = prefs.getString('profile_image_path');
      if (imagePath != null && File(imagePath).existsSync()) {
        profileImage = File(imagePath);
      }
    });
  }

  void updateAssessmentStatus(bool done) {
    setState(() {
      assessmentDone = done;
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            stops: [0.06, 1],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi $userName,',
                    style: const TextStyle(
                      color: Color(0xFF01497C),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.pushNamed(context, '/profile');
                      if (result != null && result is Map) {
                        setState(() {
                          userName = result['name'] ?? userName;
                          if (result['imagePath'] != null) {
                            profileImage = File(result['imagePath']);
                          }
                        });
                      }
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: profileImage != null
                                  ? FileImage(profileImage!) as ImageProvider
                                  : NetworkImage(_defaultImageUrl),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(width: 1.3, color: Colors.white),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Positioned(
                          right: -5,
                          bottom: -5,
                          child: Image.network(
                            'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F9da00e62-99c5-44d3-9fac-1456c151a67e.png',
                            width: 12,
                            height: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xEDFAFAFA),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 15),
                    Icon(Icons.search, color: Color(0x993C3C43), size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Color(0x993C3C43),
                        fontSize: 17,
                        fontFamily: 'SF Pro Text',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/mentor_chat_list'),
                child: SizedBox(
                  height: 166,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child: Image.asset(
                          'assets/contact.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Colors.transparent],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(21),
                              bottomRight: Radius.circular(21),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 24,
                        bottom: 20,
                        child: Text(
                          'CONTACT MENTOR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CantoraOne',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCard(
                    assetPath: 'assets/uploadresume.png',
                    label: 'UPLOAD RESUME',
                    width: 171,
                    onTap: () {
                      Navigator.pushNamed(context, '/upload_resume');
                    },
                  ),
                  buildCard(
                    assetPath: 'assets/take_assessment.png',
                    label: 'TAKE ASSESSMENT',
                    width: 169,
                    onTap: () async {
                      final result =
                      await Navigator.pushNamed(context, '/assessment');
                      if (result == true) {
                        updateAssessmentStatus(true);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (assessmentDone) ...[
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      '/frontend_roadmap',
                      arguments: 'front-end developer',
                    );
                    if (result == true) {
                      updateAssessmentStatus(true);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOUR CAREER PROGRESS',
                          style: GoogleFonts.cantoraOne(
                            color: const Color(0xFF01497C),
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Progress: 50% - front-end developer track',
                          style: GoogleFonts.cantoraOne(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: const Color(0xFFEFEFEF),
                          color: const Color(0xFF61A5C2),
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.black,
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 74,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: buildBottomIcon(Icons.home, 'Home', isActive: true),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/frontend_roadmap',
                          arguments: 'front-end developer',
                        );
                        if (result == true) {
                          updateAssessmentStatus(true);
                        }
                      },
                      child: buildBottomIcon(Icons.map, 'Roadmap', isActive: false),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard({
    required String assetPath,
    required String label,
    required double width,
    required VoidCallback onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  assetPath,
                  width: width,
                  height: 111,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: width,
                height: 40,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: GoogleFonts.cantoraOne(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomIcon(IconData icon, String label,
      {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF01497C) : Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFF01497C) : Colors.grey,
          ),
        )
      ],
    );
  }
}