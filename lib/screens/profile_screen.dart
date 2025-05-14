import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  final String _defaultImageUrl =
      'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=298640e5-92c3-49bd-96ba-fb7a48c37b58';

  // Profile data controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
    _loadProfileData();
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');

    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('profile_name') ?? 'Bill Johnson';
      _emailController.text = prefs.getString('profile_email') ?? 'bill@johnson';
      _phoneController.text = prefs.getString('profile_phone') ?? '+01 234 567 89';
    });
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', _nameController.text);
    await prefs.setString('profile_email', _emailController.text);
    await prefs.setString('profile_phone', _phoneController.text);
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
        final appDir = await getApplicationDocumentsDirectory();
        final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

        await _saveImagePath(savedImage.path);

        setState(() {
          _selectedImage = savedImage;
        });
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });

    if (!_isEditing) {
      _saveProfileData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
      // Return updated data to the previous screen
      Navigator.pop(context, {
        'name': _nameController.text,
        'imagePath': _selectedImage?.path,
      });
    }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 10),
                _buildProfilePictureSection(),
                _isEditing ? _buildEditProfileSection() : _buildUserInfoSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.edit,
                        title: _isEditing ? 'Save Profile' : 'Edit Profile',
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
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                                (route) => false,
                          );
                        },
                        style: menuItemTextStyle.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
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
          const SizedBox(height: 15),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
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
            '${_emailController.text} | ${_phoneController.text}',
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

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}