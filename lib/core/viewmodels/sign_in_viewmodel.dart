import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service_interface.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';

import '../../locator.dart';

class SignInViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthServiceInterface>();
  final NavigationService _navService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  Future signIn({String email, String password}) async {
    setBusy(true);
    var success = await _authService.signInWithEmail(email, password);
    setBusy(false);

    if (success) {
      //navigate to dashboard
      await _navService.clearStackAndShow(DashboardViewRoute);
    } else {
      //show failure snackbar
      _snackbarService.showSnackbar(
          message: 'Login failed. Please check your email and/or password.',
          duration: Duration(seconds: 3));
    }
  }

  void navigateToSignUp() {
    _navService.navigateTo(SignUpViewRoute);
  }
}
