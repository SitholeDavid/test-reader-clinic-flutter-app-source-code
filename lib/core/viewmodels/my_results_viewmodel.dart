import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/models/clinic.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service_interface.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service_interface.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';

import '../../locator.dart';

class MyResultsViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthServiceInterface>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService =
      locator<FirestoreServiceInterface>();

  List<TestResult> myResults;

  void initialise() async {
    setBusy(true);
    Clinic myProfile = await _authService.getCurrentUser();
    myResults = await _firestoreService.getClinicResults(myProfile.clinicID);
    setBusy(false);
  }

  void navigateToTestResultDetailView({int index}) {
    _navigationService.navigateTo(TestResultDetailViewRoute,
        arguments: myResults[index]);
  }
}
