import 'package:geolocator/geolocator.dart';

class LocationException implements Exception {
  final String message;

  LocationException(this.message);

  @override
  String toString() => message;
}

class LocationService {
  static Future<Position> determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException(
        'Location services are disabled. Please enable GPS on your device.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw LocationException(
        'Location permission denied. Please allow location access to use offline navigation.',
      );
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        'Location permission denied forever. Open device settings and allow location access.',
      );
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }
}
