import 'package:flutter/material.dart';

class MentorChatListScreen extends StatefulWidget {
  const MentorChatListScreen({super.key});

  @override
  State<MentorChatListScreen> createState() => _MentorChatListScreenState();
}

class _MentorChatListScreenState extends State<MentorChatListScreen> {
  bool requestAccepted = false;
  bool isLoading = false;

  Future<void> sendRequest() async {
    setState(() {
      isLoading = true;
    });

    // Simulate network request delay (2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
      requestAccepted = true;
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
            colors: [Color(0xFFEFEFEF), Color(0xFF61A5C2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.06, 1],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Header with back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF01497C)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Contact Mentor',
                    style: TextStyle(
                      color: Color(0xFF01497C),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Status indicator
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF01497C),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Text(
                  requestAccepted
                      ? 'Accepted Request'
                      : isLoading
                      ? 'Sending Request...'
                      : 'Pending Request',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: requestAccepted
                        ? const Color(0xFF08FF25)
                        : isLoading
                        ? Colors.white
                        : Colors.yellow,
                    fontSize: 24,
                    fontFamily: 'CantoraOne',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Mentor card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF01497C),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Mentor image
                    Container(
                      width: 196,
                      height: 196,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=da321552-3135-4331-87db-e50b91d2a3b3',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Mentor name
                    const Text(
                      'Bill Johnson',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.9,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Status message
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        requestAccepted
                            ? 'Your request is accepted\nyou can chat with mentor now.'
                            : isLoading
                            ? 'Sending your request\nto the mentor...'
                            : 'Your request is pending\nwaiting for mentor to accept.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 0.6,
                          fontFamily: 'CantoraOne',
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Conditional button based on request status
                    if (requestAccepted)
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to chat screen
                          Navigator.pushNamed(context, '/mentor_chat');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8EB0BF),
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Start Chatting Now',
                          style: TextStyle(
                            color: Color(0xFF01497C),
                            fontSize: 20,
                            fontFamily: 'CantoraOne',
                          ),
                        ),
                      )
                    else if (!isLoading)
                      ElevatedButton(
                        onPressed: sendRequest,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8EB0BF),
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Send Request',
                          style: TextStyle(
                            color: Color(0xFF01497C),
                            fontSize: 20,
                            fontFamily: 'CantoraOne',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Loading message with container - appears only when sending request
              if (isLoading)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF01497C),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: const Text(
                    'REQUEST YOU NEED\nIS LOADING ... WAIT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 0.9,
                      fontFamily: 'CantoraOne',
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              // Reset button for demo purposes
              if (requestAccepted)
                TextButton(
                  onPressed: () {
                    setState(() {
                      requestAccepted = false;
                    });
                  },
                  child: const Text(
                    'Reset Request',
                    style: TextStyle(
                      color: Color(0xFF01497C),
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}