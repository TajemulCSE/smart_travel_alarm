import 'package:flutter/material.dart';
import 'package:smart_travel_alarm/features/home/presentation/pages/alarm_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0024), Color(0xFF082257)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Selected Location",
                    style: TextStyle(
                      fontFamily: 'popins',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),

                  //location text field
                  Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B0F39),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: 'popins',
                          ),
                          decoration: InputDecoration(
                            prefixIcon: ImageIcon(
                              AssetImage('assets/icons/location_1.png'),
                              color: Colors.white70,
                            ),
                            hintText: 'Add your location',
                            hintStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 18,
                              fontFamily: 'popins',
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //alarm list
            const SizedBox(height: 20),
            const Expanded(child: AlarmListWidget()),
          ],
        ),
      ),
    );
  }
}
