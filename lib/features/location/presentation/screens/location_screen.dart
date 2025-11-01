import 'package:flutter/material.dart';
import 'package:smart_travel_alarm/features/home/presentation/screens/home_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0024), Color(0xFF082257)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            //welcome text
            Positioned(
              top: 70,
              left: 16,
              right: 16,

              child: Text(
                "Welcome! Your Smart Travel Alarm",
                textAlign: TextAlign.center,
                style: TextStyle(
    
                  color: Colors.white,
                  fontSize: 34,
                  fontFamily: 'popins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            

            //describtion
           
            Positioned(
              top: 190,
              left: 30,
              right: 35,

              child: Text(
                "Stay on schedule and enjoy every moment of your journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'popins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            Positioned(
              top: 330,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 280,

                child: Image.asset('assets/images/location_1.png'),
              ),
            ),
            //location button
            Positioned(
              bottom: 150,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                 
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Use Current Location',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Popins',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                    Image.asset('assets/icons/location.png', height: 24),
                  ],
                ),
              ),
            ),

            //home button
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text(
                  'Home',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Popins',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
