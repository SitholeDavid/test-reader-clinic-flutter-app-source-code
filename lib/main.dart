import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_reader_clinic_app/ui/router.dart';
import 'package:test_reader_clinic_app/ui/shared/setup_bottomsheet_ui.dart';
import 'package:test_reader_clinic_app/ui/shared/setup_dialog_ui.dart';
import 'package:test_reader_clinic_app/ui/views/startup_view.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: generateRoute,
      navigatorKey: StackedService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StartupView(),
    );
  }
}
