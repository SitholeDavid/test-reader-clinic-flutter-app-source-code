import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:test_reader_clinic_app/core/viewmodels/analyze_results_viewmodel.dart';
import 'package:test_reader_clinic_app/ui/constants/enums.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/widgets/custom_loading_indicator.dart';

class AnalyzeResultsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AnalyzeResultsViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: model.isBusy
                  ? loadingIndicator(true, 'Loading map..')
                  : Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: GoogleMap(
                              onMapCreated: model.onMapCreated,
                              markers: model.markers.toSet(),
                              initialCameraPosition:
                                  model.initialCameraPosition),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 20,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 80,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return _analysisOption(
                                      option: analysisOptions[index],
                                      isSelected: index == model.analysisOption,
                                      count: model.markers == null
                                          ? ''
                                          : ' (${model.markers.length.toString()})',
                                      onSelectCallback: () =>
                                          model.selectAnalysisOption(index));
                                },
                                itemCount: analysisOptions.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                              ),
                            ))
                      ],
                    ),
            ),
        onModelReady: (model) => model.initialise(),
        viewModelBuilder: () => AnalyzeResultsViewModel());
  }

  Widget _analysisOption(
      {String option,
      bool isSelected,
      Function onSelectCallback,
      String count}) {
    return GestureDetector(
      onTap: onSelectCallback,
      child: Container(
        margin: EdgeInsets.only(bottom: 20, left: 15),
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: isSelected
                ? Border.all(color: Colors.greenAccent, width: 4)
                : null),
        child: Text(
          option + (isSelected ? count : ''),
          style: mediumTextFont.copyWith(color: Colors.black87),
        ),
      ),
    );
  }
}
