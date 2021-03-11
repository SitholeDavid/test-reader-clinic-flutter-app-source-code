import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';

Widget loadingIndicator(bool isLoading, String loadingText) {
  return isLoading
      ? Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black54.withOpacity(0.75),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 40,
                  child: SpinKitFadingCube(
                    color: Colors.white60,
                  ),
                ),
                mediumSpace,
                Text(
                  loadingText,
                  style: mediumTextFont.copyWith(
                      color: Colors.white70, fontSize: 15, letterSpacing: 2.5),
                )
              ],
            ),
          ),
        )
      // ignore: unnecessary_statements
      : smallSpace;
}

Widget loadingIndicatorLight(bool isLoading, String loadingText) {
  return isLoading
      ? Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 50,
                  child: SpinKitFadingCube(
                    color: Colors.white60,
                  ),
                ),
                mediumSpace,
                Text(
                  loadingText,
                  style: mediumTextFont.copyWith(
                      letterSpacing: 2, color: Colors.black54, fontSize: 13),
                )
              ],
            ),
          ),
        )
      // ignore: unnecessary_statements
      : smallSpace;
}
