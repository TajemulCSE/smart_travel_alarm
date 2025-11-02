import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:smart_travel_alarm/features/home/presentation/screens/home_screen.dart';
import 'package:smart_travel_alarm/helpers/permissions/permission_handler.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final PermissionHandler _permissionHandler = PermissionHandler();
  final TextEditingController _locationController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  /// Converts coordinates to a human-readable address
  static Future<String> getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
      } else {
        return "Address not available";
      }
    } catch (e) {
      return "Error getting address: $e";
    }
  }

  /// Handles permission, gets location, and converts to address
  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final status = await _permissionHandler.checkAndRequestPermission();

    if (status == LocationPermissionStatus.granted) {
      try {
        final position = await _permissionHandler.getCurrentLocation();
        final address = await getAddressFromCoordinates(position);

        setState(() {
          _locationController.text = address;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Error getting location: $e';
        });
      }
    } else if (status == LocationPermissionStatus.serviceDisabled) {
      setState(() {
        _errorMessage = 'Location services are disabled. Please enable them.';
      });
    } else if (status == LocationPermissionStatus.deniedForever) {
      setState(() {
        _errorMessage =
            'Permission permanently denied. Please open app settings.';
      });
      await _permissionHandler.openSettings();
    } else {
      setState(() {
        _errorMessage = 'Location permission denied.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

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
        child: Stack(
          children: [
            // Welcome text
            const Positioned(
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

            // Description
            const Positioned(
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

            // Location image
            Positioned(
              top: 270,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 280,
                child: Image.asset('assets/images/location_1.png'),
              ),
            ),

            // Location TextField
            Positioned(
              bottom: 230,
              left: 16,
              right: 16,
              child: TextField(
                controller: _locationController,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Your current location will appear here',
                  hintStyle: const TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),

            // Use Current Location button
            Positioned(
              bottom: 150,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _isLoading ? null : _getLocation,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Use Current Location',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Popins',
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Image.asset('assets/icons/location.png', height: 24),
                        ],
                      ),
              ),
            ),

            // Home button
            Positioned(
              bottom: 65,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5200FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Popins',
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Error message
            if (_errorMessage != null)
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
