import 'package:camera/camera.dart';

abstract class CameraServiceInterface {
  Future<List<CameraDescription>> getAvailableCameras();
  Future<CameraDescription> getFirstCamera();
  Future<void> initializeController();
  Future<void> createCameraController();
  Future<CameraPreview> getCameraPreview();
  Future<void> dispose();
  Future<dynamic> takePicture();
}
