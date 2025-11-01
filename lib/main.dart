import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_travel_alarm/features/onboarding/presentation/screens/oboarding_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs= await SharedPreferences.getInstance();
  final showOnboarding=prefs.getBool('onboarding_done') ?? true;



  runApp(MyApp(showOnboarding: showOnboarding,));
  
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OboardingScreen(),
    debugShowCheckedModeBanner: false,
    );
  }
}