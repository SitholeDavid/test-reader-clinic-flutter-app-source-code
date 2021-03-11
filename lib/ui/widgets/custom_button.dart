import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';

Widget dialogButton(String buttonText, Function onTapCallback) {
  return FlatButton(
      onPressed: onTapCallback,
      padding: EdgeInsets.all(0),
      child: Container(
          height: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.all(0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: smallTextFont.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          )));
}

Widget dialogButtonLight(String buttonText, Function onTapCallback) {
  return FlatButton(
      onPressed: onTapCallback,
      padding: EdgeInsets.all(0),
      child: Container(
          height: 50,
          alignment: Alignment.center,
          margin: EdgeInsets.all(0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: smallTextFont.copyWith(
                color: Colors.black87, fontWeight: FontWeight.bold),
          )));
}

Widget customButton(String buttonText, Function onTapCallback,
    {bool darkMode = false, enabled = true}) {
  return FlatButton(
      onPressed: enabled ? onTapCallback : null,
      padding: EdgeInsets.all(0),
      child: Container(
          height: 65,
          alignment: Alignment.center,
          margin: EdgeInsets.all(0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: darkMode ? Colors.white70 : Colors.black54,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: smallTextFont.copyWith(
                color: darkMode ? Colors.black : Colors.white70,
                fontWeight: FontWeight.bold),
          )));
}
