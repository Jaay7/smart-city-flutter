import 'package:flutter/material.dart';

BoxDecoration textFieldBoxDecoration() {
  return const BoxDecoration(
    // color: Color(0xFFFEDBD0),
      boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(
          0.0,
          0.0,
        ),
        blurRadius: 8.0,
        spreadRadius: 0.5,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ),
    ],
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    border: InputBorder.none,
    // isDense: true,
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black87, fontSize: 16);
}
TextStyle mediumTextStyle() {
  return TextStyle(color: Color(0xFF545454), fontSize: 16);
}