import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  final String _defaultImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=298640e5-92c3-49bd-96ba-fb7a48c37b58';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isEditing = false;
  bool _isLoading = true;
  int _retryCount = 0;
  final int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _loadProfileData() async {
    final token = await _getToken();
    if (token == null) {
      await _logout();
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Try to get user data from available endpoints
      final response = await http.get(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/users/career'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          _nameController.text = responseData['user']['name'] ?? 'User';
          _emailController.text = responseData['user']['email'] ?? 'user@example.com';
          _isLoading = false;
        });
      } else {
        // Fallback to local storage
        await _loadLocalProfile();
      }
    } catch (e) {
      await _loadLocalProfile();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _loadLocalProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('local_name') ?? 'User';
      _emailController.text = prefs.getString('local_email') ?? 'user@example.com';
    });
  }

  Future<void> _saveProfile() async {
    final token = await _getToken();
    if (token == null) return;

    setState(() => _isLoading = true);

    try {
      // Try to save to backend
      final response = await http.put(
        Uri.parse('https://skillsync-backend-production.up.railway.app/api/users/career'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
        }),
      );

      // Always save locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('local_name', _nameController.text);
      await prefs.setString('local_email', _emailController.text);

      if (response.statusCode == 200) {
        _showSuccessDialog('Profile updated successfully');
      } else {
        _showSuccessDialog('Profile saved locally');
      }
    } catch (e) {
      _showSuccessDialog('Profile saved locally');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isEditing = false;
        });
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0071A0);
    const gradientColors = [Color(0xFFEFEFEF), Color(0xFF61A5C2)];
    const gradientStops = [0.06, 1.0];
    const menuItemTextStyle = TextStyle(
      color: primaryColor,
      fontSize: 20,
      height: 1.4,
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            stops: gradientStops,
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 10),
                _buildProfilePictureSection(),
                _isEditing ? _buildEditProfileSection() : _buildUserInfoSection(),
                _buildMenuItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 10),
          Text(
            'Settings & Profile',
            style: GoogleFonts.roboto(
              color: Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _isEditing ? _pickImage : null,
          child: Container(
            width: 133,
            height: 127,
            decoration: BoxDecoration(
              border: Border.all(width: 1.3, color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.elliptical(67, 64)),
            ),
            child: ClipOval(
              child: _selectedImage != null
                  ? Image.file(_selectedImage!, fit: BoxFit.cover)
                  : Image.network(
                _defaultImageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.person, size: 60),
              ),
            ),
          ),
        ),
        if (_isEditing)
          Positioned(
            right: 80,
            bottom: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(width: 5, color: Colors.white),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: const Icon(Icons.edit, color: Colors.black, size: 20),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEditProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          if (!_isLoading)
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0071A0),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            _nameController.text,
            style: GoogleFonts.poppins(
              color: const Color(0xFF0071A0),
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _emailController.text,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    const primaryColor = Color(0xFF0071A0);
    const menuItemTextStyle = TextStyle(
      color: primaryColor,
      fontSize: 20,
      height: 1.4,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.edit,
            title: _isEditing ? 'Cancel Editing' : 'Edit Profile',
            onTap: _toggleEditMode,
            style: menuItemTextStyle,
          ),
          const SizedBox(height: 15),
          _buildMenuItem(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {},
            style: menuItemTextStyle,
          ),
          const SizedBox(height: 15),
          _buildMenuItem(
            icon: Icons.language,
            title: 'Language',
            onTap: () {},
            style: menuItemTextStyle,
          ),
          const SizedBox(height: 15),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Log out',
            onTap: _logout,
            style: menuItemTextStyle.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required TextStyle style,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 57,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF0071A0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 20),
              Text(title, style: style),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.black87),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorDialog('Failed to pick image');
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('role');
    await prefs.remove('local_name');
    await prefs.remove('local_email');
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (route) => false,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}