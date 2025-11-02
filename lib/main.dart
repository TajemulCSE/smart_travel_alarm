import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_travel_alarm/features/home/presentation/screens/home_screen.dart';
import 'package:smart_travel_alarm/features/location/presentation/screens/location_screen.dart';
import 'package:smart_travel_alarm/features/onboarding/presentation/screens/oboarding_screen.dart';
import 'package:smart_travel_alarm/helpers/notifications/notification_helper.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();
  tz.initializeTimeZones();
  
  // Request runtime notification permission (Android 13+)
  final status = await Permission.notification.request();
  if (status.isGranted) {
    print('Notification permission granted');
  } else {
    print('Notification permission denied');
  }

  final prefs = await SharedPreferences.getInstance();
  // If 'onboarding_done' is null (first time), show onboarding (false)
  // If it's true, skip onboarding
  final hasSeenOnboarding = prefs.getBool('onboarding_done') ?? false;

  runApp(MyApp(hasSeenOnboarding: hasSeenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: hasSeenOnboarding ? LocationScreen() : OboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}