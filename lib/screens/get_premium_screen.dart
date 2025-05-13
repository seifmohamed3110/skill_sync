import 'package:flutter/material.dart';
import 'dart:math' as math;

class PremiumFeaturesScreen extends StatelessWidget {
  const PremiumFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 812,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEFEFEF)],
          stops: [0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 75,
            top: 237,
            child: SizedBox(
              width: 251,
              height: 32,
            ),
          ),
          const Positioned(
            left: 55,
            top: 157,
            child: SizedBox(
              width: 268,
              height: 76,
              child: Text(
                'Unlock Premium Features',
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
            child: Transform.rotate(
              angle: 180 * math.pi / 180,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2F7737d917-d92a-490b-bbaf-548655825c67.png',
                width: 28,
                height: 28,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            left: 53,
            top: 694,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                'https://storage.googleapis.com/codeless-app.appspot.com/uploads%2Fimages%2F0RtgVWh8wVg1fysBxIg4%2Ff1451837-ed49-4a27-95bc-6b0a00547093.png',
                width: 270,
                height: 56,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Positioned(
            left: 121,
            top: 703,
            child: SizedBox(
              width: 135,
              height: 37,
              child: Text(
                'Purchase ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  height: 1.0,
                  fontFamily: 'CantoraOne',
                ),
              ),
            ),
          ),
          Positioned(
            left: 145,
            top: 60,
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fcab60b6fa0b126fbfce688d78510ad2b9c254ee3dollar%201.png?alt=media&token=8e84f8ca-8ac1-4deb-bd22-dd7410acd06b',
              width: 85,
              height: 85,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 50,
            top: 280,
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fe8f2902e70a8dc99c8049a83ba4786261dd0087dcheck%201.png?alt=media&token=96e301d7-3295-4a2f-bcb2-b0acd56a8e6a',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 50,
            top: 342,
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fe8f2902e70a8dc99c8049a83ba4786261dd0087dcheck%202.png?alt=media&token=47a8d3fb-1778-43cc-808b-3fdf440eb012',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 50,
            top: 404,
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2F0RtgVWh8wVg1fysBxIg4%2Fe8f2902e70a8dc99c8049a83ba4786261dd0087dcheck%203.png?alt=media&token=6e3f8af2-4d14-4e84-82f7-aed378fa5db7',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            left: 102,
            top: 288,
            child: Text(
              'Remove all ads',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                height: 0.8,
                fontFamily: 'CantorOne',
              ),
            ),
          ),
          const Positioned(
            left: 102,
            top: 350,
            child: Text(
              'Unlimited mentor chat',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                height: 0.8,
                fontFamily: 'CantoraOne',
              ),
            ),
          ),
          const Positioned(
            left: 102,
            top: 412,
            child: Text(
              'AI helping your CV editing',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                height: 0.8,
                fontFamily: 'CantoraOne',
              ),
            ),
          ),
          Positioned(
            left: 53,
            top: 604,
            child: Container(
              width: 270,
              height: 79,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 53,
            top: 516,
            child: Container(
              width: 270,
              height: 79,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const Positioned(
            left: 74,
            top: 614,
            child: Text(
              'Monthly Subscription',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 0.9,
                fontFamily: 'CantoraOne',
              ),
            ),
          ),
          const Positioned(
            left: 74,
            top: 525,
            child: Text(
              'Yearly Subscription',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 0.9,
                fontFamily: 'CantoraOne',
              ),
            ),
          ),
          const Positioned(
            left: 74,
            top: 552,
            child: Text(
              'get pro features for 9,99\$',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                height: 1.2,
                fontFamily: 'CantoraOne',
              ),
            ),
          ),
          const Positioned(
            left: 73,
            top: 640,
            child: Text(
              'get pro features for 0,99\$',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF352424),
                fontSize: 14,
                height: 1.2,
                fontFamily: 'CantoraOne',
              ),
            ),
          )
        ],
      ),
    );
  }
}