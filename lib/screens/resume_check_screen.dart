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
  String? error;
  String? token;

  final String backendUrl =
      'https://skillsync-backend-production.up.railway.app/api/resume/analysis';

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchAnalysis();
  }

  Future<void> _loadTokenAndFetchAnalysis() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedToken = prefs.getString('token');

      if (storedToken == null) {
        setState(() {
          error = 'No authentication token found';
          isLoading = false;
        });
        return;
      }

      setState(() {
        token = storedToken;
      });

      await _fetchAnalysis();
    } catch (e) {
      setState(() {
        error = 'Failed to load token: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Future<void> _fetchAnalysis() async {
    try {
      final response = await http.get(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/resume/analysis'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          analysisData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = jsonDecode(response.body)['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Failed to load analysis: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  Widget _buildSection(String title, List<dynamic> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF01497C))),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: items.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: const Color(0xFF61A5C2),
              labelStyle: const TextStyle(color: Colors.white),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Analysis'),
        backgroundColor: const Color(0xFF01497C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : error != null
            ? Center(child: Text(error!))
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Skills', analysisData?['skills'] ?? []),
              _buildSection('Organizations', analysisData?['organizations'] ?? []),
              _buildSection('Job Titles', analysisData?['jobTitles'] ?? []),
              _buildSection('Suggestions', analysisData?['suggestions'] ?? []),
            ],
          ),
        ),
      ),
    );
  }
}