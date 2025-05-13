import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerRoadmapScreen extends StatelessWidget {
  final String chosenCareer;
  final double progress;

  final Map<String, List<String>> careerMilestones = {
    'Front-End Developer': [
      'Learn HTML & CSS',
      'Understand JavaScript Basics',
      'Master Flexbox and Grid',
      'Learn React.js',
      'Build a Portfolio Website',
      'Deploy on GitHub Pages',
    ],
    'Back-End Developer': [
      'Learn Server-Side Language',
      'Understand Databases',
      'Learn API Development',
      'Master Authentication',
      'Learn Deployment',
      'Build a Complete Project',
    ],
    // Add more career paths as needed
  };

  CareerRoadmapScreen({
    super.key,
    required this.chosenCareer,
    this.progress = 0.0, // Default to 0% if not provided
  });

  @override
  Widget build(BuildContext context) {
    final milestones = careerMilestones[chosenCareer] ?? [
      'No milestones defined for this career path'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF01497C),
        title: Text(
          'Roadmap',
          style: GoogleFonts.cantoraOne(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Career title
              Text(
                chosenCareer,
                style: GoogleFonts.cantoraOne(
                  fontSize: 26,
                  color: const Color(0xFF01497C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Progress
              Text(
                'Progress: ${(progress * 100).toInt()}%',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.white,
                color: const Color(0xFF01497C),
                borderRadius: BorderRadius.circular(5),
              ),

              const SizedBox(height: 30),

              // Milestones
              Text(
                'Your Learning Roadmap',
                style: GoogleFonts.cantoraOne(
                  fontSize: 20,
                  color: const Color(0xFF01497C),
                ),
              ),
              const SizedBox(height: 10),

              Column(
                children: milestones
                    .asMap()
                    .entries
                    .map(
                      (entry) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF61A5C2),
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        entry.value,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: entry.key < (progress * milestones.length).floor()
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.check_circle_outline),
                    ),
                  ),
                )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}