import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';
import 'package:test_reader_clinic_app/core/viewmodels/my_results_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/margins.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';

class MyResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyResultsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: pageHorizontalMargin,
                        vertical: pageVerticalMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        largeSpace,
                        Text(
                          'Patient Results',
                          style: largeTextFont,
                        ),
                        mediumSpace,
                        model.isBusy
                            ? emptySpace
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  TestResult result = model.myResults[index];

                                  return ListTile(
                                    onTap: () =>
                                        model.navigateToTestResultDetailView(
                                            index: index),
                                    leading: Icon(
                                      MaterialCommunityIcons.test_tube,
                                      size: 40,
                                      color: result.isPositive
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          result.name,
                                          style: mediumTextFont.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          result.testID,
                                          style: mediumTextFont.copyWith(
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          result.date,
                                          style: smallTextFont,
                                        ),
                                        Text(
                                          "Test ID",
                                          style: smallTextFont,
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: model.myResults.length,
                                shrinkWrap: true,
                              )
                      ],
                    ),
                  ),
                  loadingIndicator(model.isBusy, 'Fetching results..')
                ],
              ),
            ),
        onModelReady: (model) => model.initialise(),
        viewModelBuilder: () => MyResultsViewModel());
  }
}
