import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';

import '../../locator.dart';

class ScanQRCodeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  String resultText = 'Scanning QR Code..';
  QRViewController _controller;
  List<String> qrResult;
  bool qrCodeScanned = false;

  void onQRViewCreated(QRViewController controller) async {
    _controller = controller;
    _controller.scannedDataStream.listen((onQRCodeDetected));
  }

  void onQRCodeDetected(Barcode barcode) async {
    qrResult = barcode.code.split('-');
    print(qrResult);
    if (qrResult.length != 3) {
      resultText = 'Invalid QR Code';
      qrCodeScanned = false;
    } else
      qrCodeScanned = true;

    notifyListeners();
  }

  void disposeController() => _controller?.dispose();

  void navigateToScanResult() {
    disposeController();
    _navigationService.replaceWith(ScanTestResultViewRoute,
        arguments: qrResult);
  }
}
