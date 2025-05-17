import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class UploadResumeScreen extends StatefulWidget {
  const UploadResumeScreen({super.key});

  @override
  State<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends State<UploadResumeScreen> {
  PlatformFile? _selectedFile;
  bool _isFileUploaded = false;
  bool _showSuccessMessage = false;

  Future<void> _uploadFile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token'); // make sure you stored it after login

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in')),
        );
        return;
      }

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = result.files.first;
        });

        // Add file extension validation
        final extension = _selectedFile!.extension?.toLowerCase();
        if (extension != 'pdf' && extension != 'docx') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Only PDF and DOCX files are allowed')),
          );
          setState(() {
            _selectedFile = null; // Clear the selected file if invalid
          });
          return;
        }

        // Backend API call
        final url = Uri.parse(
          'https://skillsync-backend-production.up.railway.app/api/resume/upload',
        );

        // Determine MIME type based on file extension
        final mimeType = _selectedFile!.extension == 'pdf'
            ? 'application/pdf'
            : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

        var request = http.MultipartRequest('POST', url);
        request.headers['Authorization'] = 'Bearer $token';
        request.files.add(
          await http.MultipartFile.fromPath(
            'resume',
            _selectedFile!.path!,
            filename: _selectedFile!.name,
            contentType: MediaType.parse(mimeType),
          ),
        );

        final response = await request.send();

        if (response.statusCode == 200) {
          setState(() {
            _isFileUploaded = true;
            _showSuccessMessage = true;
          });

          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _showSuccessMessage = false;
              });
            }
          });
        } else {
          final respStr = await response.stream.bytesToString();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: $respStr')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: ${e.toString()}')),
      );
    }
  }

  void _checkResume() {
    if (_selectedFile != null) {
      Navigator.pushNamed(context,  '/resume_check');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a resume first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 375,
        height: 812,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 375,
                  height: 812,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(32),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.06, 1],
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
                                    'Upload Resume',
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
                        left: 6,
                        top: 182,
                        child: SizedBox(
                          width: 268,
                          height: 76,
                          child: Text(
                            'Choose Your File',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF01497C),
                              fontSize: 32,
                              fontFamily: 'CantoraOne',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 33,
                        top: 73,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            'assets/back_arrow.png',
                            width: 28,
                            height: 28,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 31,
                        top: 277,
                        child: GestureDetector(
                          onTap: _uploadFile,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fe13f4f9e-58ae-4b87-915b-ef2d068f1683.png',
                              width: 170,
                              height: 71,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 49,
                        top: 294,
                        child: GestureDetector(
                          onTap: _uploadFile,
                          child: const SizedBox(
                            width: 135,
                            height: 37,
                            child: Text(
                              'Upload here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                height: 1.6,
                                fontFamily: 'CantoraOne',
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_isFileUploaded)
                        Positioned(
                          left: 83,
                          top: 558,
                          child: GestureDetector(
                            onTap: _checkResume,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F17761198-9535-41b0-aa26-63323655bd5e.png',
                                width: 209,
                                height: 71,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      if (_isFileUploaded)
                        const Positioned(
                          left: 111,
                          top: 575,
                          child: SizedBox(
                            width: 154,
                            height: 37,
                            child: Text(
                              'Check Resume',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                height: 0.7,
                                fontFamily: 'CantoraOne',
                              ),
                            ),
                          ),
                        ),
                      if (_showSuccessMessage && _selectedFile != null)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              "Your file '${_selectedFile!.name}'\nhas been uploaded successfully.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}