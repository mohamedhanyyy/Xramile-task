import 'package:geocoding/geocoding.dart';
/// all states of user location
abstract class MyLocationState {}

class GetLocationInitial extends MyLocationState {}

class GetLocationLoading extends MyLocationState {}

class GetLocationError extends MyLocationState {}

class GetLocationDone extends MyLocationState {
  Placemark? mark;

  GetLocationDone(this.mark);
}
