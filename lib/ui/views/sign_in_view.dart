import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/sign_in_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/margins.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_button.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_input_field.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';

class SignInView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: pageVerticalMargin,
                          horizontal: pageHorizontalMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                extraLargeSpace,
                                Text(
                                  'Sign In',
                                  style: largeTextFont,
                                  textAlign: TextAlign.start,
                                ),
                                largeSpace,
                                customInputField(
                                    controller: _emailController,
                                    hint: 'Enter email',
                                    inputType: TextInputType.emailAddress,
                                    validator: emailValidator),
                                mediumSpace,
                                customInputField(
                                    controller: _passwordController,
                                    hint: 'Password',
                                    inputType: TextInputType.visiblePassword,
                                    validator: passwordValidator),
                                extraLargeSpace,
                                customButton('Sign in', () {
                                  if (_formKey.currentState.validate()) {
                                    model.signIn(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                  }
                                }),
                                mediumSpace,
                                GestureDetector(
                                  onTap: model.navigateToSignUp,
                                  child: Text(
                                    'Don\'t have an account? Sign up',
                                    textAlign: TextAlign.center,
                                    style: mediumTextFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  loadingIndicator(model.isBusy, 'Signing in..')
                ],
              ),
            ),
        viewModelBuilder: () => SignInViewModel());
  }
}
