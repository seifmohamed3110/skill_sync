import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  Map<String, int> trialCounts = {
    'Bill Johnson': 2,
    'Jenny Albert': 1,
  };

  void decreaseTrial(String mentorName) {
    if (trialCounts.containsKey(mentorName) && trialCounts[mentorName]! > 0) {
      trialCounts[mentorName] = trialCounts[mentorName]! - 1;
      notifyListeners();
    }
  }
}

class MentorChatListScreen extends StatelessWidget {
  const MentorChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: Scaffold(
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
                Row(
                  children: [
                    IconButton(
                      icon: Image.network(
                        'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F86c7b72f-d5b3-4dc6-bd94-d7d4a86acd47.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 20),
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
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xEDFAFAFA),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        spreadRadius: 0,
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Color(0x993C3C43),
                        fontSize: 17,
                        height: 1.3,
                        fontFamily: 'SF Pro Text',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Bill Johnson's contact - now clickable
                Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    final trialsLeft = chatProvider.trialCounts['Bill Johnson'] ?? 0;
                    return InkWell(
                      onTap: () {
                        if (trialsLeft > 0) {
                          chatProvider.decreaseTrial('Bill Johnson');
                          Navigator.pushNamed(context, '/mentor_chat', arguments: {
                            'mentorName': 'Bill Johnson',
                            'avatarUrl': 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=7ba65971-8567-4c47-9079-61fc39b72f06',
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No trials left for this mentor'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: _buildContactItem(
                        avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=7ba65971-8567-4c47-9079-61fc39b72f06',
                        name: 'Bill Johnson',
                        message: 'Please fill out this form',
                        time: '10:35',
                        trialsLeft: '$trialsLeft ${trialsLeft == 1 ? 'Trial Left' : 'Trials Left'}',
                        iconUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F06292275-af8f-4fc6-9b0b-8833e18e4b6f.png',
                        isDisabled: trialsLeft <= 0,
                      ),
                    );
                  },
                ),

                // Jenny Albert's contact
                Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    final trialsLeft = chatProvider.trialCounts['Jenny Albert'] ?? 0;
                    return InkWell(
                      onTap: () {
                        if (trialsLeft > 0) {
                          chatProvider.decreaseTrial('Jenny Albert');
                          Navigator.pushNamed(context, '/mentor_chat', arguments: {
                            'mentorName': 'Jenny Albert',
                            'avatarUrl': 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F1890f748-f216-41a8-8bfd-70392b4780dd.png',
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('No trials left for this mentor'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: _buildContactItem(
                        avatarUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F1890f748-f216-41a8-8bfd-70392b4780dd.png',
                        name: 'Jenny Albert',
                        message: 'Please fill out this form',
                        time: '1:05',
                        trialsLeft: '$trialsLeft ${trialsLeft == 1 ? 'Trial Left' : 'Trials Left'}',
                        iconUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fbfd9aa95-6fdb-402f-9196-60b4cceeff34.png',
                        isDisabled: trialsLeft <= 0,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Suggested for you:',
                    style: TextStyle(
                      color: Color(0xFF01497C),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.7,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Suggested Mentors
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSuggestedMentor(
                      avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2F7ad7fbdfc39c0636354382cc5d9fdbdcd76403deEllipse%201096.png?alt=media&token=6a035928-6321-4063-8268-1bdef3a590b1',
                      name: 'Wade Warren',
                      rating: '4.4',
                      ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F272a54a2-bd75-4b83-8a5c-f8fc89504281.png',
                    ),
                    _buildSuggestedMentor(
                      avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fffac021edff4dc80e8009d7fe41e58e4e2b8637eEllipse%201096.png?alt=media&token=a5750a6b-7f2f-4295-a7ab-d0073436f2ae',
                      name: 'Wade Warren',
                      rating: '4.6',
                      ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F27fd90d4-8257-44dc-9c57-fc8856c7d762.png',
                    ),
                    _buildSuggestedMentor(
                      avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fa9a278bb3e072f4fb473e6805d99dbc2ca9f938aEllipse%201096.png?alt=media&token=a0dcc3d4-b418-4456-8f9f-cd8665c6f046',
                      name: 'Wade Warren',
                      rating: '4.1',
                      ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fd5410e4c-76ab-4391-92e1-d0ccdadea1de.png',
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Text(
                  'View All',
                  style: GoogleFonts.getFont(
                    'Hind',
                    color: const Color(0xFF154883),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),

                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/get_premium');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF01497C),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          color: Color(0xFFE8D92F),
                          fontSize: 30,
                          height: 2,
                          fontFamily: 'CantoraOne',
                        ),
                        children: [
                          TextSpan(text: 'Get Premium Features '),
                          TextSpan(
                            text: 'Now!!',
                            style: TextStyle(
                              fontSize: 64,
                              height: 0.9,
                            ),
                          )
                        ],
                      ),
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

  Widget _buildContactItem({
    required String avatarUrl,
    required String name,
    required String message,
    required String time,
    required String trialsLeft,
    required String iconUrl,
    bool isDisabled = false,
  }) {
    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 1.3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Text(
                        time,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Color(0x84000000),
                      fontSize: 14,
                      letterSpacing: 0.4,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Image.network(
                        iconUrl,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        trialsLeft,
                        style: GoogleFonts.getFont(
                          'Hind',
                          color: isDisabled ? Colors.grey : Colors.redAccent.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedMentor({
    required String avatarUrl,
    required String name,
    required String rating,
    required String ratingIcon,
  }) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Image.network(
            avatarUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFE7EFFC),
                spreadRadius: 0,
                offset: Offset(2, 2),
                blurRadius: 16,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.getFont(
                  'Hind',
                  color: const Color(0xB21D1F24),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Mentor',
                style: TextStyle(
                  color: Color(0xFF1D1F24),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x14827BEB),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      ratingIcon,
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      rating,
                      style: const TextStyle(
                        color: Color(0xFF1D1F24),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}