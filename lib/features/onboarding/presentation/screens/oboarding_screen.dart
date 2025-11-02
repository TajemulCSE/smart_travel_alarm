import 'package:flutter/material.dart';
import 'package:smart_travel_alarm/constants/app_colors.dart';
import 'package:smart_travel_alarm/features/location/presentation/screens/location_screen.dart';
import 'package:smart_travel_alarm/features/onboarding/presentation/pages/onboarding_page.dart';

class OboardingScreen extends StatefulWidget {
  const OboardingScreen({super.key});

  @override
  State<OboardingScreen> createState() => _OboardingScreenState();
}

class _OboardingScreenState extends State<OboardingScreen> {
  final PageController _controller = PageController();

  int currentIndex = 0;
  
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final pages = [
    {
      'video': 'assets/videos/onboarding_video_01.mp4',
      'title': 'Discover the world, one journey at a time.',
      'description': 'From hidden gems to iconic destinations, we make travel simple, inspiring, and unforgettable. Start your next adventure today.',
    },
    {
      'video': 'assets/videos/onboarding_video_02.mp4',
      'title': 'Explore new horizons, one step at a time.',
      'description': 'Every trip holds a story waiting to be lived. Let us guide you to experiences that inspire, connect, and last a lifetime.',
    },
    {
      'video': 'assets/videos/onboarding_video_03.mp4',
      'title': 'See the beauty, one journey at a time.',
      'description': 'Travel made simple and exciting—discover places you’ll love and moments you’ll never forget.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColors().bgcolor,

      body: SafeArea(
        child: Stack(
          children: [

            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) => setState(() => currentIndex = index),

              itemBuilder: (_, index) => OnboardingPage(
                videoPath: pages[index]['video']!,
                title: pages[index]['title']!,
                description: pages[index]['description']!,
              ),
            ),

               // Skip button
            Positioned(
              top: 16,
              right: 16,
              child: TextButton(
                onPressed:()
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LocationScreen()));

                } 
                ,
                child: const Text("Skip", style: TextStyle(color: Colors.white,
                fontFamily: 'oxygen',
                fontWeight: FontWeight.w700,
                fontSize: 15)),
              ),
            ),

              
              // Dots indicator
            Positioned(
              bottom: 150,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 12 : 8,
                    height: currentIndex == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Color(0xFF5200FF)
                          : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),

 //next Button
            Positioned(
              bottom: 65,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5200FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  if (currentIndex < pages.length - 1) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LocationScreen()));
                  }
                },
                child: Text(
                   'Next',
                  style: const TextStyle(fontSize: 14,
                  fontFamily: 'ozygen',
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
