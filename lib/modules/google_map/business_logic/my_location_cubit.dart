import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../services/location/user_location_service.dart';
import 'my_location_state.dart';

class MyLocationCubit extends Cubit<MyLocationState> {
  MyLocationCubit() : super(GetLocationInitial());
  Placemark? placeMark;
  LatLng? latLng;

  /// get user location info with geolocator package
  Future<void> getMyLocationInfo({required BuildContext context}) async {
    LocationService locationService = LocationService();

    if (placeMark == null) {
      try {
        emit(GetLocationLoading());
        await locationService.accessCurrentLocation(context: context);
        placeMark = await locationService.getMyLocationInfo();
        latLng = LatLng(locationService.position?.latitude ?? 0.0,
            locationService.position?.longitude ?? 0.0);
        if (placeMark != null && context.mounted) {
          emit(GetLocationDone(placeMark));
        } else {
          emit(GetLocationError());
        }
      } catch (e) {
        emit(GetLocationError());
      }
    }
  }


  /// open app settings if the user doesn't allow permission
  Future<void> accessDeniedLocation({required BuildContext context}) async {
    LocationPermission? permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
    }
  }
}
