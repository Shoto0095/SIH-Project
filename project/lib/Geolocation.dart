import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as MyLocation;
import 'dart:math';

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  String currentAddress = "Location not determined";
  Position? currentPosition;
  bool isCheckedIn = false;
  final MyLocation.Location _locationService = MyLocation.Location();
  final double checkInLatitude = 28.6338828;
  final double checkInLongitude = 77.4470319;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: "Please Keep Your location on");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: "Location permission is denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: "Permission is denied forever");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;

      setState(() {
        currentPosition = position;
        currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
        isCheckedIn = _checkCheckInStatus(position.latitude, position.longitude);
      });

      print("Current Position: Lat: ${position.latitude}, Lng: ${position.longitude}");
      print("Distance to check-in location: ${_calculateDistance(position.latitude, position.longitude)} meters");
      print("Check-in status: ${isCheckedIn ? "Checked In" : "Not Checked In"}");

    } catch (e) {
      print(e);
    }
  }

  double _calculateDistance(double userLatitude, double userLongitude) {
    const double earthRadius = 6371000.0;

    double latDiff = (userLatitude - checkInLatitude) * (pi / 180);
    double lngDiff = (userLongitude - checkInLongitude) * (pi / 180);

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(userLatitude * (pi / 180)) * cos(checkInLatitude * (pi / 180)) *
            sin(lngDiff / 2) * sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;
    return distance;
  }

  bool _checkCheckInStatus(double userLatitude, double userLongitude) {
    double distance = _calculateDistance(userLatitude, userLongitude);
    print("Calculated Distance: $distance meters");
    return distance <= 50; // Increase the radius to 10 meters for testing
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geo Location Check-In"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentAddress,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (currentPosition != null)
              Text("Latitude: ${currentPosition!.latitude.toStringAsFixed(6)}",
                  style: const TextStyle(fontSize: 16)),
            if (currentPosition != null)
              Text("Longitude: ${currentPosition!.longitude.toStringAsFixed(6)}",
                  style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Text(
              isCheckedIn ? "Checked In" : "Not Checked In",
              style: TextStyle(
                  color: isCheckedIn ? Colors.green : Colors.red,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _determinePosition,
              child: const Text("Check My Location"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
