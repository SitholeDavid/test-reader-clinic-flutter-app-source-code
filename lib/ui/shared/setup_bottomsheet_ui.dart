import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/locator.dart';
import 'package:test_reader_clinic_app/ui/constants/enums.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_button.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_input_field.dart';

void setupBottomSheetUi() {
  final BottomSheetService bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.enterEmail: (context, sheetRequest, completer) =>
        _EnterEmailBottomSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _EnterEmailBottomSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'please enter a valid email address')
  ]);

  _EnterEmailBottomSheet({
    Key key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Export data to..',
                  style: mediumTextFont.copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => completer(SheetResponse(confirmed: false)),
                  child: Text(
                    'Cancel',
                    style: mediumTextFont.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                )
              ],
            ),
            mediumSpace,
            Form(
              key: _formKey,
              child: customInputField(
                  controller: emailController,
                  hint: 'Enter recepient email address',
                  inputType: TextInputType.emailAddress,
                  validator: emailValidator),
            ),
            mediumSpace,
            customButton('Send data', () {
              if (_formKey.currentState.validate()) {
                completer(SheetResponse(
                    confirmed: true,
                    responseData: {'email': emailController.text}));
              }
            })
          ],
        ),
      ),
    );
  }
}
