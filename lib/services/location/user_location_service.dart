import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? position;

  Future<Position?> accessCurrentLocation(
      {required BuildContext context}) async {
    /// get if the gps is enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }
    LocationPermission? permission = await Geolocator.checkPermission();

    /// check user permission status

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
    /// get lat and lng of user

    position = await Geolocator.getCurrentPosition();

    return position;
  }
  /// get place information from coordinates

  Future<Placemark?> getMyLocationInfo() async {
    if (position != null) {
      List<Placemark?> placeMarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);

      return placeMarks[0];
    }
    return null;
  }
}
