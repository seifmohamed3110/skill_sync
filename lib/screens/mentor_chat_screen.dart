import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MentorChatScreen());
}

class MentorChatScreen extends StatelessWidget {
  const MentorChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Interface',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hi Bill, I just finished the Python basics course you recommended!",
      isSent: true,
      isFile: false,
    ),
    ChatMessage(
      text: "That's great to hear! How did you find it?",
      isSent: false,
      isFile: false,
    ),
    ChatMessage(
      text: "It was pretty good. I understood most of it, but I'm still a bit confused about functions and when to use them.",
      isSent: true,
      isFile: false,
    ),
    ChatMessage(
      text: "Totally normal—functions can be tricky at first. Want to do a quick walkthrough together this week?",
      isSent: false,
      isFile: false,
    ),
  ];

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: _messageController.text,
        isSent: true,
        isFile: false,
      ));
      _messageController.clear();
    });

    // Simulate received message after a delay
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _messages.add(ChatMessage(
          text: "Thanks for your message! I'll get back to you soon.",
          isSent: false,
          isFile: false));
    });
  }

  Future<void> _sendFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _messages.add(ChatMessage(
          text: file.path,
          isSent: true,
          isFile: true,
        ));
      });

      // Simulate received file after a delay
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _messages.add(ChatMessage(
          text: "https://example.com/sample_file.pdf",
          isSent: false,
          isFile: true,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.06, 1],
          ),
        ),
        child: Column(
          children: [
            // Header section
            _buildHeader(context),
            // Date divider
            _buildDateDivider(),
            // Chat messages
            Expanded(
              child: ListView.builder(
                reverse: false, // Changed to false to display messages in correct order
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return message.isFile
                      ? _buildFileMessage(message.text, message.isSent, context)
                      : message.isSent
                      ? _buildSentMessage(message.text, EdgeInsets.only(
                    top: 8,
                    bottom: index == _messages.length - 1 ? 16 : 8,
                  ), context)
                      : _buildReceivedMessage(message.text, EdgeInsets.only(
                    top: 8,
                    bottom: index == _messages.length - 1 ? 16 : 8,
                  ), context);
                },
              ),
            ),
            // Input section
            _buildInputSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF195A88)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 8),
          const Text(
            'Bill Johnson',
            style: TextStyle(
              color: Color(0xFF195A88),
              fontSize: 26,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              fontFamily: 'Roboto',
            ),
          ),
          const Spacer(),
          Container(
            width: 54,
            height: 52,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                  'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=680bd5f0-eadd-433c-9776-c093d5c82493',
                ),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                width: 1.3,
                color: Colors.white,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.black.withOpacity(0.5),
              thickness: 1,
              indent: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Today',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontSize: 14,
                letterSpacing: 2.8,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black.withOpacity(0.5),
              thickness: 1,
              endIndent: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(String text, EdgeInsets padding, BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEFEF),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF0071A0)),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF0071A0),
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSentMessage(String text, EdgeInsets padding, BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF61A5C2),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.all(12),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileMessage(String filePath, bool isSent, BuildContext context) {
    final isLocalFile = filePath.startsWith('/');
    final fileName = isLocalFile ? filePath.split('/').last : filePath.split('/').last;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            // Handle file opening here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Opening file: $fileName')),
            );
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isSent ? const Color(0xFF61A5C2) : const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(14),
              border: isSent ? null : Border.all(color: const Color(0xFF0071A0)),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.insert_drive_file,
                  color: isSent ? Colors.white : const Color(0xFF0071A0),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    fileName,
                    style: TextStyle(
                      color: isSent ? Colors.white : const Color(0xFF0071A0),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xBF000000)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.white),
              onPressed: _sendFile,
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: Color(0x7FFFFFFF),
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSent;
  final bool isFile;

  ChatMessage({
    required this.text,
    required this.isSent,
    required this.isFile,
  });
}