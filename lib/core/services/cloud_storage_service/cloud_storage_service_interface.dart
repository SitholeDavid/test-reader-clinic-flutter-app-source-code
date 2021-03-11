import 'dart:io';

import 'dart:typed_data';

abstract class CloudStorageServiceInterface {
  Future<String> uploadTestResultPicture(Uint8List file, String fileName);
}
