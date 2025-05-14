import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Data Models
class Mentor {
  final String name;
  final String avatarUrl;
  final String lastMessage;
  final String lastMessageTime;
  final String ratingIcon;
  final double rating;
  final String specialtyIcon;

  Mentor({
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.ratingIcon,
    required this.rating,
    required this.specialtyIcon,
  });
}

// App Text Styles
class AppTextStyles {
  static const screenTitle = TextStyle(
    color: Color(0xFF01497C),
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.7,
    fontFamily: 'Roboto',
  );

  static const mentorName = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.7,
    fontFamily: 'Roboto',
  );

  static const lastMessageTime = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    fontFamily: 'Roboto',
  );

  static const lastMessage = TextStyle(
    color: Color(0x84000000),
    fontSize: 14,
    letterSpacing: 0.4,
    fontFamily: 'Roboto',
  );

  static const trialsLeft = TextStyle(
    color: Colors.redAccent,
    fontSize: 14,
    fontFamily: 'Hind',
  );

  static const suggestedTitle = TextStyle(
    color: Color(0xFF01497C),
    fontSize: 24,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.7,
    fontFamily: 'Roboto',
  );

  static const premiumBanner = TextStyle(
    color: Color(0xFFE8D92F),
    fontSize: 30,
    height: 2,
    fontFamily: 'CantoraOne',
  );
}

// App Colors
class AppColors {
  static const primaryBlue = Color(0xFF01497C);
  static const gradientStart = Color(0xFFEFEFEF);
  static const gradientEnd = Color(0xFF61A5C2);
  static const searchBackground = Color(0xEDFAFAFA);
  static const premiumBanner = Color(0xFF01497C);
  static const premiumText = Color(0xFFE8D92F);
  static const mentorCard = Color(0x14827BEB);
}

// State Management
class ChatProvider extends ChangeNotifier {
  final Map<String, int> _trialCounts = {
    'Bill Johnson': 2,
    'Jenny Albert': 1,
  };

  String _searchQuery = '';

  Map<String, int> get trialCounts => _trialCounts;
  String get searchQuery => _searchQuery;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void decreaseTrial(String mentorName) {
    if (_trialCounts.containsKey(mentorName)) {
      _trialCounts[mentorName] = (_trialCounts[mentorName] ?? 1) - 1;
      notifyListeners();
    }
  }
}

// Reusable Widgets
class MentorContactItem extends StatelessWidget {
  final Mentor mentor;
  final int trialsLeft;
  final VoidCallback onTap;
  final bool isDisabled;

  const MentorContactItem({
    super.key,
    required this.mentor,
    required this.trialsLeft,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              const SizedBox(width: 20),
              Expanded(child: _buildMentorInfo()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(mentor.avatarUrl),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          width: 1.3,
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(35),
      ),
    );
  }

  Widget _buildMentorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(mentor.name, style: AppTextStyles.mentorName),
            Text(mentor.lastMessageTime, style: AppTextStyles.lastMessageTime),
          ],
        ),
        Text(mentor.lastMessage, style: AppTextStyles.lastMessage),
        const SizedBox(height: 5),
        Row(
          children: [
            Image.network(
              mentor.specialtyIcon,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 5),
            Text(
              '$trialsLeft ${trialsLeft == 1 ? 'Trial Left' : 'Trials Left'}',
              style: AppTextStyles.trialsLeft.copyWith(
                color: isDisabled ? Colors.grey : Colors.redAccent.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SuggestedMentorCard extends StatelessWidget {
  final Mentor mentor;

  const SuggestedMentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Image.network(
            mentor.avatarUrl,
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
                mentor.name,
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
                  color: AppColors.mentorCard,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      mentor.ratingIcon,
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      mentor.rating.toString(),
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

// Main Screen
class MentorChatListScreen extends StatelessWidget {
  const MentorChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mentors = [
      Mentor(
        name: 'Bill Johnson',
        avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcc50743bb7f21efb92ab09d47d56bdb6f5735a9duser-image.png?alt=media&token=7ba65971-8567-4c47-9079-61fc39b72f06',
        lastMessage: 'Please fill out this form',
        lastMessageTime: '10:35',
        rating: 4.5,
        ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F06292275-af8f-4fc6-9b0b-8833e18e4b6f.png',
        specialtyIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F06292275-af8f-4fc6-9b0b-8833e18e4b6f.png',
      ),
      Mentor(
        name: 'Jenny Albert',
        avatarUrl: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F1890f748-f216-41a8-8bfd-70392b4780dd.png',
        lastMessage: 'Please fill out this form',
        lastMessageTime: '1:05',
        rating: 4.7,
        ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fbfd9aa95-6fdb-402f-9196-60b4cceeff34.png',
        specialtyIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fbfd9aa95-6fdb-402f-9196-60b4cceeff34.png',
      ),
    ];

    final suggestedMentors = [
      Mentor(
        name: 'Wade Warren',
        avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2F7ad7fbdfc39c0636354382cc5d9fdbdcd76403deEllipse%201096.png?alt=media&token=6a035928-6321-4063-8268-1bdef3a590b1',
        lastMessage: '',
        lastMessageTime: '',
        rating: 4.4,
        ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F272a54a2-bd75-4b83-8a5c-f8fc89504281.png',
        specialtyIcon: '',
      ),
      Mentor(
        name: 'Wade Warren',
        avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fffac021edff4dc80e8009d7fe41e58e4e2b8637eEllipse%201096.png?alt=media&token=a5750a6b-7f2f-4295-a7ab-d0073436f2ae',
        lastMessage: '',
        lastMessageTime: '',
        rating: 4.6,
        ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F27fd90d4-8257-44dc-9c57-fc8856c7d762.png',
        specialtyIcon: '',
      ),
      Mentor(
        name: 'Wade Warren',
        avatarUrl: 'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fa9a278bb3e072f4fb473e6805d99dbc2ca9f938aEllipse%201096.png?alt=media&token=a0dcc3d4-b418-4456-8f9f-cd8665c6f046',
        lastMessage: '',
        lastMessageTime: '',
        rating: 4.1,
        ratingIcon: 'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Fd5410e4c-76ab-4391-92e1-d0ccdadea1de.png',
        specialtyIcon: '',
      ),
    ];

    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
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
                _buildAppBar(context),
                const SizedBox(height: 20),
                _buildSearchBar(context),
                const SizedBox(height: 30),
                _buildMentorList(context, mentors),
                const SizedBox(height: 30),
                _buildSuggestedMentorsSection(suggestedMentors),
                const SizedBox(height: 30),
                _buildPremiumBanner(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Image.asset(
            'assets/back_arrow.png',
            width: 28,
            height: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(width: 20),
        const Text('Contact Mentor', style: AppTextStyles.screenTitle),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Container(
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.searchBackground,
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
          child: TextField(
            decoration: const InputDecoration(
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
            onChanged: (query) {
              chatProvider.setSearchQuery(query.toLowerCase());
            },
          ),
        );
      },
    );
  }

  Widget _buildMentorList(BuildContext context, List<Mentor> mentors) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        final filteredMentors = chatProvider.searchQuery.isEmpty
            ? mentors
            : mentors.where((mentor) =>
            mentor.name.toLowerCase().contains(chatProvider.searchQuery)).toList();

        return Column(
          children: filteredMentors.map((mentor) {
            final trialsLeft = chatProvider.trialCounts[mentor.name] ?? 0;
            return MentorContactItem(
              mentor: mentor,
              trialsLeft: trialsLeft,
              isDisabled: trialsLeft <= 0,
              onTap: () {
                if (trialsLeft > 0) {
                  chatProvider.decreaseTrial(mentor.name);
                  Navigator.pushNamed(context, '/mentor_chat', arguments: {
                    'mentorName': mentor.name,
                    'avatarUrl': mentor.avatarUrl,
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
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSuggestedMentorsSection(List<Mentor> suggestedMentors) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('Suggested for you:', style: AppTextStyles.suggestedTitle),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: suggestedMentors
              .map((mentor) => SuggestedMentorCard(mentor: mentor))
              .toList(),
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
      ],
    );
  }

  Widget _buildPremiumBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/get_premium'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.premiumBanner,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: AppTextStyles.premiumBanner,
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
    );
  }
}