import 'package:geolocator/geolocator.dart';

enum LocationPermissionStatus {
  granted,
  serviceDisabled,
  denied,
  deniedForever,
}

class PermissionHandler {
  /// Checks and requests location permissions.
  /// Returns a detailed status based on the result.
  Future<LocationPermissionStatus> checkAndRequestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if location services are enabled on the device
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationPermissionStatus.serviceDisabled;
    }

    // 2. Check current permission status
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // 3. Request permission if currently denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationPermissionStatus.denied;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 4. Handle permanent denial
      return LocationPermissionStatus.deniedForever;
    }
    
    // 5. Permission is granted (or was just granted)
    return LocationPermissionStatus.granted;
  }

  /// Attempts to get the current location coordinates.
  /// Should only be called after permission is verified as granted.
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Opens the app settings if permission was permanently denied.
  Future<bool> openSettings() async {
    return await Geolocator.openAppSettings();
  }
}