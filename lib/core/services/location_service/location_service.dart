import 'package:location/location.dart';
import 'package:test_reader_clinic_app/core/services/location_service/location_service_interface.dart';

class LocationService extends LocationServiceInterface {
  final Location _location = Location();
  bool isEnabled = false;
  bool hasPermission = false;

  @override
  Future dispose() async {}

  @override
  Future<LocationData> getCurrentLocation() async {
    return await _location.getLocation();
  }

  @override
  Future initialise() async {
    if (!isEnabled) {
      isEnabled = await _location.requestService();
    }
  }

  @override
  Future requestLocationPermissions() async {
    if (!hasPermission) {
      hasPermission =
          (await _location.requestPermission()) == PermissionStatus.granted;
    }
  }
}
