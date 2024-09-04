import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as MyLocation;
import 'dart:math'; // Import the math library

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  String currentAddress = "My Address";
  Position? currentPosition;
  bool isCheckedIn = false;
  final MyLocation.Location _locationService = MyLocation.Location();

  // Defined check-in location
  final double checkInLatitude = 28.6338828;
  final double checkInLongitude = 77.4470319;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Please Keep Your location on");
      return; // Exit the function if location services are not enabled
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission is denied");
        return; // Exit the function if permission is denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "permission is denied forever");
      return; // Exit the function if permission is denied forever
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;

      setState(() {
        currentPosition = position;
currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";        isCheckedIn = _checkCheckInStatus(position.latitude, position.longitude);
      });
    } catch (e) {
      print(e);
    }
  }

  bool _checkCheckInStatus(double userLatitude, double userLongitude) {
    const double earthRadius = 6371000.0; // Earth's radius in meters

    double latDiff = (userLatitude - checkInLatitude)*(pi/180);
    double lngDiff = (userLongitude - checkInLongitude)*(pi/180);

    double a = sin(latDiff / 2) * sin(latDiff / 2) +
        cos(userLatitude*(pi/180)) * cos(checkInLatitude*(pi/180)) *
            sin(lngDiff / 2) * sin(lngDiff / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance <= 3; // Check if distance is within 50 meters
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Geo location")),
      body: Center(
        child: Column(children: [
          Text(currentAddress, style: const TextStyle(fontSize: 20)),
          if (currentPosition != null) Text("Latitude: ${currentPosition!.latitude}"),
          if (currentPosition != null) Text("Longitude: ${currentPosition!.longitude}"),
          Text(isCheckedIn ? "Checked In" : "Not Checked In"),
          TextButton(
              onPressed: () {
                _determinePosition();
              },
              child: const Text("Locate Me"))
        ]),
      ),
    );
  }
}