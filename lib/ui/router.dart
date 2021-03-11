import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_reader_clinic_app/core/models/test_result.dart';
import 'package:test_reader_clinic_app/ui/views/analyze_results_view.dart';
import 'package:test_reader_clinic_app/ui/views/dashboard_view.dart';
import 'package:test_reader_clinic_app/ui/views/final_result_view.dart';
import 'package:test_reader_clinic_app/ui/views/my_results_view.dart';
import 'package:test_reader_clinic_app/ui/views/scan_qr_code_view.dart';
import 'package:test_reader_clinic_app/ui/views/scan_test_result_view.dart';
import 'package:test_reader_clinic_app/ui/views/sign_in_view.dart';
import 'package:test_reader_clinic_app/ui/views/sign_up_view.dart';
import 'package:test_reader_clinic_app/ui/views/startup_view.dart';
import 'package:test_reader_clinic_app/ui/views/test_result_detail_view.dart';

import 'constants/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case StartupViewRoute:
      return MaterialPageRoute(builder: (_) => StartupView());
    case SignInViewRoute:
      return MaterialPageRoute(builder: (_) => SignInView());
    case SignUpViewRoute:
      return MaterialPageRoute(builder: (_) => SignUpView());
    case DashboardViewRoute:
      return MaterialPageRoute(builder: (_) => DashboardView());
    case ScanQRCodeViewRoute:
      return MaterialPageRoute(builder: (_) => ScanQRCodeView());
    case ScanTestResultViewRoute:
      List<String> qrResult = settings.arguments as List<String>;
      return MaterialPageRoute(
          builder: (_) => ScanTestResultView(
                qrResult: qrResult,
              ));
    case FinalResultViewRoute:
      Map<String, dynamic> results = settings.arguments as Map<String, dynamic>;
      List<String> qrResult = results['qrResult'] as List<String>;
      bool testResult = results['testResult'] as bool;
      String imageUrl = results['testResultPictureUrl'] as String;

      return MaterialPageRoute(
          builder: (_) => FinalResultView(
                qrResult: qrResult,
                testResult: testResult,
                imageUrl: imageUrl,
              ));
    case MyResultsViewRoute:
      return MaterialPageRoute(builder: (_) => MyResultsView());
    case TestResultDetailViewRoute:
      TestResult selectedTestResult = settings.arguments as TestResult;
      return MaterialPageRoute(
          builder: (_) =>
              TestResultDetailView(selectedTestResult: selectedTestResult));
    case AnalyzeResultsViewRoute:
      return MaterialPageRoute(builder: (_) => AnalyzeResultsView());
    default:
      return null;
  }
}
