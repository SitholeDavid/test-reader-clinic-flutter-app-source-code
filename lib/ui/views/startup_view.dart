import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/startup_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.greenAccent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lateral Flow Reader',
                          style: headerTextFont.copyWith(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        largeSpace,
                        Container(
                            width: 50,
                            height: 50,
                            child: SpinKitFoldingCube(
                              color: Colors.white60,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
        onModelReady: (model) => model.startupLogic(),
        viewModelBuilder: () => StartupViewModel());
  }
}
