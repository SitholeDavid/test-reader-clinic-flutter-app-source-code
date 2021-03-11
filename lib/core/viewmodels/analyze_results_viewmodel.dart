import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service_interface.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service_interface.dart';
import 'package:test_reader_clinic_app/core/services/location_service/location_service.dart';
import 'package:test_reader_clinic_app/core/services/location_service/location_service_interface.dart';
import 'package:test_reader_clinic_app/locator.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';

class AnalyzeResultsViewModel extends BaseViewModel {
  LocationService _locationService = locator<LocationServiceInterface>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthServiceInterface>();
  FirestoreService _firestoreService = locator<FirestoreServiceInterface>();

  int analysisOption = 0;
  LatLng currentLocation;
  // BitmapDescriptor positiveMarker;
  // BitmapDescriptor negativeMarker;
  List<Marker> markers = <Marker>[];
  List<TestResult> results;
  CameraPosition initialCameraPosition;
  GoogleMapController controller;

  void initialise() async {
    setBusy(true);

    await getPermissions();

    var myLocation = await _locationService.getCurrentLocation();
    var myProfile = await _authService.getCurrentUser();
    results = await _firestoreService.getClinicResults(myProfile.clinicID);
    generateMarkers();

    currentLocation = LatLng(myLocation.latitude, myLocation.longitude);
    initialCameraPosition =
        CameraPosition(target: currentLocation, zoom: 14.4746);

    setBusy(false);
  }

  void generateMarkers() {
    List<TestResult> filteredResults = <TestResult>[];

    switch (analysisOption) {
      case 0:
        filteredResults = results;
        break;
      case 1:
        filteredResults = results.where((result) => result.isPositive).toList();
        break;
      case 2:
        filteredResults =
            results.where((result) => !result.isPositive).toList();
        break;
      default:
        filteredResults = results;
    }

    markers = filteredResults.map((result) {
      final MarkerId markerId = MarkerId(DateTime.now().toString());
      final double lat =
          double.parse(result.gpsLocation.split(',').first.trim());
      final double lon =
          double.parse(result.gpsLocation.split(',').last.trim());
      final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(lat, lon),
          onTap: () => navigateToTestResultDetail(result: result),
          infoWindow: InfoWindow(title: result.name),
          icon: BitmapDescriptor.defaultMarkerWithHue(result.isPositive
              ? BitmapDescriptor.hueGreen
              : BitmapDescriptor.hueRed));

      return marker;
    }).toList();

    notifyListeners();
  }

  void selectAnalysisOption(int index) {
    analysisOption = index;
    generateMarkers();
  }

  void navigateToTestResultDetail({TestResult result}) => _navigationService
      .navigateTo(TestResultDetailViewRoute, arguments: result);

  Future getPermissions() async {
    while (!_locationService.hasPermission) {
      await _locationService.requestLocationPermissions();
      if (!_locationService.hasPermission) {
        _snackbarService.showSnackbar(
            message: 'Location permission is required');
      }
    }

    return;
  }

/*
  Future generateMapIconMarkers() async {
    MarkerGenerator generator = MarkerGenerator(400);

    positiveMarker = await generator.createBitmapDescriptorFromIconData(
        MaterialCommunityIcons.test_tube,
        Colors.greenAccent,
        Colors.transparent,
        Colors.transparent);

    negativeMarker = await generator.createBitmapDescriptorFromIconData(
        MaterialCommunityIcons.test_tube,
        Colors.greenAccent,
        Colors.transparent,
        Colors.transparent);
  }
*/
  void onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }
}
