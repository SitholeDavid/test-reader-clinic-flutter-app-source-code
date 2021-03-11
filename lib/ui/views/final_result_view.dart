import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/final_result_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/margins.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_button.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_input_field.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';
import 'package:test_reader_clinic_app/ui/widgets/test_data_tile.dart';

class FinalResultView extends StatelessWidget {
  final List<String> qrResult;
  final bool testResult;
  final String imageUrl;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _patientIDController = TextEditingController();

  final surnameValidator = MultiValidator([
    RequiredValidator(errorText: 'Surname is required'),
    MinLengthValidator(2,
        errorText: 'Surname must be at least 2 characters long')
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name is required'),
    MinLengthValidator(2, errorText: 'Name must be at least 2 characters long')
  ]);

  FinalResultView(
      {@required this.qrResult,
      @required this.testResult,
      @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinalResultViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: pageHorizontalMargin,
                          vertical: pageVerticalMargin),
                      child: model.result == null
                          ? Container(
                              child: smallSpace,
                            )
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
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                            fieldValue: model.result.isPositive
                                                ? 'Positive (+)'
                                                : 'Negative (-)'),
                                      )
                                    ],
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
                                    field: 'Location',
                                    fieldValue: model.result.gpsLocation),
                                largeSpace,
                                Container(
                                  width: double.maxFinite,
                                  child: Text(
                                    'Patient Data',
                                    style: largeTextFont,
                                  ),
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        customTileInputField(
                                            controller: _nameController,
                                            validator: nameValidator,
                                            field: 'Patient name',
                                            hint: 'Enter the patient' 's name'),
                                        customTileInputField(
                                            controller: _surnameController,
                                            validator: surnameValidator,
                                            field: 'Patient surname',
                                            hint: 'Enter the patient'
                                                's surname'),
                                        customTileInputField(
                                            controller: _patientIDController,
                                            validator: null,
                                            field: 'Patient ID',
                                            hint: 'Enter the patient'
                                                's ID (optional)'),
                                      ],
                                    )),
                                largeSpace,
                                customButton(
                                    'Save Results',
                                    model.result == null
                                        ? null
                                        : () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              model.saveResult(
                                                  patientID:
                                                      _patientIDController.text,
                                                  patientName:
                                                      _nameController.text,
                                                  patientSurname:
                                                      _surnameController.text);
                                            }
                                          })
                              ],
                            ),
                    ),
                  ),
                  loadingIndicator(model.result == null, 'Finalizing results'),
                  loadingIndicator(model.isBusy, 'Uploading results..')
                ],
              ),
            ),
        onModelReady: (model) =>
            model.initialise(qrResult, testResult, imageUrl),
        viewModelBuilder: () => FinalResultViewModel());
  }
}
