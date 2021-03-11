import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';
import 'package:test_reader_clinic_app/core/viewmodels/test_result_detail_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/margins.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';
import 'package:test_reader_clinic_app/ui/widgets/test_data_tile.dart';

class TestResultDetailView extends StatelessWidget {
  final TestResult selectedTestResult;

  TestResultDetailView({@required this.selectedTestResult});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestResultDetailViewModel>.nonReactive(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: pageHorizontalMargin,
                          vertical: pageVerticalMargin),
                      child: model.result == null
                          ? emptySpace
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                largeSpace,
                                Text(
                                  'Test results',
                                  style: largeTextFont,
                                ),
                                smallSpace,
                                Text(
                                  model.result.date,
                                  style: smallTextFont,
                                ),
                                mediumSpace,
                                GestureDetector(
                                  onTap: model.showTestResultImage,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(MaterialCommunityIcons.test_tube,
                                            size: 40,
                                            color: model.result.isPositive
                                                ? Colors.green
                                                : Colors.redAccent),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: testDataTile(
                                              field: 'Test result',
                                              fieldValue:
                                                  model.result.isPositive
                                                      ? 'Positive'
                                                      : 'Negative'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                testDataTile(
                                    field: 'Test ID',
                                    fieldValue: model.result.testID),
                                testDataTile(
                                    field: 'Sample ID',
                                    fieldValue: model.result.sampleID),
                                testDataTile(
                                    field: 'Lot ID',
                                    fieldValue: model.result.lotID),
                                testDataTile(
                                    field: 'Patient ID',
                                    fieldValue: model.result.patientID),
                                testDataTile(
                                    field: 'Patient name',
                                    fieldValue: model.result.name),
                                testDataTile(
                                    field: 'Patient surname',
                                    fieldValue: model.result.surname),
                                testDataTile(
                                    field: 'Location',
                                    fieldValue: model.result.gpsLocation),
                              ],
                            ),
                    ),
                  ),
                  loadingIndicatorLight(
                      model.result == null, 'Finalizing results'),
                  loadingIndicator(model.isBusy, 'Displaying result..')
                ],
              ),
            ),
        viewModelBuilder: () {
          print(selectedTestResult);
          return TestResultDetailViewModel(result: selectedTestResult);
        });
  }
}
