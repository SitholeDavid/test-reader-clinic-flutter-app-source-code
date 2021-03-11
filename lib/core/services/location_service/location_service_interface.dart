import 'package:location/location.dart';

abstract class LocationServiceInterface {
  Future initialise();
  Future<LocationData> getCurrentLocation();
  Future requestLocationPermissions();
  Future dispose();
}
