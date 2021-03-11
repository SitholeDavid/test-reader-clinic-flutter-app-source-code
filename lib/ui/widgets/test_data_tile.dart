import 'package:flutter/material.dart';
import 'package:test_reader_clinic_app/ui/constants/text_sizes.dart';
import 'package:test_reader_clinic_app/ui/constants/ui_helpers.dart';

Widget testDataTile({String field, String fieldValue}) {
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
        Text(
          fieldValue,
          style: mediumTextFont.copyWith(fontWeight: FontWeight.bold),
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
