import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service_interface.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service_interface.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';

import '../../locator.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthServiceInterface>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService =
      locator<FirestoreServiceInterface>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  Future<void> signUp({String email, String password, String name}) async {
    setBusy(true);

    bool nameExists = await _firestoreService.clinicExists(name);

    if (nameExists) {
      setBusy(false);
      return _snackbarService.showSnackbar(
          message: 'This clinic name is already in use');
    }

    var success = await _authService.signUpWithEmail(email, password, name);

    setBusy(false);
    if (success) {
      _snackbarService.showSnackbar(
          message: 'Sign up successful', duration: Duration(seconds: 2));

      Future.delayed(Duration(seconds: 2),
          () => _navigationService.clearStackAndShow(DashboardViewRoute));
    } else {
      _snackbarService.showSnackbar(
          message: 'Sign up failed. Please check your details and try again',
          duration: Duration(seconds: 2));
    }
  }
}
