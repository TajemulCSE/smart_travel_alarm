import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_travel_alarm/features/home/presentation/pages/alarm_list_widget.dart';
import 'package:smart_travel_alarm/helpers/locations/location_utils.dart';
import 'package:smart_travel_alarm/helpers/notifications/notification_helper.dart';
import 'package:smart_travel_alarm/helpers/permissions/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PermissionHandler _permissionHandler = PermissionHandler();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setCurrentLocation(); // Automatically fetch location on screen load
  }

  Future<void> _setCurrentLocation() async {
    final status = await _permissionHandler.checkAndRequestPermission();
    if (status != LocationPermissionStatus.granted) return;

    try {
      Position position = await _permissionHandler.getCurrentLocation();
      String address =
          await LocationUtils.getAddressFromCoordinates(position);

      // Set the address to the TextField
      _locationController.text = address;
    } catch (e) {
      _locationController.text = "Error fetching location";
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
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

                  // Location TextField
                  Container(
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B0F39),
                      borderRadius: BorderRadius.circular(61),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: _locationController,
                          readOnly: true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'popins',
                          ),
                          decoration: const InputDecoration(
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

            const SizedBox(height: 20),
            const Expanded(child: AlarmListWidget()),
          ],
        ),
      ),
    );
  }
}
