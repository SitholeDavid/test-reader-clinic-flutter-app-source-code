import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_reader_clinic_app/ui/constants/colors.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';

Widget customInputField(
    {String hint,
    TextEditingController controller,
    TextInputType inputType,
    Function validator}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
        color: HexColor('#3b3941').withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white70, width: 0.3)),
    child: TextFormField(
      validator: validator,
      keyboardType: inputType,
      controller: controller,
      obscureText: inputType == TextInputType.visiblePassword,
      style: smallTextFont.copyWith(color: Colors.black87, fontSize: 14),
      decoration: InputDecoration(
        hintStyle: smallTextFont.copyWith(color: Colors.black45),
        hintText: hint ?? '',
        border: UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}

Widget customTileInputField(
    {String hint,
    String field,
    TextEditingController controller,
    TextInputType inputType,
    Function validator}) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200], width: 2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: validator,
          keyboardType: inputType,
          controller: controller,
          obscureText: inputType == TextInputType.visiblePassword,
          style: smallTextFont.copyWith(color: Colors.black87, fontSize: 14),
          decoration: InputDecoration(
            hintStyle: smallTextFont.copyWith(color: Colors.black45),
            hintText: hint ?? '',
            border: UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
        smallSpace,
        Text(
          field,
          style: smallTextFont,
        )
      ],
    ),
  );
}
