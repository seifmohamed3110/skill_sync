import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResumeCheckScreen extends StatefulWidget {
  const ResumeCheckScreen({Key? key}) : super(key: key);

  @override
  State<ResumeCheckScreen> createState() => _ResumeCheckScreenState();
}

class _ResumeCheckScreenState extends State<ResumeCheckScreen> {
  Map<String, dynamic>? analysisData;
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchResumeAnalysis();
  }

  Future<void> fetchResumeAnalysis() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        setState(() {
          error = 'No authentication token found. Please log in.';
          isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/resume/analysis'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          analysisData = jsonDecode(response.body)['extracted'];
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load analysis: ${response.body}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Widget buildSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text("• $item", style: const TextStyle(fontSize: 16, color: Colors.black)),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resume Feedback")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error.isNotEmpty
          ? Center(child: Text(error))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (analysisData != null)
              ...[
                if (analysisData!['skills'] != null)
                  buildSection("Skills", List<String>.from(analysisData!['skills'])),
                if (analysisData!['jobTitles'] != null)
                  buildSection("Job Titles", List<String>.from(analysisData!['jobTitles'])),
                if (analysisData!['organizations'] != null)
                  buildSection("Organizations", List<String>.from(analysisData!['organizations'])),
                if (analysisData!['suggestions'] != null)
                  buildSection("Suggestions", List<String>.from(analysisData!['suggestions'])),
              ]
          ],
        ),
      ),
    );
  }
}