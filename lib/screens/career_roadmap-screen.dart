import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CareerCourse {
  final String title;
  final String url;

  CareerCourse({required this.title, required this.url});

  factory CareerCourse.fromJson(Map<String, dynamic> json) {
    return CareerCourse(
      title: json['title'],
      url: json['url'],
    );
  }
}

class CareerCourses {
  static final Map<String, List<CareerCourse>> courses = {
    "Frontend Developer": [
      CareerCourse(
          title: "The Odin Project", url: "https://www.theodinproject.com/"),
      CareerCourse(
          title: "HTML, CSS, JS Crash Course",
          url: "https://www.youtube.com/watch?v=UB1O30fR-EE"),
    ],
    "Backend Developer": [
      CareerCourse(
          title: "Node.js & Express Course",
          url: "https://www.youtube.com/watch?v=Oe421EPjeBE"),
      CareerCourse(
          title: "MongoDB Basics", url: "https://university.mongodb.com/"),
    ],
    "Full Stack Developer": [
      CareerCourse(
          title: "Full Stack Open", url: "https://fullstackopen.com/"),
      CareerCourse(
          title: "MERN Stack Course",
          url: "https://www.udemy.com/course/mern-stack/"),
    ],
    "Data Analyst": [
      CareerCourse(
          title: "Google Data Analytics",
          url:
          "https://www.coursera.org/professional-certificates/google-data-analytics"),
      CareerCourse(
          title: "SQL for Data Science",
          url: "https://www.coursera.org/learn/sql-for-data-science"),
    ],
    "BI Analyst": [
      CareerCourse(
          title: "Power BI Essentials",
          url: "https://learn.microsoft.com/en-us/training/powerplatform/"),
      CareerCourse(
          title: "Data Visualization with Tableau",
          url: "https://www.coursera.org/learn/data-visualization"),
    ],
    "AI/ML Engineer": [
      CareerCourse(
          title: "TensorFlow in Practice",
          url:
          "https://www.coursera.org/specializations/tensorflow-in-practice"),
      CareerCourse(
          title: "Scikit-Learn Crash Course",
          url: "https://scikit-learn.org/stable/tutorial/index.html"),
    ],
    "Data Scientist": [
      CareerCourse(
          title: "IBM Data Science Professional",
          url:
          "https://www.coursera.org/professional-certificates/ibm-data-science"),
      CareerCourse(title: "Kaggle Learn", url: "https://www.kaggle.com/learn"),
    ],
    "Mobile App Developer": [
      CareerCourse(
          title: "Flutter & Firebase Bootcamp",
          url: "https://www.udemy.com/course/flutter-bootcamp-with-dart/"),
    ],
    "Flutter Developer": [
      CareerCourse(
          title: "Google Flutter Codelabs",
          url: "https://flutter.dev/docs/codelabs"),
    ],
    "UI/UX Designer": [
      CareerCourse(
          title: "Figma Tutorial",
          url: "https://www.youtube.com/watch?v=FTFaQWZBqQ8"),
    ],
    "Product Designer": [
      CareerCourse(
          title: "Designing for Product Teams",
          url: "https://www.interaction-design.org/"),
    ],
    "DevOps Engineer": [
      CareerCourse(
          title: "Docker for Beginners",
          url: "https://docker-curriculum.com/"),
      CareerCourse(
          title: "CI/CD Pipeline Setup",
          url: "https://www.youtube.com/watch?v=1w3tNO3ArfE"),
    ],
    "Cloud Architect": [
      CareerCourse(
          title: "AWS Cloud Practitioner", url: "https://www.aws.training/"),
    ],
    "Cybersecurity Analyst": [
      CareerCourse(
          title: "Intro to Cybersecurity",
          url: "https://www.coursera.org/learn/intro-cyber-security"),
    ],
    "Security Engineer": [
      CareerCourse(
          title: "Penetration Testing & Ethical Hacking",
          url: "https://www.udemy.com/course/penetration-testing/"),
    ],
  };
}

class RoadmapProgressScreen extends StatefulWidget {
  final String careerName;
  final List<dynamic> skills;

  const RoadmapProgressScreen({
    super.key,
    required this.careerName,
    required this.skills,
  });

  @override
  State<RoadmapProgressScreen> createState() => _RoadmapProgressScreenState();
}

class _RoadmapProgressScreenState extends State<RoadmapProgressScreen> with SingleTickerProviderStateMixin {
  List<String> roadmapSteps = [];
  bool isLoading = true;
  String errorMessage = '';
  String debugInfo = '';
  List<CareerCourse> careerCourses = [];
  List<dynamic> courseList = [];
  Set<int> completedSteps = {};

  // Animation controller for progress bar
  late AnimationController _animationController;
  final Map<String, Animation<double>> _progressAnimations = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fetchRoadmapSteps();
    _loadCareerCourses();
    _fetchCourses();
    _loadCompletedSteps();
    _initProgressAnimations();

    debugInfo = 'Career Name: ${widget.careerName}\n'
        'Available Career Keys: ${CareerCourses.courses.keys.join(', ')}';
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _initProgressAnimations() {
    for (var skill in widget.skills) {
      final skillId = skill['_id'] ?? skill['skillName'];
      final initialProgress = (skill['proficiency'] ?? 0.0).toDouble();
      _progressAnimations[skillId] = Tween<double>(
        begin: initialProgress,
        end: initialProgress,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }
  }

  void _updateProgressAnimations(double increment) {
    for (var skill in widget.skills) {
      final skillId = skill['_id'] ?? skill['skillName'];
      final currentProficiency = (skill['proficiency'] ?? 0.0).toDouble();
      final newProficiency = (currentProficiency + increment).clamp(0.0, 1.0);

      _progressAnimations[skillId] = Tween<double>(
        begin: currentProficiency,
        end: newProficiency,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
    }

    // Reset and start the animation
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> _loadCompletedSteps() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList('completed_steps_${widget.careerName}') ?? [];
    setState(() {
      completedSteps = completed.map((e) => int.parse(e)).toSet();
    });
  }

  Future<void> _saveCompletedSteps() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'completed_steps_${widget.careerName}',
      completedSteps.map((e) => e.toString()).toList(),
    );
  }

  Future<void> _fetchCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(
          'https://skillsync-backend-production.up.railway.app/api/courses'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        courseList = data['courses'];
      });
    } else {
      print('Failed to fetch courses: ${response.body}');
    }
  }

  Future<void> _updateSkillProgress(double increment) async {
    try {
      // Update the animations first for a smooth visual transition
      _updateProgressAnimations(increment);

      // Then update local state with the new values
      setState(() {
        for (var skill in widget.skills) {
          final currentProficiency = (skill['proficiency'] ?? 0.0).toDouble();
          skill['proficiency'] = (currentProficiency + increment).clamp(0.0, 1.0);
        }
      });

      // Check if we're using a backend API
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        try {
          // Create updated skills list with new proficiency values
          final updatedSkills = widget.skills.map((skill) {
            return {
              'skillId': skill['_id'], // Assuming each skill has an _id field
              'skillName': skill['skillName'],
              'proficiency': skill['proficiency'],
            };
          }).toList();

          // Try the original endpoint first
          var response = await http.post(
            Uri.parse('https://skillsync-backend-production.up.railway.app/api/update-skills'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'skills': updatedSkills,
            }),
          );

          // If original endpoint fails, try the alternative endpoint
          if (response.statusCode == 404) {
            response = await http.post(
              Uri.parse('https://skillsync-backend-production.up.railway.app/api/skills/update'),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json',
              },
              body: jsonEncode({
                'skills': updatedSkills,
              }),
            );
          }

          // If both endpoints fail, we'll still save the local progress
          // This makes the app usable even if the backend is unavailable
          if (response.statusCode != 200) {
            print('Backend API failed with status code: ${response.statusCode}');
            print('Response body: ${response.body}');
          }
        } catch (apiError) {
          // Log the error but don't throw - we still want to save local progress
          print('API error: $apiError');
        }
      }

      // Always save the completed steps locally
      await _saveCompletedSteps();

    } catch (e) {
      // If there's an error, show a message and revert the animation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating progress: $e')),
      );

      // Revert the UI changes
      _updateProgressAnimations(-increment);
      setState(() {
        for (var skill in widget.skills) {
          final currentProficiency = (skill['proficiency'] ?? 0.0).toDouble();
          skill['proficiency'] = (currentProficiency - increment).clamp(0.0, 1.0);
        }
      });
    }
  }

  void _loadCareerCourses() {
    // Try to find exact match first
    var courses = CareerCourses.courses[widget.careerName];

    // If no exact match, try case-insensitive match
    if (courses == null) {
      final lowerCareerName = widget.careerName.toLowerCase();
      final matchingKey = CareerCourses.courses.keys.firstWhere(
            (key) => key.toLowerCase() == lowerCareerName,
        orElse: () => '',
      );

      if (matchingKey.isNotEmpty) {
        courses = CareerCourses.courses[matchingKey];
      }
    }

    // If still no match, try partial match
    if (courses == null) {
      final lowerCareerName = widget.careerName.toLowerCase();
      final matchingKey = CareerCourses.courses.keys.firstWhere(
            (key) => key.toLowerCase().contains(lowerCareerName) ||
            lowerCareerName.contains(key.toLowerCase()),
        orElse: () => '',
      );

      if (matchingKey.isNotEmpty) {
        courses = CareerCourses.courses[matchingKey];
      }
    }

    setState(() {
      careerCourses = courses ?? [];
      debugInfo += '\n\nMatched Courses for "${widget.careerName}": ${careerCourses.length}';
    });
  }

  Future<void> _fetchRoadmapSteps() async {
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
        Uri.parse(
            'https://skillsync-backend-production.up.railway.app/api/roadmap'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final steps = List<String>.from(data['steps'] ?? []);
        setState(() {
          roadmapSteps = steps;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load roadmap: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching roadmap: $e';
      });
    }
  }

  Widget _buildSkillProgress(Map<String, dynamic> skill) {
    final skillName = skill['skillName'] ?? 'Unknown Skill';
    final skillId = skill['_id'] ?? skillName;

    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final progress = _progressAnimations.containsKey(skillId)
              ? _progressAnimations[skillId]!.value
              : (skill['proficiency'] ?? 0.0).toDouble();
          final progressPercentage = (progress * 100).round();

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skillName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                          minHeight: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$progressPercentage%',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildRoadmapStep(String step, int index) {
    final isCompleted = completedSteps.contains(index);

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async {
            // Calculate how much to increment each skill
            // If there are many steps, make smaller increments
            final totalSteps = roadmapSteps.length;
            final increment = isCompleted ? -1.0 / totalSteps : 1.0 / totalSteps;

            // First update the UI optimistically
            setState(() {
              if (isCompleted) {
                completedSteps.remove(index);
              } else {
                completedSteps.add(index);
              }
            });

            // Show visual feedback
            if (!isCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Step completed! Progress updated.'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 1),
                ),
              );
            }

            // Update the skills progress
            await _updateSkillProgress(increment);
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCompleted ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? Colors.green : Colors.white,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : Icons.circle_outlined,
                    size: 20,
                    color: isCompleted ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    step,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCompleted ? FontWeight.normal : FontWeight.w500,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                      color: isCompleted ? Colors.grey : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseItem(CareerCourse course) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.school, color: Colors.blue),
        ),
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          course.url,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.open_in_new),
        onTap: () async {
          final uri = Uri.parse(course.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not launch ${course.url}')),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.careerName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Debug Information'),
                  content: SingleChildScrollView(child: Text(debugInfo)),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const SizedBox(height: kToolbarHeight + 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Your Skill Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.skills
                          .map((skill) => _buildSkillProgress(skill))
                          .toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Roadmap Steps',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Complete ${completedSteps.length} of ${roadmapSteps.length} steps",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: roadmapSteps.isEmpty
                            ? 0
                            : completedSteps.length / roadmapSteps.length,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 16),
                      ...roadmapSteps.asMap().entries.map((entry) =>
                          _buildRoadmapStep(entry.value, entry.key)
                      ).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Recommended Courses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (careerCourses.isEmpty)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'No recommended courses found for this career path',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                )
              else
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: careerCourses.map(_buildCourseItem).toList(),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}