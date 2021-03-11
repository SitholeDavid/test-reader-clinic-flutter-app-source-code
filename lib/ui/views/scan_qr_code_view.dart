import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/scan_qr_code_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_button.dart';

class ScanQRCodeView extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanQRCodeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      child: QRView(
                          overlay: QrScannerOverlayShape(
                              borderColor: Colors.white,
                              overlayColor: Colors.black38),
                          key: qrKey,
                          onQRViewCreated: model.onQRViewCreated)),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 110,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: model.qrCodeScanned
                                ? Colors.green
                                : Colors.orangeAccent),
                        child: model.qrCodeScanned
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'QR code scanned',
                                    style: mediumTextFont,
                                  ),
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Icon(
                                    MaterialCommunityIcons
                                        .checkbox_marked_circle_outline,
                                    color: Colors.greenAccent,
                                  )
                                ],
                              )
                            : Text(
                                model.resultText,
                                style: mediumTextFont,
                              ),
                      )),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white70,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          child: customButton(
                              'Continue', model.navigateToScanResult,
                              enabled: model.qrCodeScanned)))
                ],
              ),
            ),
        viewModelBuilder: () => ScanQRCodeViewModel());
  }
}
