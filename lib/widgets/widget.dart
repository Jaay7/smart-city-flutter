import 'package:flutter/material.dart';

BoxDecoration textFieldBoxDecoration() {
  return const BoxDecoration(
    color: Color(0x10f1f1f1),
      boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(
          0.0,
          3.0,
        ),
        blurRadius: 8.0,
        spreadRadius: 0.5,
      ),
      BoxShadow(
        color: Color(0x90FFFFFF),
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
    hintStyle: TextStyle( color: Colors.black45, ),
    border: InputBorder.none,
    // isDense: true,
  );
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.black87, fontSize: 16);
}
TextStyle mediumTextStyle() {
  return TextStyle(color: Color(0xFF323232), fontSize: 16);
}