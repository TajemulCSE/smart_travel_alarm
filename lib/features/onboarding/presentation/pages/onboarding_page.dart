import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnboardingPage extends StatefulWidget {
  final String videoPath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.videoPath,
    required this.title,
    required this.description,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); // Refresh to show video
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
            SizedBox(
              height: 429,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(bottomRight: Radius.circular(32),bottomLeft:Radius.circular(30)),
                child: AspectRatio(aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
                ),  
              ),
            ),
           
      
            SizedBox(
              height: 10,
            ),
      
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.title,style: TextStyle(
                fontFamily: 'popins',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 34
              ),
              ),
            ),
      
            SizedBox(
              height: 15,
      
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.description,
              style: TextStyle(
                fontFamily: 'oxyzen',
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 14
              ),
              
              ),
            ),
      
      
      
            
        ],
      );
  }
}
