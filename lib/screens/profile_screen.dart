import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings & Profile',
          style: GoogleFonts.cantoraOne(),
        ),
        backgroundColor: const Color(0xFF2196F3),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2196F3), Color(0xFFBBDEFB)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Seif Mohamed',
                  style: GoogleFonts.cantoraOne(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              _buildSettingsTile(Icons.edit, 'Edit Profile', () {
                // Implement navigation or edit profile logic
              }),
              _buildSettingsTile(Icons.lock_outline, 'Change Password', () {
                // Implement password change logic
              }),
              _buildSettingsTile(Icons.notifications_none, 'Notifications', () {
                // Navigate to notifications settings
              }),
              _buildSettingsTile(Icons.language, 'Language', () {
                // Show language picker
              }),
              _buildSettingsTile(Icons.logout, 'Logout', () {
                // Add logout logic
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: GoogleFonts.cantoraOne()),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
