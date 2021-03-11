import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/services/camera_service/camera_service.dart';
import 'package:test_reader_clinic_app/core/services/camera_service/camera_service_interface.dart';
import 'package:test_reader_clinic_app/core/services/cloud_storage_service/cloud_storage_service.dart';
import 'package:test_reader_clinic_app/core/services/cloud_storage_service/cloud_storage_service_interface.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';

import '../../locator.dart';

class ScanTestResultViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final CameraService _cameraService = locator<CameraServiceInterface>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageServiceInterface>();

  List<String> qrResult;
  CameraPreview preview;
  bool testResultScanned = false;
  bool testResult = false;
  Timer timer;
  String loadingText = 'Preparing camera..';

  void initialise(List<String> result) async {
    preview = await _cameraService.getCameraPreview();
    qrResult = result;
    print(qrResult);
    notifyListeners();

    timer = Timer.periodic(Duration(seconds: 2), (_) {
      testResultScanned = true;
      testResult = !testResult;
      notifyListeners();
    });
  }

  Future<String> scanResult() async {
    Uint8List file = await _cameraService.takePicture();
    String fileName = DateTime.now().toIso8601String();
    return await _cloudStorageService.uploadTestResultPicture(file, fileName);
  }

  void navigateToFinalResult() async {
    loadingText = 'Saving test picture..';

    setBusy(true);
    timer?.cancel();
    String testPicUrl = await scanResult();
    setBusy(false);

    _navigationService
        .replaceWith(FinalResultViewRoute, arguments: <String, dynamic>{
      'qrResult': qrResult,
      'testResult': testResult,
      'testResultPictureUrl': testPicUrl
    });
  }
}
