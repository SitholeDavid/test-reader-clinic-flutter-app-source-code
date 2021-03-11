import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service.dart';
import 'package:test_reader_clinic_app/core/services/auth_service/auth_service_interface.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service.dart';
import 'package:test_reader_clinic_app/core/services/firestore_service/firestore_service_interface.dart';
import 'package:test_reader_clinic_app/ui/constants/enums.dart';
import 'package:test_reader_clinic_app/ui/constants/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

import '../../locator.dart';

class DashboardViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final FirestoreService _firestoreService =
      locator<FirestoreServiceInterface>();
  final AuthService _authService = locator<AuthServiceInterface>();

  void navigateToScanQRCodeView() =>
      _navigationService.navigateTo(ScanQRCodeViewRoute);

  void navigateToMyResultsView() =>
      _navigationService.navigateTo(MyResultsViewRoute);

  void navigateToAnalyzeResultsView() =>
      _navigationService.navigateTo(AnalyzeResultsViewRoute);

  void showEmailBottomSheet() async {
    var result = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.enterEmail);

    if (result.confirmed) {
      setBusy(true);

      String recepientEmail = result.responseData['email'];
      String clinicID = (await _authService.getCurrentUser()).clinicID;
      List<TestResult> patientResults =
          await _firestoreService.getClinicResults(clinicID);

      if (patientResults.isEmpty) {
        setBusy(false);
        return _snackbarService.showSnackbar(
            message: 'No patient results to send');
      }
      var patientJson =
          patientResults.map((result) => result.toJson()).toList();
      var attachmentJson = JsonEncoder().convert(patientJson);

      final MailOptions mailOptions = MailOptions(
          body: attachmentJson,
          subject: 'Patient JSON Data',
          recipients: [recepientEmail]);

      setBusy(false);

      await FlutterMailer.send(mailOptions);
    }
  }

  void signOut() async {
    await _authService.signOut();
    _navigationService.clearStackAndShow(SignInViewRoute);
  }
}
