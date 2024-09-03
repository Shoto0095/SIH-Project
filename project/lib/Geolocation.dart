import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  String currentAddress = "My Address";
  Position? currentPosition;

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Please enable location services");
      return; // Exit the function if location services are disabled
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: "Location permission denied");
        return; // Exit the function if permission remains denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Location permission denied forever");
      return; // Exit the function if permission is denied forever
    }

    try {
      // Get current position with high accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode the position to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks.first;

      // Update state with retrieved address and position
      setState(() {
        currentPosition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e); // Log any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Geolocation"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              currentAddress,
              style: const TextStyle(fontSize: 20),
            ),
            if (currentPosition != null) Text("Latitude: ${currentPosition!.latitude}"),
            if (currentPosition != null) Text("Longitude: ${currentPosition!.longitude}"),
            TextButton(
              onPressed: _determinePosition,
              child: const Text("Locate Me"),
            ),
          ],
        ),
      ),
    );
  }
}