import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/scan_test_result_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_button.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';

class ScanTestResultView extends StatefulWidget {
  final List<String> qrResult;

  ScanTestResultView({this.qrResult});

  @override
  _ScanTestResultViewState createState() => _ScanTestResultViewState();
}

class _ScanTestResultViewState extends State<ScanTestResultView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanTestResultViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: model.preview == null
                  ? loadingIndicator(true, 'Preparing camera..')
                  : Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: model.preview,
                        ),
                        Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.maxFinite,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical:
                                      MediaQuery.of(context).size.height / 3),
                              decoration: BoxDecoration(color: Colors.white30),
                            )),
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
                                  color: model.testResultScanned
                                      ? (model.testResult
                                          ? Colors.green
                                          : Colors.redAccent)
                                      : Colors.orangeAccent),
                              child: model.testResultScanned
                                  ? Text(
                                      model.testResult
                                          ? 'Test Result:  Positive'
                                          : 'Test Result:  Negative',
                                      style: mediumTextFont,
                                    )
                                  : Text(
                                      'Scanning Test Result..',
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
                                    'Continue', model.navigateToFinalResult,
                                    enabled: model.testResultScanned))),
                        loadingIndicator(model.isBusy, model.loadingText)
                      ],
                    ),
            ),
        onModelReady: (model) => model.initialise(widget.qrResult),
        viewModelBuilder: () => ScanTestResultViewModel());
  }
}
