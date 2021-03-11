import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_reader_clinic_app/core/services/cloud_storage_service/cloud_storage_service_interface.dart';

class CloudStorageService extends CloudStorageServiceInterface {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> uploadTestResultPicture(
      Uint8List file, String fileName) async {
    try {
      fileName = 'clients/$fileName';
      var uploadRef = _storage.ref().child(fileName);
      await uploadRef.putData(file);
      var downloadUrl = await uploadRef.getDownloadURL();

      return downloadUrl.toString();
    } catch (e) {
      return '';
    }
  }
}
