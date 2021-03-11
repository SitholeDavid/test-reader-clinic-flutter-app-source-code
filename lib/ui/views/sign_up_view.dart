import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/sign_up_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/margins.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_button.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_input_field.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    EmailValidator(errorText: 'please enter a valid email address')
  ]);

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'Name is required'),
    MinLengthValidator(3, errorText: 'Name must be at least 3 characters long')
  ]);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: pageVerticalMargin,
                          horizontal: pageHorizontalMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                extraLargeSpace,
                                Text(
                                  'Sign Up Your Clinic',
                                  style: largeTextFont,
                                  textAlign: TextAlign.start,
                                ),
                                extraLargeSpace,
                                customInputField(
                                    controller: _nameController,
                                    hint: 'Enter the name of your clinic',
                                    validator: nameValidator),
                                mediumSpace,
                                customInputField(
                                    controller: _emailController,
                                    hint: 'Enter your clinic\'s email address',
                                    inputType: TextInputType.emailAddress,
                                    validator: emailValidator),
                                mediumSpace,
                                customInputField(
                                    controller: _passwordController,
                                    hint: 'Enter your password',
                                    inputType: TextInputType.visiblePassword,
                                    validator: passwordValidator),
                                mediumSpace,
                                customInputField(
                                    controller: _confirmPasswordController,
                                    hint: 'Confirm password',
                                    inputType: TextInputType.visiblePassword,
                                    validator: (val) => MatchValidator(
                                            errorText: 'passwords do not match')
                                        .validateMatch(
                                            val, _passwordController.text)),
                              ],
                            ),
                          ),
                          largeSpace,
                          customButton('Sign up', () {
                            if (_formKey.currentState.validate()) {
                              model.signUp(
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  password: _passwordController.text);
                            }
                          }),
                          mediumSpace
                        ],
                      ),
                    ),
                    loadingIndicator(model.isBusy, 'Signing you up..')
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => SignUpViewModel());
  }
}
